import 'package:flutter/material.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/presentation/all_tracker_screen/sugar_tracker_screen.dart';


 //UserprofilelistItemWidget
 class UserprofilelistItemWidget extends StatefulWidget {
  const UserprofilelistItemWidget({Key? key}) : super(key: key);

  @override
  _MedicationModalState createState() => _MedicationModalState();
}

class _MedicationModalState extends State<UserprofilelistItemWidget> {

  String? dosageUnit = 'mg'; // Default dosage unit
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedOption = '';

  TextEditingController _dateController = TextEditingController(text:'12/12/2023');
  TextEditingController _timeController = TextEditingController(text:'1:34 PM');
  TextEditingController _concentrationController = TextEditingController(text:'10');
  TextEditingController _notesController = TextEditingController(text:'notes');

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
                        controller: _concentrationController,
                        decoration: InputDecoration(
                          labelText: 'Sugar Concentration',
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
                      'mmol/L',
                      style: TextStyle(fontSize: 16, color: Colors.indigo[900]),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildMeasured(context),
                SizedBox(height: 8),
                _buildDateTime(context),

                SizedBox(height: 8),
                TextField(
                        controller: _notesController,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _showOptionsModal(context);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo[900]!, width: 2.0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedOption.isNotEmpty ? selectedOption : 'None',
              
              style: TextStyle(
                color: selectedOption.isNotEmpty ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }


  void _showOptionsModal(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Meal Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildOptionTile(context, 'Before Breakfast'),
              _buildOptionTile(context, 'After Breakfast'),
              _buildOptionTile(context, 'Before Lunch'),
              _buildOptionTile(context, 'After Lunch'),
              _buildOptionTile(context, 'Before Dinner'),
              _buildOptionTile(context, 'After Dinner'),
              _buildOptionTile(context, 'Before Sleep'),
              _buildOptionTile(context, 'Fasting'),
              
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedOption = result;
        print(result);
        print(selectedOption);
      });
    }
  }

  Widget _buildOptionTile(BuildContext context, String option) {
    return ListTile(
      title: Text(option),
      onTap: () {
        Navigator.pop(context, option);
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
              //hintText: 'Select Date',
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
              //hintText: 'Select Time',
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
              title: Text("Blood Sugar"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: 11/12/2023", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("Time: 1:34 PM", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("Measured: After breakfast", style: theme.textTheme.titleMedium,),
                  SizedBox(height: 8),
                  Text("10.3 mmol/L", style: theme.textTheme.titleLarge,),
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
                    "After breakfast",
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
