const repository = require('./repository');

async function setUpvote(userId, postId) {
	const query = 'INSERT INTO upvotes(userid, postid) VALUES($1, $2)';
	const params = [userId, postId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function removeUpvote(userId, postId) {
	const query = 'DELETE FROM upvotes WHERE userid = $1 AND postid = $2';
	const params = [userId, postId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getUpvotesByPostId(postId) {
	const query = 'SELECT * FROM upvotes WHERE postid = $1';
	const params = [postId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function checkUpvote(userId, postId) {
	const query = 'SELECT * FROM upvotes WHERE userid = $1 AND postid = $2';
	const params = [userId, postId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

module.exports = {
	setUpvote,
	removeUpvote,
	getUpvotesByPostId,
	checkUpvote
};