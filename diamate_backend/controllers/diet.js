const dietRepository = require('../repositories/diet');

async function getDiet(req, res) {
	userId = req.user.id;
	date = req.params.date;
	const dietQuery = await dietRepository.getDiet(userId, date);
	if (!dietQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot find diet' });
		return;
	}
	const diet = dietQuery.data;
	res.json(diet);
}

async function getMeal(req, res) {
	id = req.params.id;
	const mealQuery = await dietRepository.getMeal(id);
	if (!mealQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot find meal' });
		return;
	}
	const meal = mealQuery.data;
	if (meal.length === 0) {
		res.status(404).json({ error: 'Meal not found' });
		return;
	}
	if (meal[0].user !== req.user.id) {
		res.status(403).json({ error: 'Forbidden' });
		return;
	}
	res.json(meal);
}

async function addMeal(req, res) {
	const meal = req.body;
	meal.user = req.user.id;
	const addMealQuery = await dietRepository.addMeal(meal);
	if (!addMealQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot add meal' });
		return;
	}
	res.json(addMealQuery.data);
}


module.exports = {
	getDiet,
	getMeal,
	addMeal
};