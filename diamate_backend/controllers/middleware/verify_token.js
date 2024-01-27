require('dotenv').config();
const jwt = require('jsonwebtoken');

const userRepository = require('../../repository/user');

async function verifyToken(req, res, next) {
	if (!req.headers) {
		res.status(401).json({ error: 'Access denied: no header' });
		return;
	}
	let token = undefined;
	try {
		token = req.headers['cookie'].split('=')[1];
	}
	catch (err) {
		res.status(401).json({ error: 'Access denied: no auth token' });
	}
	if (!token) {
		res.status(401).json({ error: 'Access denied: no such field' });
		return;
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
				next();
			}
		}
		else {
			res.status(500).json({ error: 'Internal server error' });
		}
	}
	catch (err) {
		console.log(err)
		res.status(401).json({ error: 'Access denied' });
	}

}

module.exports = verifyToken;