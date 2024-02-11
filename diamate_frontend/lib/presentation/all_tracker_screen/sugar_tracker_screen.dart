import 'widgets/userprofilelist_item_widget.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:diamate_frontend/presentation/tracker_home_screen/tracker_home_screen.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';

import 'package:diamate_frontend/presentation/modals/add_sugar_modal.dart';

class SugarTrackerScreen extends StatefulWidget {
  const SugarTrackerScreen({Key? key}) : super(key: key);

  @override
  _MedicationEntryModalState createState() => _MedicationEntryModalState();
}

class _MedicationEntryModalState extends State<SugarTrackerScreen> {

  //Widget _show;
  String? dosageUnit = 'mg'; // Default dosage unit
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();


  String selectedOption = '';

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  /// Navigates to the editSugarLevelScreen when the action is triggered.
  // onTapUserProfile(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.editSugarLevelScreen);
  // }

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

 
  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 56.v,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          // Handle the 'back' button press here
          // Typically, you would use Navigator to navigate back
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TrackerHomeScreen()),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfileList(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 7.h, right: 4.h),
        child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 21.v);
            },
            itemCount: 2,
            itemBuilder: (context, index) {
              return UserprofilelistItemWidget(
                //onTapUserProfile(context);
              );
            }));
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 35,
      width: 35,
      backgroundColor: Colors.indigo[900]!, // Replace with your color
      child: Icon(
        Icons.add_circle_outlined,
        color: Colors.white,
        size: 25.0,
      ),

      onTap: () {
        _showModal(context);

       // _openAddSugarModal(context);
      },

      
    );
  }
  // void _openAddSugarModal(BuildContext context) {
  //   AddSugarModal add  = new AddSugarModal();
  //   setState(() {
  //     _show = add._showaModal(context);
  //   });
  // }


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
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 3.v),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22.v),
                      Padding(
                          padding: EdgeInsets.only(left: 11.h),
                          child: Text("Blood Sugar ",
                              style: theme.textTheme.headlineSmall)),
                      SizedBox(height: 26.v),
                      _buildUserProfileList(context),
                      SizedBox(height: 26.v)
                    ])),
            floatingActionButton: _buildFloatingActionButton(context)));
  }
}
