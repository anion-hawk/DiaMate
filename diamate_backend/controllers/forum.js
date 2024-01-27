require('dotenv').config();
const forumRepository = require('../repository/forum');

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

module.exports = {
	createPost,
	getPost
};