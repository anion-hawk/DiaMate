import '../register_patient_screen/widgets/coeliacdiseasechipview_item_widget.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:diamate_frontend/widgets/custom_flat_button.dart';
import 'package:diamate_frontend/presentation/login_screen/login_screen.dart';

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
                  onChanged: (value) {},
                ),
              ),
              SizedBox(height: 19.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.h,
                  right: 9.h,
                ),
                child: CustomTextFormField(
                  controller: dateController,
                  hintText: "Date of Diagnosis",
                  hintStyle: theme.textTheme.labelLarge!,
                  textInputAction: TextInputAction.done,
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
              Spacer(),
              CustomElevatedButton(
                text: "Register",
                margin: EdgeInsets.only(
                  left: 10.h,
                  right: 9.h,
                ),
                buttonTextStyle:
                    CustomTextStyles.titleMediumPoppinsOnErrorContainerMedium,
              ),
              SizedBox(height: 16.v),
              Text(
                "Already have an account?",
                style: CustomTextStyles.labelLargeBluegray900,
              ),
              SizedBox(height: 4.v),
              CustomFlatButton(
                      text: "Login",
                      buttonTextStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        // Handle button press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                    ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCoeliacDiseaseChipView(BuildContext context) {
    return Wrap(
      runSpacing: 11.v,
      spacing: 11.h,
      children: List<Widget>.generate(
          1, (index) => DiseaseWidget()),
    );
  }
}