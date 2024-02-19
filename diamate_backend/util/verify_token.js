require('dotenv').config();
//const jwt = require('jsonwebtoken');
const admin = require('./admin');
const { getAuth } = require('firebase-admin/auth');

const userRepository = require('../repository/user');

async function verifyToken(req, res, next) {
	// return false;
	if (!req.headers) {
		res.status(401).json({ error: 'Access denied: no header' });
		return false;
	}
	let token = undefined;
	try {
		token = req.headers['cookie'].split('=')[1];
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
		decodedToken = await getAuth().verifyIdToken(token);
		const result = await userRepository.getUserByUid(decodedToken.uid);
		if (result.success) {
			if (result.data.length === 0) {
				res.status(401).json({ error: 'User not found' });
				return false;
			}
			else {
				console.log('user:');
				console.log(result.data[0]);
				req.user = result.data[0];
				return true;
			}
		}
	}
	catch (err) {
		console.log(err)
		res.status(401).json({ error: 'Access denied' });
		return false;
	}

}



module.exports = verifyToken;