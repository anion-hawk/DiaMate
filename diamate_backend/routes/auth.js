const router = require('express').Router();
const authController = require('../controllers/auth');


router.route('/register').post(authController.register);

router.get('/test', (req, res) => {
    res.json({ message: 'in /auth/test' });
});

module.exports = router;