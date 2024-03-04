import 'dart:convert';

import 'package:diamate_frontend/config.dart';

import 'package:diamate_frontend/views/tracker.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:diamate_frontend/view_widgets/sugar_tracker/userprofilelist_item_widget.dart';

class SugarTrackerScreen extends StatefulWidget {
  const SugarTrackerScreen({Key? key}) : super(key: key);

  @override
  _MedicationEntryModalState createState() => _MedicationEntryModalState();
}

class _MedicationEntryModalState extends State<SugarTrackerScreen> {
  //Widget _show;
  String? dosageUnit = 'mmol/L'; // Default dosage unit
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String selectedOption = '';

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _sugarController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // User user = FirebaseAuth.instance.currentUser!;
    // user.getIdToken(true).then((token) {
    //   print("Token");
    //   print(token);
    //   if (token != null) {
    //     Requests.addCookie(Requests.getHostname(baseUrl), "token", token);
    //   }
    // });
    // // Fetch data from the backend when the widget is created
    fetchSugarList();
  }

  Future<List<Map<String, dynamic>>> fetchSugarList() async {
    try {
      final response = await Requests.get(sugarlist, timeoutSeconds: 120);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load sugarlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('Failed to load sugarlists: $e');
    }
  }

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
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
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
    );
  }

   Widget _buildUserProfileList(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchSugarList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error in fetching the data, display an error message
          return Text('Error: ${snapshot.error}');
        } else {
          // If the data has been successfully fetched, build the UI using the data
          List<Map<String, dynamic>> meds = snapshot.data ?? [];
          return Padding(
            padding: EdgeInsets.only(left: 7.h, right: 4.h),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 21.v);
              },
              itemCount: meds.length,
              itemBuilder: (context, index) {
                return UserprofilelistItemWidget(data: meds[index]);
              },
            ),
          );
        }
      },
    );
  }

  /// Section Widget
  // Widget _buildUserProfileList(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Container(
  //       height: MediaQuery.of(context).size.height *
  //           0.7, // Adjust the height as needed
  //       padding: EdgeInsets.only(left: 7.h, right: 4.h),
  //       child: ListView.separated(
  //         shrinkWrap: true,
  //         separatorBuilder: (context, index) {
  //           return SizedBox(height: 21.v);
  //         },
  //         itemCount: 100,
  //         itemBuilder: (context, index) {
  //           return UserprofilelistItemWidget(
  //               // Pass any necessary data to UserMeallistItemWidget
  //               );
  //         },
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 35,
      width: 35,
      backgroundColor: Colors.indigo[900]!, // Replace with your color
      child: Icon(
        Icons.add_circle_outlined,
        color: Colors.white,
        //size: 25.0,
      ),
      onTap: () {
        _showModal(context);
      },
    );
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
                        controller: _sugarController,
                        decoration: InputDecoration(
                          labelText: 'Sugar Concentration',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0, // Set the desired width
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'mmol/L',
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildMeasured(context),
                SizedBox(height: 8),
                _buildDateTime(context),
                SizedBox(height: 8),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: 'Notes',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
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
                          insertSugar();
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

  Widget _buildMeasured(BuildContext context) {
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
              ),
              SizedBox(height: 20),
              _buildOptionTile(context, 'Before Breakfast'),
              _buildOptionTile(context, 'After Breakfast'),
              _buildOptionTile(context, 'Before Lunch'),
              _buildOptionTile(context, 'After Lunch'),
              _buildOptionTile(context, 'Before Dinner'),
              _buildOptionTile(context, 'After Dinner'),
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

  Widget _buildDateTime(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Date',
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
            body: SingleChildScrollView(
              child: Container(
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
            ),
            floatingActionButton: _buildFloatingActionButton(context)));
  }

  void insertSugar() async {
    var data = {
      
      "mealtime": selectedOption,
      "date": _dateController.text,
      "time": _timeController.text,
      "notes": _noteController.text,
      "sugar": _sugarController.text,
    };
    print(data);

    var response =
        await Requests.post(insertsugar, body: data, timeoutSeconds: 60);
    if (response.statusCode == 200) {
      print("Sugar Added Successfully");
    } else {
      print("Sugar Adding failed");
    }
    print(response.statusCode);
    print(response.body);
  }
}
