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

async function register(name, email, password, role) {
    const query = 'INSERT INTO users(name, email, password, role) VALUES($1, $2, $3, $4) RETURNING id, name, role';
    const params = [name, email, password, role];
    const { success, data, error } = await repository.query(query, params);
    if (success) {
        return { success, data };
    }
    return { success, error };
}

module.exports = {
    login,
    register
};
