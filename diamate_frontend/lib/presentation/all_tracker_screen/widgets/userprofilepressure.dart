import 'package:flutter/material.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/presentation/all_tracker_screen/sugar_tracker_screen.dart';


 //UserprofilelistItemWidget
 class Userprofilepressure extends StatefulWidget {
  const Userprofilepressure({Key? key}) : super(key: key);

  @override
  _MedicationModalState createState() => _MedicationModalState();
}

class _MedicationModalState extends State<Userprofilepressure> {

  String? dosageUnit = 'mg'; // Default dosage unit
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
   String selectedOption = '';
  String selectedArm = 'Right';

  TextEditingController _diastoliccontroller = TextEditingController(text: '90');
  TextEditingController _systoliccontroller = TextEditingController(text: '140');
  TextEditingController _notecontroller = TextEditingController(text: 'notes');
  TextEditingController _pulsecontroller = TextEditingController(text: '123');
  


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
                        controller: _systoliccontroller,
                        decoration: InputDecoration(
                          labelText: 'Systolic Pressure',
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
                    Text(
                      'mm Hg',
                      style: TextStyle(fontSize: 16, color: Colors.indigo[900]),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _diastoliccontroller,
                        decoration: InputDecoration(
                          labelText: 'Diastolic Pressure',
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
                    Text(
                      'mm Hg',
                      style: TextStyle(fontSize: 16, color: Colors.indigo[900]),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                _buildMeasured(context),
                SizedBox(height: 8),
                _buildDateTime(context),

                SizedBox(height: 8),
                TextField(
                        controller: _notecontroller,
                        decoration: InputDecoration(
                          labelText: 'Notes',
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
  

  Widget _buildMeasured(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Measured Arm'),
              Row(
                children: [
                  DropdownButton<String>(
                    value: selectedArm,
                    onChanged: (String? newValue) {
                      setState(() {
                        print(newValue);
                        selectedArm = newValue!;
                      });
                    },
                    items: <String>['Right', 'Left'].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                         
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _pulsecontroller,
            decoration: InputDecoration(
              labelText: 'Pulse',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.indigo[900]!,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
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
              title: Text("Blood Pressure"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: 11/12/2023", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("Time: 1:34 PM", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("Arm: Right", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("140/90 mmHg", style: theme.textTheme.titleLarge,),
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
                    "Arm",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    "Right",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    "10.3 mmol/L",
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
