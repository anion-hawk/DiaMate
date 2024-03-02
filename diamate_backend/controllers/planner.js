require('dotenv').config();
const forumRepository = require('../repository/forum');
const userRepository = require('../repository/user');
const upvoteRepository = require('../repository/upvote');
const commentRepository = require('../repository/comment');
const plannerRepository = require('../repository/planner');


async function insertMedicineDosage(req, res) {
    const { medication, dosage, date, time, repeat } = req.body;
    const userId = req.user.id;

    if(repeat.toLowerCase() === "Does not repeat") repeat = int(0);
         
    else if(repeat.toLowerCase() === "Every Day") repeat = int(1);
           
    else if(repeat.toLowerCase() === "Every week") repeat = int(2);
          
    else if(repeat.toLowerCase() === "Every Month") repeat = int(3);
    
    try {
        // Use the to_timestamp function to convert AM/PM time to timestamp
        const result = await plannerRepository.insertMedicineDosage(
            userId,
            medication,
            dosage,
            `to_date('${date}', 'YYYY-MM-DD')`,
            `extract(hour from to_timestamp('${time}', 'hh:mi AM')) || ':' || extract(minute from to_timestamp('${time}', 'hh:mi AM'))`,
            repeat
        );

        if (result.success) {
            res.status(200).json(result.data);
        } else {
            res.status(500).json({ error: 'Internal server error' });
        }
    } catch (error) {
        console.error('Error inserting medicine dosage:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}

async function getMedicineList(req,res) {
    id = req.user.id;  /// lllllllllllllllllllllllllllllllllllllllllll
	const result = await plannerRepository.getMedicineList(id);
	if (result.success) {
		let meds = result.data;
		// let postDetailsFound = await getPostsDetails(posts, req, res);
		// if (!postDetailsFound) {
		// 	return;
		// }
		res.status(200).json(meds);
	}
	else {
		res.status(500).json({ error: 'Internal server error: query failed' });
	}
}

