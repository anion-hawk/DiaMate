const router = require('express').Router();
const ForumController = require('../controllers/forum');
const verifyToken = require('../controllers/middleware/verify_token');

router.route('/post').post(verifyToken, ForumController.createPost);


router.get('/test', (req, res) => {
	res.json({ message: 'in /forum/test' });
});

module.exports = router;