require('dotenv').config();
const userRepository = require('../repository/user');
const patientRepository = require('../repository/patient');
const followRepository = require('../repository/follow');
const jwt = require('jsonwebtoken');

async function loginHandler(queryResult, res) {
    if (queryResult.success) {
        if (queryResult.data.length === 0) {
            res.status(401).json({ error: 'Invalid email or password' });
        }
        else {
            const data = queryResult.data[0];
            let options = {
                maxAge: 1000 * 60 * 60 * 24 * 7, // would expire after 7 days
                httpOnly: true, // The cookie only accessible by the web server
            };
            const token = jwt.sign({ id: data.id }, process.env.JWT_ACCESS_TOKEN);
            res.cookie('auth-token', token, options);
            res.status(200).json({
                id: data.id,
                name: data.name,
                role: data.role,
                token: token
            });
        }
    } else {
        res.status(500).json({ error: "Internal server error" });
    }
}

async function login(req, res) {
    const { email, password } = req.body;
    const result = await userRepository.login(email, password);
    loginHandler(result, res);
}

async function logout(req, res) {
    res.clearCookie('auth-token');
    res.status(200).json({ message: 'Logout successfully' });
}

async function register(req, res) {
    const { name, email, password, role } = req.body;
    let rr = 0;
    if (role == "Doctor")
        rr = 2;
    else if (role == "Patient")
        rr = 1;
    const result = await userRepository.register(name, email, password, rr);
    loginHandler(result, res);
}

async function getSelfProfile(req, res) {
    const { id } = req.user;
    const result = await userRepository.getUserById(id);
    if (!result.success) {
        res.status(500).json({ error: "Internal server error" });
        return;
    }
    res.status(200).json(result.data[0]);
    return;
}

async function getUserById(req, res) {
    const { id } = req.params;
    if (id === req.user['id']) {
        res.redirect(301, '/user/profile');
        return;
    }
    const result = await userRepository.getUserById(id);
    if (!result.success) {
        res.status(500).json({ error: "Internal server error" });
        return;
    }
    if (result.data.length === 0) {
        res.status(404).json({ error: "User not found" });
        return;
    }
    res.status(200).json(result.data[0]);
    return;
}

async function completePatientProfile(req, res) {
    const { id } = req.user;
    const patientQuery = await patientRepository.isProfileComplete(id);
    if (!patientQuery.success) {
        res.status(500).json({ error: "Internal server error" });
        return;
    }
    if (patientQuery.isComplete) {
        res.status(301).redirect('/user/profile');
        return;
    }
    const { type, diagnosis_date, diseases } = req.body;

    let diabetes_type;
    if (type.toLowerCase() === "type 1") {
        diabetes_type = 1;
    } else if (type.toLowerCase() === "type 2") {
        diabetes_type = 2;
    } else {
        diabetes_type = 0;
    }
    console.log(diseases);
    const disease_keys = JSON.parse(diseases).map(disease => disease.toLowerCase().replace(/ /g, '_'));
    console.log(disease_keys);
    let queryBody = {
        id,
        diabetes_type,
        diagnosis_date,
        coeliac_disease: false,
        thyroid_disease: false,
        hypertension: false,
        pcos: false,
        cataract: false,
        diabetes_insipidus: false,
        insulin_resistance: false,
    };
    const keys = Object.keys(queryBody);
    const hasInvalidKey = disease_keys.some(key => !keys.includes(key));
    if (hasInvalidKey) {
        res.status(400).json({ error: "Invalid key in diseases list" });
        return;
    }
    disease_keys.forEach(key => { queryBody[key] = true });

    const result = await patientRepository.completeProfile(queryBody);
    if (!result.success) {
        res.status(500).json({ error: "Internal server error: failed adding details" });
        return;
    }
    res.status(201).json({ message: "Patient details added successfully" });
}

async function completeDoctorProfile(req, res) {
    res.status(404).json({ error: "Not available" });
}

async function completeProfile(req, res) {
    const { role } = req.user;

    switch (role) {
        case 1:
            await completePatientProfile(req, res);
            break;
        case 2:
            await completeDoctorProfile(req, res);
            break;
        default:
            res.status(403).json({ error: "Forbidden" });
            break;;
    }
    return;
}

async function followUser(req, res) {
    const { id } = req.params;
    const { id: followerId } = req.user;
    const { follow } = req.body;
    if (id === followerId) {
        res.status(400).json({ error: "Cannot follow self" });
        return;
    }
    const userQuery = await userRepository.getUserById(id);
    if (!userQuery.success) {
        res.status(500).json({ error: "Internal server error" });
        return;
    }
    if (userQuery.data.length === 0) {
        res.status(404).json({ error: "User not found" });
        return;
    }
    const isFollowingQuery = await followRepository.isFollowing(followerId, id);
    if (!isFollowingQuery.success) {
        res.status(500).json({ error: "Internal server error" });
        return;
    }
    if (follow) {
        if (isFollowingQuery.isFollowing) {
            res.status(200).json({ message: "Already following" });
            return;
        }
        const result = await followRepository.followUser(followerId, id);
        if (!result.success) {
            res.status(500).json({ error: "Internal server error" });
            return;
        }
        res.status(200).json({ message: "Followed successfully" });
    }
    else {
        const result = await followRepository.unfollowUser(followerId, id);
        if (!result.success) {
            res.status(500).json({ error: "Internal server error" });
            return;
        }
        res.status(200).json({ message: "Unfollowed successfully" });
    }

    return;
}

module.exports = {
    login,
    logout,
    register,
    getSelfProfile,
    getUserById,
    completeProfile,
    followUser
};