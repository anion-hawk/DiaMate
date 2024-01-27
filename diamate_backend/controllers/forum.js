require('dotenv').config();
const forumRepository = require('../repository/forum');
const upvoteRepository = require('../repository/upvote');

async function createPost(req, res) {
	const { title, content } = req.body;
	const userId = req.user.id;
	const timestamp = new Date();
	const result = await forumRepository.createPost(userId, title, content, timestamp);
	if (result.success) {
		res.status(200).json(result.data);
	}
	else {
		res.status(500).json({ error: 'Internal server error' });
	}
}

async function getPosts(req, res) {
	let param = { page: 1, limit: 20 };
	const page = param.page;
	const limit = param.limit;
	const offset = (page - 1) * limit;
	const result = await forumRepository.getPosts(offset, limit);
	if (result.success) {
		res.status(200).json(result.data);
	}
	else {
		res.status(500).json({ error: 'Internal server error: query failed' });
	}
}

async function getPost(req, res) {
	const { id } = req.params;
	const result = await forumRepository.getPostById(id);
	if (result.success) {
		res.status(200).json(result.data);
	}
	else {
		res.status(500).json({ error: 'Internal server error' });
	}
}

async function setUpvote(req, res) {
	const { id } = req.params;
	const postQuery = await forumRepository.getPostById(id);
	if (!postQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot find post' });
		return;
	}
	if (postQuery.data.length === 0) {
		res.status(404).json({ error: 'Post not found' });
		return;
	}

	const user = req.user;
	const { isUpvote } = req.body;
	const upvoteQuery = await upvoteRepository.checkUpvote(user.id, id);
	if (!upvoteQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot find upvote' });
	}
	const status = !(upvoteQuery.data.length === 0);
	if (isUpvote) {
		if (status) {
			res.status(200).json({ message: 'Success: already upvoted' });
			return;
		}
		const addQuery = await upvoteRepository.setUpvote(user.id, id);
		if (!addQuery.success) {
			res.status(500).json({ error: 'Internal server error' });
			return;
		}
		res.status(200).json({ message: 'Success: upvote added' });
	}
	else {
		const removeQuery = await upvoteRepository.removeUpvote(user.id, id);
		if (!removeQuery.success) {
			res.status(500).json({ error: 'Internal server error' });
			return;
		}
		res.status(200).json({ message: 'Success: upvote removed' });
	}
	return;
}

module.exports = {
	createPost,
	getPosts,
	getPost,
	setUpvote
};