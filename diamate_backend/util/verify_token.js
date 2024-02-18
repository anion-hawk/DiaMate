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
		console.log(decodedToken);
		return true;
	}
	catch (err) {
		console.log(err)
		res.status(401).json({ error: 'Access denied' });
		return false;
	}

}



module.exports = verifyToken;