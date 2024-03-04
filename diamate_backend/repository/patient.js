const repository = require('./repository');

async function isProfileComplete(userId) {
	const query = 'SELECT * FROM patients WHERE id = $1';
	const params = [userId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		const isComplete = data.length > 0;
		return { success, isComplete };
	}
	return { success, error };
}

async function completeProfile(patientDetails) {
	const query = 'INSERT INTO patients (id, diabetes_type, diagnosis_date, coeliac_disease, thyroid_disease, hypertension, pcos, cataract, diabetes_insipidus, insulin_resistance) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)';
	const params = [patientDetails.id, patientDetails.diabetes_type, patientDetails.diagnosis_date, patientDetails.coeliac_disease, patientDetails.thyroid_disease, patientDetails.hypertension, patientDetails.pcos, patientDetails.cataract, patientDetails.diabetes_insipidus, patientDetails.insulin_resistance];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };

}
async function getPatientDetails(id){
	const query = 'SELECT (SELECT COUNT(*) FROM follows WHERE follower = $1 ) AS total_following, (SELECT COUNT{*} FROM follows WHERE followee = $1 ) AS total_follower)';
    const params = [id];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		const isComplete = data.length > 0;
		return { success, isComplete };
	}
	return { success, error };


}
module.exports = {
	isProfileComplete,
	completeProfile,
	getPatientDetails
};