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
            `to_date('${date}', 'DD-MM-YYYY')`,
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

// async function getMedicineList(req,res) {
//     id = req.user.id;  /// lllllllllllllllllllllllllllllllllllllllllll
// 	console.log(id);
// 	const result = await plannerRepository.getMedicineList(id);
// 	if (result.success) {
// 		let meds = result.data;
// 		// let postDetailsFound = await getPostsDetails(posts, req, res);
// 		// if (!postDetailsFound) {
// 		// 	return;
// 		// }
// 		res.status(200).json(meds);
// 	}
// 	else {
// 		res.status(500).json({ error: 'Internal server error: query failed' });
// 	}
// }

async function getMedicineList(req, res) {
	id = req.user.id;
	console.log(id);
	const result = await plannerRepository.getMedicineList(id);
  
	if (result.success) {
	  let meds = result.data;
  
	  // Loop over meds and format date and time
	  meds = meds.map(med => {
		// Format date
		const formattedDate = new Date(med.date).toLocaleDateString('en-GB', {
		  day: '2-digit',
		  month: '2-digit',
		  year: 'numeric'
		});
  
		// Format time
		const timeParts = med.time.split(':');
		let formattedHour = parseInt(timeParts[0], 10);
		const formattedMinute = timeParts[1];
		const formattedSecond = timeParts[2] || '00';
		let ampm = 'AM';
  
		if (formattedHour > 12) {
		  formattedHour -= 12;
		  ampm = 'PM';
		}
  
		const formattedTime = `${formattedHour}:${formattedMinute}:${formattedSecond} ${ampm}`;
  
		return {
		  ...med,
		  formatted_date: formattedDate,
		  formatted_time: formattedTime
		};
	  });
  
	  res.status(200).json(meds);
	} else {
	  res.status(500).json({ error: 'Internal server error: query failed' });
	}
  }
  

async function getMedicineDetailsById(req, res) {
	const { id } = req.params;
	const result = await plannerRepository.getMedicineDetailsById(id);
	if (result.success) {
		if (result.data.length === 0) {
			res.status(404).json({ error: 'Medicine Details not found' });
			return;
		}
		// let posts = result.data;
		// let postDetailsFound = await getPostsDetails(posts, req, res);
		// if (!postDetailsFound) {
		// 	return;
		// }
		res.status(200).json(result[0]);
	}
	else {
		res.status(500).json({ error: 'Internal server error' });
	}
}


module.exports = {
	insertMedicineDosage,
    getMedicineList,
    getMedicineDetailsById
};
