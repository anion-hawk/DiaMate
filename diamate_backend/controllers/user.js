require('dotenv').config();
const userRepository = require('../repository/user');
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
    const result = await userRepository.register(name, email, password, role);
    loginHandler(result, res);
}

module.exports = {
    login,
    logout,
    register
};