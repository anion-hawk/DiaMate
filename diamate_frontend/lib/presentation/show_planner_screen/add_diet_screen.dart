import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

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
        //selectedTime_last = picked_start;
        _starttimeController.text = '${picked_start.format(context)}';
        //_lasttimeController.text = '${picked.format(context)}';
      });
    }
  }

  Future<void> _selectTime_last(BuildContext context) async {
    final TimeOfDay? picked_last = await showTimePicker(
      context: context,
      initialTime: selectedTime_last,
    );
    if (picked_last != null && picked_last != selectedTime_last) {
      setState(() {
        selectedTime_last = picked_last;
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
          width: double.maxFinite,
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
                style: CustomTextStyles.titleMediumBlack90002,
              ),
              SizedBox(height: 5.v),
              CustomDropDown(
                icon: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 12.v, 13.h, 22.v),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgCheckmark,
                    height: 10.adaptSize,
                    width: 10.adaptSize,
                  ),
                ),
                hintText: "Breakfast",
                hintStyle: CustomTextStyles.titleSmallInterGray50001,
                items: dropdownItemList,
                onChanged: (value) {},
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
          // decoration: AppDecoration.outlineGray.copyWith(
          //   borderRadius: BorderRadiusStyle.roundedBorder4,
          // ),
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
            padding: EdgeInsets.symmetric(
              horizontal: 0.h,
              vertical: 0.v,
            ),
            // decoration: AppDecoration.outlineGray.copyWith(
            //   borderRadius: BorderRadiusStyle.roundedBorder4,
            // ),
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
          color: isHovering ? Colors.white : Color(0xff3366ff), // Change color based on tap
      borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Set Schedule",
            style: TextStyle(
              color: isHovering ? Color(0xff3366ff) : Colors.white, // Change text color based on tap
          
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
