const router = require('express').Router();
const userController = require('../controllers/user');
const verifyToken = require('../controllers/middleware/verify_token');


router.route('/profile').get(verifyToken, userController.getSelfProfile);
router.route('/:id').get(verifyToken, userController.getUserById);
router.route('/complete-profile').post(verifyToken, userController.completeProfile);

module.exports = router;