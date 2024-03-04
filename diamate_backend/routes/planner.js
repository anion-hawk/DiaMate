const router = require('express').Router();
const forumController = require('../controllers/forum');
const plannerController = require('../controllers/planner');

router.route('/insert-medicine').post(plannerController.insertMedicineDosage);
router.route('/medicinelist').get(plannerController.getMedicineList);

router.route('/insert-diet').post(plannerController.insertDietPlan);
router.route('/dietlist').post(plannerController.getDietList);

router.route('/sugarlist').get(plannerController.getSugarList);
router.route('/insert-sugar').post(plannerController.insertSugar);
router.route('/:id').get(plannerController.getMedicineDetailsById);

router.get('/test', (req, res) => {
	res.json({ message: 'in /planner/test' });
});

module.exports = router;