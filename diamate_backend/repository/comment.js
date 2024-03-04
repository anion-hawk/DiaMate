const repository = require('./repository');

async function createComment(userId, postId, content, parent, timestamp) {
	const query = 'INSERT INTO comments(author, post, content, parent, created) VALUES($1, $2, $3, $4, $5) RETURNING id';
	const params = [userId, postId, content, parent, timestamp];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getCommentById(id) {
	const query = 'SELECT * FROM comments WHERE id = $1';
	const params = [id];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getCommentsByPostId(postId) {
	const query = `SELECT  comments.*, users.name AS author_name 
					FROM  comments INNER JOIN 
 						   users ON comments.author = users.id
					WHERE comments.post = $1 
					ORDER BY comments.created DESC`;

	const params = [postId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

module.exports = {
	createComment,
	getCommentById,
	getCommentsByPostId
};