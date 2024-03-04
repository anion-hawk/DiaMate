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

async function getAllPosts(userId) {
	const query = `
        SELECT 
            posts.*, 
            users.id AS author_id, 
            users.name AS author_name, 
            users.role AS author_role,
            (SELECT COUNT(*) FROM comments WHERE comments.post = posts.id) AS comment_count,
            (SELECT COUNT(*) FROM upvotes WHERE upvotes.postid = posts.id AND upvotes.up = true) AS upvote_count,
            (SELECT CASE WHEN EXISTS (SELECT * FROM upvotes WHERE upvotes.postid = posts.id AND upvotes.userid = $1 AND upvotes.up = true) THEN true ELSE false END) AS user_upvote
        FROM 
            posts 
        INNER JOIN 
            users ON posts.author = users.id 
        ORDER BY 
            posts.created DESC`;
	const params = [userId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	console.log(error);
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
async function getSelfPosts(offset, limit, author) {
	const query = 'SELECT * FROM posts WHERE author = $3 ORDER BY created DESC OFFSET $1 LIMIT $2';
	const params = [offset, limit, author];
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
	getAllPosts,
	getPostById,
	getSelfPosts
};