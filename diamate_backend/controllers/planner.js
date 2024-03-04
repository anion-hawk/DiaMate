require('dotenv').config();
const forumRepository = require('../repository/forum');
const userRepository = require('../repository/user');
const upvoteRepository = require('../repository/upvote');
const commentRepository = require('../repository/comment');
const plannerRepository = require('../repository/planner');


async function insertMedicineDosage(req, res) {
    const { medication, dosage, date, time, repeat } = req.body;
    const userId = req.user.id;
    let  k = 0;
	console.log("ejfrfr" + repeat);
    if(repeat.toLowerCase() === "Does not repeat".toLowerCase()) k = 0;
         
    else if(repeat.toLowerCase() === "Every Day".toLowerCase()) k = 1;
           
    else if(repeat.toLowerCase() === "Every week".toLowerCase()) k = 2;
          
    else if(repeat.toLowerCase() === "Every Month".toLowerCase()) k = 3;
    console.log(k);
	const parts = date.split('/'); // Split the input date
    const day = parts[0];
    const month = parts[1];
    const year = parts[2];

    // Rearrange the parts to form the new date string
    const newDate = `${year}-${month}-${day}`;
    
    try {
        // Use the to_timestamp function to convert AM/PM time to timestamp
        const result = await plannerRepository.insertMedicineDosage(
            userId,
            medication,
            dosage,
            newDate,
			time,
            k
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

async function insertDietPlan(req, res) {
    const { type, title, date, stime, etime } = req.body;
    const userid = req.user.id;
    console.log(req.body);
	// const parts = date.split('/'); // Split the input date
    // const day = parts[0];
    // const month = parts[1];
    // const year = parts[2];

    // // Rearrange the parts to form the new date string
    // const newDate = `${year}-${month}-${day}`;
    
    try {
        // Use the to_timestamp function to convert AM/PM time to timestamp
        const result = await plannerRepository.insertDietPlan(
            userid, type, title, date, stime, etime
        );
        
        if (result.success) {
            res.status(200).json(result.data);
        } else {
            res.status(500).json({ error: 'Internal server error' });
        }
    } catch (error) {
        console.error('Error inserting diet plan: ', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}
async function getDietList(req, res) {
	console.log(req.body);
	//let dt = req.query.dt; 
	const {dt} = req.body;

	id = req.user.id;//console.log(id+" "+ dt);
	
	const result = await plannerRepository.getDietList(id,dt);
  
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
		const timeParts = med.stime.split(':');
		let formattedHour = parseInt(timeParts[0], 10);
		const formattedMinute = timeParts[1];
		const formattedSecond = timeParts[2] || '00';
		let ampm = 'AM';
  
		if (formattedHour > 12) {
		  formattedHour -= 12;
		  ampm = 'PM';
		}
        const sformattedTime = `${formattedHour}:${formattedMinute}:${formattedSecond} ${ampm}`;
		// Format time
		const etimeParts = med.etime.split(':');
		let eformattedHour = parseInt(etimeParts[0], 10);
		const eformattedMinute = etimeParts[1];
		const eformattedSecond = etimeParts[2] || '00';
		let eampm = 'AM';
  
		if (eformattedHour > 12) {
		  eformattedHour -= 12;
		  eampm = 'PM';
		}
  
		const eformattedTime = `${eformattedHour}:${eformattedMinute}:${eformattedSecond} ${eampm}`;
  
		return {
		  ...med,
		  formatted_date: formattedDate,
		  sformatted_time: sformattedTime,
		  eformatted_time: eformattedTime,
		};
	  });
  
	  res.status(200).json(meds);
	} else {
	  res.status(500).json({ error: 'Internal server error: query failed' });
	}
  }
  


module.exports = {
	insertMedicineDosage,
    getMedicineList,
    getMedicineDetailsById,
	insertDietPlan,
	getDietList

};
