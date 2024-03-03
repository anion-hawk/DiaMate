import 'package:flutter/material.dart';
import 'package:diamate_frontend/core/app_export.dart';


 //UserprofilelistItemWidget
 class UserMedicine extends StatefulWidget {
   final Map<String, dynamic> data;

  //UserMedicine({required this.data, Key? key});
  const UserMedicine({required this.data, Key? key}) : super(key: key);

  @override
  _MedicationModalState createState() => _MedicationModalState();
}

class _MedicationModalState extends State<UserMedicine> {

  String? dosageUnit = 'mg'; // Default dosage unit
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
   String selectedOption = '';
  String selectedArm = 'Right';

  TextEditingController _medicinecontroller = TextEditingController(text: 'Metaformin');
  TextEditingController _dosagecontroller = TextEditingController(text: '5 mg');
  
  TextEditingController _dateController = TextEditingController(text: '12/12/2012');
  TextEditingController _timeController = TextEditingController(text:'6:33 PM');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _timeController.text = '${picked.format(context)}';
      });
    }
  }

void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(12.0),
          child: Container(
            // Add your modal content here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _medicinecontroller,
                        decoration: InputDecoration(
                          labelText: 'Medication',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.indigo[900]!,
                              width: 2.0, // Set the desired width
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                   
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _dosagecontroller,
                        decoration: InputDecoration(
                          labelText: 'Dosage',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.indigo[900]!,
                              width: 2.0, // Set the desired width
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
                SizedBox(height: 16,),
                _buildDateTime(context),

                SizedBox(height: 8),
                TextField(
                        decoration: InputDecoration(
                          labelText: 'Add Reminder',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.indigo[900]!,
                              width: 2.0, // Set the desired width
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 8),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigo[900]!,
          ),
          child: IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () {
              print("print");
              Navigator.pop(context);
              // Add your logic here when the tick button is pressed
            },
          ),
        ),
      ],
    ),
              ],
                
              
            ),
            ),
        );
      },
    );
  }

  Widget _buildDateTime(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: 'Select Date',
              suffixIcon: Icon(Icons.calendar_today),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.indigo[900]!,
                  width: 2.0,
                ),
              ),
            ),
            controller: _dateController,
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Time',
              hintText: 'Select Time',
              suffixIcon: Icon(Icons.access_time),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.indigo[900]!,
                  width: 2.0,
                ),
              ),
            ),
            controller: _timeController,
            readOnly: true,
            onTap: () => _selectTime(context),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Medicine Planner"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: 11/12/2023", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("Time: 1:34 PM", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("Metformin", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("5 mg", style: theme.textTheme.titleLarge,),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showModal(context);
                  },
                  child: Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: AppDecoration.outlineBlack900021,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: AppDecoration.fillBlue,
              child: Row(
                children: [
                  Text(
                    "11/12/2023",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(width: 22),
                  Text(
                    "1:34 PM",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Text(
                    "Metaformin",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    "5 mg",
                   style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
