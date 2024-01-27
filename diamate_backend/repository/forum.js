const repository = require('./repository');

async function createPost(userId, title, content, timestamp) {
	const query = 'INSERT INTO posts(author, title, content, created) VALUES($1, $2, $3, $4) RETURNING id, title, content, created';
	const params = [userId, title, content, timestamp];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getPostById(id) {
	const query = 'SELECT * FROM posts WHERE id = $1';
	const params = [id];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

module.exports = {
	createPost,
	getPostById
};