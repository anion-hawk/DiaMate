const repository = require('./repository');

async function insertMedicineDosage(userid, medication, dosage,date, time, repeat) {
	const query = 'INSERT INTO medicineplanner(userid, medication, dosage,date, time, repeat) VALUES($1, $2, $3, $4, $5,$6) RETURNING (id, userid, medication, dosage,date, time, repeat) ';
	const params = [userid, medication, dosage,date, time, repeat ];
	console.log(params);
	const { success, data, error } = await repository.query(query, params);
	console.log(data);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getMedicineList(userId) {
	const query = 'SELECT * FROM medicineplanner WHERE userid = $1';
//const query =' SELECT( id, userid, medication, dosage, TO_CHAR(date, "DD/MM/YYYY") AS formatted_date,TO_CHAR(time, "HH12:MI:SS AM") AS formatted_time, repeat) FROM medicinePlanner WHERE userid = $1';
	const params = [userId];
	const { success, data, error } = await repository.query(query,params);
	
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getMedicineDetailsById(id) {
	const query = 'SELECT * FROM medicineplanner WHERE id = $1';
	const params = [id];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}
//DIEEETTTTTT

async function insertDietPlan (userid, type, title, date, stime, etime){
	const query = 'INSERT INTO dietplanner (userid, type, title, date, stime, etime) VALUES($1, $2, $3, $4, $5,$6) RETURNING (id, userid, type, title, date, stime, etime) ';
	const params = [userid, type, title, date, stime, etime ];
	console.log(params);
	const { success, data, error } = await repository.query(query, params);
	console.log(data);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function getDietList(userId) {
	const query = 'SELECT * FROM public.dietplanner WHERE userid = $1 ORDER BY stime ASC';
	const params = [userId];
	
	const { success, data, error } = await repository.query(query,params);
	console.log(userId+" "+ data);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

module.exports = {
	insertMedicineDosage,
    getMedicineDetailsById,
    getMedicineList,
	insertDietPlan,
	getDietList
};