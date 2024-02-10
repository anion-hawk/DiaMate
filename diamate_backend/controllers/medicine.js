const medicineRepository = require('../repositories/medicine');

async function getMedicines(req, res) {
	userId = req.user.id;
	date = req.params.date;
	const medicinesQuery = await medicineRepository.getMedicines(userId, date);
	if (!medicinesQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot find medicines' });
		return;
	}
	const medicines = medicinesQuery.data;
	res.json(medicines);
}

async function getMedicine(req, res) {
	id = req.params.id;
	const medicineQuery = await medicineRepository.getMedicine(id);
	if (!medicineQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot find medicine' });
		return;
	}
	const medicine = medicineQuery.data;
	if (medicine.length === 0) {
		res.status(404).json({ error: 'Medicine not found' });
		return;
	}
	if (medicine[0].user !== req.user.id) {
		res.status(403).json({ error: 'Forbidden' });
		return;
	}
	res.json(medicine);
}

async function addMedicine(req, res) {
	const medicine = req.body;
	medicine.user = req.user.id;
	const addMedicineQuery = await medicineRepository.addMedicine(medicine);
	if (!addMedicineQuery.success) {
		res.status(500).json({ error: 'Internal server error: cannot add medicine' });
		return;
	}
	res.json(addMedicineQuery.data);
}


module.exports = {
	getMedicines,
	getMedicine,
	addMedicine
};