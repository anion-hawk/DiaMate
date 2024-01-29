require('dotenv').config();
const { isValidPost } = require('../controllers/forum');
const commentRepository = require('../repository/comment');


async function isValidParent(parentId, res) {
	const commentQuery = await commentRepository.getCommentById(parentId);
	if (!commentQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot find comment' });
		return false;
	}
	if (commentQuery.data.length === 0) {
		res.status(404).json({ error: 'Comment not found' });
		return false;
	}
	return true;
}

async function createComment(req, res) {
	const postId = req.params['id'];
	let { content, parent } = req.body;
	const validPost = await isValidPost(postId, res);
	if (!validPost) {
		return;
	}
	// Check if parent has data
	if (parent === null || parent === undefined) {
		parent = '00000000-0000-0000-0000-000000000000';
	} else {
		const validParent = await isValidParent(parent, res);
		if (!validParent) {
			return;
		}
	}

	const userId = req.user.id;
	const timestamp = new Date();
	const result = await commentRepository.createComment(userId, postId, content, parent, timestamp);
	if (result.success) {
		res.status(200).json(result.data[0]);
	}
	else {
		res.status(500).json({ error: 'Internal server error' });
	}
}


async function getComments(req, res) {
	const { id } = req.params;
	const validPost = await isValidPost(id, res);
	if (!validPost) {
		return;
	}
	const result = await commentRepository.getCommentsByPostId(id);
	if (result.success) {
		res.status(200).json(result.data);
	}
	else {
		res.status(500).json({ error: 'Internal server error' });
	}
}

module.exports = {
	createComment,
	getComments
}