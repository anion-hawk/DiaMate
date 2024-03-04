const repository = require('./repository');

async function followUser(follower, folowee) {
	const query = 'INSERT INTO follows(follower, followee) VALUES($1, $2)';
	const params = [follower, folowee];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function unfollowUser(follower, folowee) {
	const query = 'DELETE FROM follows WHERE follower = $1 AND followee = $2';
	const params = [follower, folowee];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		return { success, data };
	}
	return { success, error };
}

async function isFollowing(follower, folowee) {
	const query = 'SELECT * FROM follows WHERE follower = $1 AND followee = $2';
	const params = [follower, folowee];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		const isFollowing = data.length > 0;
		return { success, isFollowing };
	}
	return { success, error };
}
async function getFollower(id)
{
	const query = 'SELECT COUNT(*) FROM follows WHERE follower = $1 ';
    const params = [id];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		const isComplete = data.length > 0;
		
		return { success,data};
	}
	return { success, error };
}

async function getFollowing(id)
{
	const query = 'SELECT COUNT(*) FROM follows WHERE followee = $1 ';
    const params = [id];
	const { success, data, error } = await repository.query(query, params);
	if (success) {
		const isComplete = data.length > 0;
		
		return { success, data };
	}
	return { success, error };
}

module.exports = {
	followUser,
	unfollowUser,
	isFollowing,
	getFollower,
	getFollowing
};