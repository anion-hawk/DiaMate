const router = require('express').Router();
const forumController = require('../controllers/forum');
const plannerController = require('../controllers/planner');

router.route('/insert-medicine').post(plannerController.insertMedicineDosage);
router.route('/medicinelist').get(plannerController.getMedicineList);
router.route('/:id').get(plannerController.getMedicineDetailsById);


router.get('/test', (req, res) => {
	res.json({ message: 'in /planner/test' });
});

module.exports = router;