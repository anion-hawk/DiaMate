import 'package:diamate_frontend/view_widgets/medicine_tracker/userprofilemedicine.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:diamate_frontend/views/tracker.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_floating_button.dart';
import 'package:flutter/material.dart';
import "package:requests/requests.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:diamate_frontend/config.dart';
import 'package:flutter/material.dart';

//import 'package:diamate_frontend/presentation/modals/add_Pressure_modal.dart';

class MedicineTrackerScreen extends StatefulWidget {
  const MedicineTrackerScreen({Key? key}) : super(key: key);

  @override
  _MedicationEntryModalState createState() => _MedicationEntryModalState();
}

class _MedicationEntryModalState extends State<MedicineTrackerScreen> {
  //Widget _show;
  String? dosageUnit = 'mg'; // Default dosage unit
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _medicinecontroller = TextEditingController();
  TextEditingController _dosagecontroller = TextEditingController();

  String rpt = '';
  List<String> dropdownItemList = [
    "Does not repeat",
    "Every Day",
    "Every week",
    "Every Month",
  ];
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
    fetchMedicineList();
  }

  Future<List<Map<String, dynamic>>> fetchMedicineList() async {
    try {
      final response = await Requests.get(medlist, timeoutSeconds: 120);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
       //print(data);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load medlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('Failed to load medlists: $e');
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

  // Section Widget
  // Widget _buildMedicineInfo(BuildContext context) {

  //   return Padding(

  //       padding: EdgeInsets.only(left: 7.h, right: 4.h),
  //       child: ListView.separated(
  //           physics: NeverScrollableScrollPhysics(),
  //           shrinkWrap: true,
  //           separatorBuilder: (context, index) {
  //             return SizedBox(height: 21.v);
  //           },
  //           itemCount: 30,
  //           itemBuilder: (context, index) {
  //             return UserMedicine(
  //                 );
  //           }));
  // }
  Widget _buildMedicineInfo(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchMedicineList(),
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
                return UserMedicine(data: meds[index]);
              },
            ),
          );
        }
      },
    );
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
                    Text(
                      'mg',
                      style: TextStyle(fontSize: 16, color: Colors.indigo[900]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                //_buildMeasured(context),
                //SizedBox(height: 8),
                _buildDateTime(context),
                SizedBox(height: 8),
                Text(
                  "Add Reminder",
                  style: CustomTextStyles.titleMediumBlack90002,
                ),
                SizedBox(height: 5.v),
                CustomDropDown(
                  hintText: "Does not Repeat",
                  items: dropdownItemList,
                  onChanged: (value) {
                    rpt = value;
                  },
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
                          //print("print");
                          insertMed();
                          //fetchMedicineList();

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

  Widget _buildDateTime(BuildContext context) {
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
                            child: Text("Medicine Planner",
                                style: theme.textTheme.headlineSmall)),
                        SizedBox(height: 26.v),
                        _buildMedicineInfo(context),
                        SizedBox(height: 26.v)
                      ])),
            ),
            floatingActionButton: _buildFloatingActionButton(context)));
  }

  void insertMed() async {
    var data = {
      "medication": _medicinecontroller.text,
      "dosage": _dosagecontroller.text,
      "date": _dateController.text,
      "time": _timeController.text,
      "repeat": rpt
    };
    print(data);

    var response =
        await Requests.post(insertmed, body: data, timeoutSeconds: 30);
    if (response.statusCode == 200) {
      print("Med Added Successfully");
    } else {
      print("Med Adding failed");
    }
    print(response.statusCode);
    print(response.body);
  }
}
