const repository = require('./repository');

async function getDiet(userId, date) {
	const query = `SELECT * FROM diet WHERE user = ${userId} AND date = '${date}'`;
	return await repository.query(query);
}

async function getMeal(mealId) {
	const query = `SELECT * FROM diet WHERE id = ${mealId}`;
	return await repository.query(query);
}

async function addMeal(meal) {
	const query = `INSERT INTO diet (user, date, time, name, description) VALUES (${meal.user}, '${meal.date}', '${meal.time}', '${meal.name}', '${meal.description}')`;
	return await repository.query(query);
}

module.exports = {
	getMedicines,
	getMedicine,
	addMedicine
};