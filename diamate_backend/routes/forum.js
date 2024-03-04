const router = require('express').Router();
const forumController = require('../controllers/forum');
const commentController = require('../controllers/comment');

router.route('/comment').post(commentController.createComment);
router.route('/post').post(forumController.createPost);
router.route('/posts').get(forumController.getPosts);
router.route('/selfposts').get(forumController.getSelfPosts);
router.route('/:id').get(forumController.getPost);
router.route('/:id').post(forumController.setUpvote);

router.route('/:id/comments').get(commentController.getComments);

router.get('/test', (req, res) => {
	res.json({ message: 'in /forum/test' });
});

module.exports = router;