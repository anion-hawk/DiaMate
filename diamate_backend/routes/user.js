const router = require('express').Router();
const userController = require('../controllers/user');


router.route('/profile').get(userController.getSelfProfile);
router.route('/complete-profile').post(userController.completeProfile);
router.route('/:id').get(userController.getUserById);
router.route('/:id/follow').post(userController.followUser);

module.exports = router;