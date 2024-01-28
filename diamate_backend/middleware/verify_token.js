require('dotenv').config();
const jwt = require('jsonwebtoken');

const userRepository = require('../repository/user');

async function verifyToken(req, res, next) {
	// return false;
	if (!req.headers) {
		res.status(401).json({ error: 'Access denied: no header' });
		return false;
	}
	let token = undefined;
	try {
		token = req.headers['token'].split('=')[1];
		console.log(token);
	}
	catch (err) {
		res.status(401).json({ error: 'Access denied: no auth token' });
		return false;
	}
	if (!token) {
		res.status(401).json({ error: 'Access denied: no such field' });
		return false;
	}
	try {
		const user = jwt.verify(token, process.env.JWT_ACCESS_TOKEN);
		const result = await userRepository.getUserById(user.id);
		if (result.success) {
			if (result.data.length === 0) {
				res.status(401).json({ error: 'User not found' });
			}
			else {
				req.user = result.data[0];
				return true;
			}
		}
		else {
			res.status(500).json({ error: 'Internal server error: could not verify user' });
			return false;
		}
	}
	catch (err) {
		console.log(err)
		res.status(401).json({ error: 'Access denied' });
		return false;
	}

}

module.exports = verifyToken;