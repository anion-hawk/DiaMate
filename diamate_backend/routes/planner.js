const router = require('express').Router();
const medicineController = require('../controllers/medicine');
const dietController = require('../controllers/diet');

router.route('/medicines/:date').get(medicineController.getMedicines);
router.route('/medicine/:id').get(medicineController.getMedicine);
router.route('/medicine').post(medicineController.addMedicine);

router.route('/diet/:date').get(dietController.getDiet);
router.route('/diet/:id').get(dietController.getMeal);
router.route('/diet').post(dietController.addMeal);

router.get('/test', (req, res) => {
	res.json({ message: 'in /planner/test' });
});

module.exports = router;