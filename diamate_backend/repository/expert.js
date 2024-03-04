const repository = require('./repository');

async function isProfileComplete(userId) {
	const query = 'SELECT * FROM experts WHERE id = $1';
	const params = [userId];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		const isComplete = data.length > 0;
		return { success, isComplete };
	}
	return { success, error };
}

async function completeProfile(id, specialty, experience, bmdc) {
	const query = 'INSERT INTO experts (id, specialty, experience, bmdc) VALUES ($1, $2, $3, $4)';
	const params = [id, specialty, experience, bmdc];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };

}


module.exports = {
	isProfileComplete,
	completeProfile,
};