const router = require('express').Router();
const forumController = require('../controllers/forum');
const commentController = require('../controllers/comment');
const verifyToken = require('../controllers/middleware/verify_token');

router.route('/post').post(verifyToken, forumController.createPost);
router.route('/posts').get(verifyToken, forumController.getPosts);
router.route('/:id').get(verifyToken, forumController.getPost);
router.route('/:id').post(verifyToken, forumController.setUpvote);

router.route('/:id/comments').post(verifyToken, commentController.createComment);
router.route('/:id/comments').get(verifyToken, commentController.getComments);

router.get('/test', (req, res) => {
	res.json({ message: 'in /forum/test' });
});

module.exports = router;