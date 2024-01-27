const router = require('express').Router();
const userController = require('../controllers/user');


router.route('/login').post(userController.login);
router.route('/register').post(userController.register);
router.route('/logout').post(userController.logout);

router.get('/test', (req, res) => {
    res.json({ message: 'in /auth/test' });
});

module.exports = router;