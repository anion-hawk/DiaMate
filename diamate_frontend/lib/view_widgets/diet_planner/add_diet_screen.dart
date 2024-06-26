import 'package:diamate_frontend/config.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requests/requests.dart';

class AddDietScreen extends StatefulWidget {
  AddDietScreen({Key? key}) : super(key: key);

  @override
  _AddDietScreenState createState() => _AddDietScreenState();
}

class _AddDietScreenState extends State<AddDietScreen> {
  bool isHovering = false;
  TextEditingController _starttimeController =
      TextEditingController(text: '1:34 PM');
  TextEditingController _lasttimeController =
      TextEditingController(text: '1:40 PM');
  String type = "";
  TextEditingController _dateController = TextEditingController();

  List<String> dropdownItemList = [
    "Breakfast",
    "Brunch",
    "Elevenses",
    "Lunch",
    "Tea",
    "Supper",
    "Dinner",
  ];

  TextEditingController planTitlevalueController = TextEditingController();

  TextEditingController timeController = TextEditingController();
  TimeOfDay selectedTime_start = TimeOfDay.now();
  TimeOfDay selectedTime_last = TimeOfDay.now();

  Future<void> _selectTime_start(BuildContext context) async {
    final TimeOfDay? picked_start = await showTimePicker(
      context: context,
      initialTime: selectedTime_start,
    );
    if (picked_start != null && picked_start != selectedTime_start) {
      setState(() {
        selectedTime_start = picked_start;
        _starttimeController.text = '${picked_start.format(context)}';
      });
    }
  }
    void _selectDate(context) {
    showDatePicker(
            context: context,
            initialDate:DateTime.now(),
                
            firstDate: DateTime.now().subtract(const Duration(days: 1 * 365)),
            lastDate: DateTime.now().add(Duration(days: 365 * 5)),
            )
        .then((value) {
      if (value != null) {
        _dateController.text = DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }
  Future<void> _selectTime_last(BuildContext context) async {
    final TimeOfDay? picked_last = await showTimePicker(
      context: context,
      initialTime: selectedTime_last,
    );
    if (picked_last != null && picked_last != selectedTime_last) {
      setState(() {
        selectedTime_last = picked_last;
        _lasttimeController.text = '${picked_last.format(context)}';
        //_lasttimeController.text = '${picked.format(context)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          //width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 9.h,
            top: 71.v,
            right: 9.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Plan Type",
                //style: CustomTextStyles.titleMediumBlack90002,
              ),
              SizedBox(height: 5.v),
              CustomDropDown(
                hintText: "Breakfast",
                items: dropdownItemList,
                onChanged: (value) {
                  type = value;
                },
              ),
              SizedBox(height: 28.v),
              Text(
                "Plan Title",
                style: CustomTextStyles.titleMediumBlack90002,
              ),
              SizedBox(height: 7.v),
              CustomTextFormField(
                controller: planTitlevalueController,
                hintText: "Enter Your Plan",
                hintStyle: CustomTextStyles.titleSmallGray50002,
              ),
              SizedBox(height: 28.v),
              _buildTimeSection(context),
              SizedBox(height: 5.v),
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
            ],
          ),
        ),
        bottomNavigationBar: _buildSetScheduleButtonSection(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildStartTimeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Start Time",
          style: CustomTextStyles.titleMediumBlack90002,
        ),
        SizedBox(height: 4.v),
        Container(
          width: 139.h,
          padding: EdgeInsets.symmetric(
            horizontal: 0.h,
            vertical: 0.v,
          ),
          child: TextField(
            controller: _starttimeController,
            readOnly: true,
            onTap: () => _selectTime_start(context),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildEndTimeSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 26.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "End Time",
            style: CustomTextStyles.titleMediumBlack90002,
          ),
          SizedBox(height: 4.v),
          Container(
            width: 139.h,
            child: TextField(
              controller: _lasttimeController,
              readOnly: true,
              onTap: () => _selectTime_last(context),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTimeSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 38.h),
      child: Row(
        children: [
          _buildStartTimeSection(context),
          _buildEndTimeSection(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSetScheduleButtonSection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        insertDiet();
        Navigator.pop(context);
      },
      onTapUp: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onTapDown: (_) {
        setState(() {
          isHovering = false;
        });
      },
      child: Container(
        height: 51.v,
        width: 250.h,
        margin: EdgeInsets.only(
          left: 55.h,
          right: 55.h,
          bottom: 29.v,
        ),
        decoration: BoxDecoration(
          color: isHovering
              ? Colors.white
              : Color.fromARGB(255, 22, 56, 85), // Change color based on tap
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Set Schedule",
            style: TextStyle(
              color: isHovering
                  ? Color.fromARGB(255, 22, 56, 85)
                  : Colors.white, // Change text color based on tap

              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  
  void insertDiet() async {
   
    var data = {
      "type": type,
      "title": planTitlevalueController.text,
      "date": _dateController.text,
      "stime":_starttimeController.text,
      "etime": _lasttimeController.text,
    };
    print(data);

    var response =
        await Requests.post(insertdiet, body: data, timeoutSeconds: 60);
    if (response.statusCode == 200) {
      print("Diet Added Successfully");
    } else {
      print("Diet Adding failed");
    }
    print(response.statusCode);
    print(response.body);
  }
}


