const repository = require('./repository');

async function login(email, password) {
    const query = 'SELECT id, name, role FROM users WHERE email = $1 AND password = $2';
    const params = [email, password];
    const { success, data, error } = await repository.query(query, params);
    if (success) {
        return { success, data };
    }
    return { success, error };
}

async function register(name, email, uid, dob, role) {
    const query = 'INSERT INTO users(name, email, uid, dob, role) VALUES($1, $2, $3, $4, $5) RETURNING id, name, role';
    const params = [name, email, uid, dob, role];
    const { success, data, error } = await repository.query(query, params);
    if (success) {
        return { success, data };
    }
    return { success, error };
}

async function getUserById(id) {
    const query = 'SELECT id, name, role FROM users WHERE id = $1';
    const params = [id];
    const { success, data, error } = await repository.query(query, params);
    if (success) {
        return { success, data };
    }
    return { success, error };
}

async function getUserByUid(id) {
    const query = 'SELECT id, name, role FROM users WHERE uid = $1';
    const params = [id];
    const { success, data, error } = await repository.query(query, params);
    if (success) {
        return { success, data };
    }
    return { success, error };
}

async function getUserDetailsById(id) {
    const query = 'SELECT id, name, dob, email, role FROM users WHERE id = $1';
    const params = [id];
    const { success, data, error } = await repository.query(query, params);
    if (success) {
        return { success, data };
    }
    return { success, error };
}


module.exports = {
    login,
    register,
    getUserById,
    getUserByUid
    getUserDetailsById
};
