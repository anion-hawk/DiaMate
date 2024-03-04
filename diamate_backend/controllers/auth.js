require('dotenv').config();
const userRepository = require('../repository/user');
const jwt = require('jsonwebtoken');
const { getAuth } = require('firebase-admin/auth');
const admin = require('../util/admin.js');
const db = admin.firestore().collection('users');


async function register(req, res) {
	const { name, email, password, dob, role } = req.body;
	let date = new Date(dob);
	console.log(req.body);
	let rr = 1;
	if (role == "Expert")
		rr = 2;

	getAuth().createUser({
		email: email,
		password: password,
	}).then(async (userRecord) => {
		console.log('User registered on firebase')
		const result = await userRepository.register(name, email, userRecord.uid, date, rr);
		if (result.success) {
			let user = result.data[0];
			let docRef = db.doc(userRecord.uid);
			data = {
				id: userRecord.uid,
				name: name,
				email: email,
				role: rr
			}
			docRef.set(data).then(() => {
				console.log('User added to firestore');
				res.status(201).json(user);
			}).catch((error) => {
				console.log(error);
				res.status(500).json({ error: "Internal server error" });

			})
		}
		else {
			res.status(500).json({ error: "Internal server error" });
		}
	})
		.catch((error) => {
			console.log('Error creating new user in firebase:', error);
			res.status(500).json({ error: error.message });
		});
}


module.exports = {
	register
}
