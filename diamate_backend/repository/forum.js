const repository = require('./repository');

async function createPost(userId, title, content, timestamp,tags) {
	const query = 'INSERT INTO posts(author, title, content, created,tags) VALUES($1, $2, $3, $4,$5) RETURNING id, title, content, created,tags';
	const params = [userId, title, content, timestamp,tags];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getPosts(offset, limit) {
	const query = 'SELECT * FROM posts ORDER BY created DESC OFFSET $1 LIMIT $2';
	const params = [offset, limit];
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
	getPosts,
	getPostById
};