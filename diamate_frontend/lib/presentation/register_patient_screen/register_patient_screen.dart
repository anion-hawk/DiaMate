import 'dart:convert';

import '../register_patient_screen/widgets/coeliacdiseasechipview_item_widget.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:diamate_frontend/widgets/custom_flat_button.dart';
import 'package:diamate_frontend/presentation/login_screen/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:diamate_frontend/config.dart';

class RegisterPatientScreen extends StatelessWidget {
  RegisterPatientScreen({Key? key})
      : super(
          key: key,
        );

  List<String> dropdownItemList = [
    "Type 1",
    "Type 2",
  ];

  TextEditingController dateController = TextEditingController();
  List<String> selectedDiseases = [];
  String dType = "";
  void completeUserProfile() async{
    if(dateController.text.isNotEmpty && dType.isNotEmpty)
    {
      var reqbody = {
      "type": dType,
      "diagnosis_date": dateController.text,
      "diseases": jsonEncode(selectedDiseases)
    };
    print(reqbody);
        var response = await http.post(Uri.parse(compUserProf),
            headers: {"token": cookies.join(''),}, body: reqbody);
        print(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 30.v,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgIcon3,
                height: 60.adaptSize,
                width: 60.adaptSize,
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 64.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 9.h,
                  right: 10.h,
                ),
                child: CustomDropDown(
                  icon: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 14.v, 13.h, 13.v),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgArrowdown,
                      height: 18.v,
                      width: 24.h,
                    ),
                  ),
                  hintText: "Type 1/ Type 2",
                  hintStyle: theme.textTheme.labelLarge!,
                  items: dropdownItemList,
                  onChanged: (value) {
                    dType = value;
                  },
                ),
              ),
              SizedBox(height: 19.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.h,
                  right: 9.h,
                ),
                child: InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: dateController,
                      hintText: "Date of Diagnosis",
                      hintStyle: theme.textTheme.labelLarge!,
                      textInputType: TextInputType.datetime,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(20.h, 8.v, 11.h, 8.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgCalendar,
                          height: 16.v,
                          width: 20.h,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 46.v,
                      ),
                      contentPadding: EdgeInsets.only(
                        top: 14.v,
                        right: 30.h,
                        bottom: 14.v,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 14.h),
                  child: Text(
                    "Other Diseases",
                    style: CustomTextStyles.titleSmallBluegray400,
                  ),
                ),
              ),
              SizedBox(height: 14.v),
              _buildCoeliacDiseaseChipView(context),
              const Spacer(),
              CustomElevatedButton(
                text: "Complete Profile",
                margin: EdgeInsets.only(
                  left: 10.h,
                  right: 9.h,
                ),
                buttonTextStyle:
                    CustomTextStyles.titleMediumPoppinsOnErrorContainerMedium,
                onPressed: () {
                  completeUserProfile();
                },
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // Update the selected date
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  /// Section Widget
  Widget _buildCoeliacDiseaseChipView(BuildContext context) {
    return DiseaseWidget(
      onOptionsChanged: (options) {
        print(options.runtimeType);
        // Receive the selected options from DiseaseWidget
        selectedDiseases = options;
        print("Selected Diseases: $selectedDiseases ");
        print(dateController.text);
        print(dType);
      },
    );
  }
}
