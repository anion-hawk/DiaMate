const repository = require('./repository');

async function getMedicines(userId, date) {
	const query = `SELECT * FROM medicine WHERE user = ${userId} AND start_date <= '${date}' AND end_date >= '${date}'`;
	return await repository.query(query);
}

async function getMedicine(medicineId) {
	const query = `SELECT * FROM medicine WHERE id = ${medicineId}`;
	return await repository.query(query);
}

async function addMedicine(medicine) {
	const query = `INSERT INTO medicine (name, user, dosage, frequency, start_date, end_date) VALUES ('${medicine.name}', ${medicine.user}, '${medicine.dosage}', '${medicine.frequency}', '${medicine.start_date}', '${medicine.end_date}')`;
	return await repository.query(query);
}

module.exports = {
	getMedicines,
	getMedicine,
	addMedicine
};