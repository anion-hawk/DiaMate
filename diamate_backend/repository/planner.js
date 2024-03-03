const repository = require('./repository');

async function insertMedicineDosage(userid, medication, dosage,date, time, repeat) {
	const query = 'INSERT INTO medicinePlanner(userid, medication, dosage,date, time, repeat) VALUES($1, $2, $3, $4, $5,$6) RETURNING id';
	const params = [userid, medication, dosage,date, time, repeat ];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getMedicineList(userId) {
	const query = 'SELECT * FROM medicinePlanner WHERE userid = $1';
//const query =' SELECT( id, userid, medication, dosage, TO_CHAR(date, "DD/MM/YYYY") AS formatted_date,TO_CHAR(time, "HH12:MI:SS AM") AS formatted_time, repeat) FROM medicinePlanner WHERE userid = $1';
	const params = [userId];
	const { success, data, error } = await repository.query(query,params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getMedicineDetailsById(id) {
	const query = 'SELECT * FROM medicinePlanner WHERE id = $1';
	const params = [id];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

module.exports = {
	insertMedicineDosage,
    getMedicineDetailsById,
    getMedicineList
};