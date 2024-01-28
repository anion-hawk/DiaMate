import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:diamate_frontend/presentation/login_screen/login_screen.dart';
import 'package:diamate_frontend/widgets/custom_flat_button.dart';
import 'package:diamate_frontend/presentation/register_patient_screen/register_patient_screen.dart';
import 'package:diamate_frontend/presentation/expert_registertwo_screen/expert_registertwo_screen.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController editTextController = TextEditingController();

  List<String> dropdownItemList = [
    "Doctor",
    "Patient",
    "Others",
  ];

  String selectedUserRole = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
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
                    Container(
                      height: 103.adaptSize,
                      width: 103.adaptSize,
                      padding: EdgeInsets.all(27.h),
                      decoration: AppDecoration.fillGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder49,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgSolarCameraAddBold,
                        height: 49.adaptSize,
                        width: 49.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(height: 30.v),
                    _buildNameEditText(context),
                    SizedBox(height: 16.v),
                    _buildEmailEditText(context),
                    SizedBox(height: 15.v),
                    SizedBox(height: 16.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.h,
                        right: 9.h,
                      ),
                      child: CustomTextFormField(
                        controller: passwordController,
                        hintText: "password",
                        hintStyle: theme.textTheme.labelLarge!,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        prefix: Container(
                          margin: EdgeInsets.fromLTRB(20.h, 13.v, 11.h, 13.v),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgMaterialSymbolsLock,
                            height: 24.adaptSize,
                            width: 24.adaptSize,
                          ),
                        ),
                        prefixConstraints: BoxConstraints(
                          maxHeight: 46.v,
                        ),
                        obscureText: true,
                        contentPadding: EdgeInsets.only(
                          top: 14.v,
                          right: 30.h,
                          bottom: 14.v,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.v),
                    Divider(
                      color: appTheme.blueGray100,
                      indent: 10.h,
                      endIndent: 9.h,
                    ),
                    SizedBox(height: 13.v),
                    _buildEditTextStack(context),
                    SizedBox(height: 93.v),
                    _buildNextButton(context),
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
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 9.h,
      ),
      child: CustomTextFormField(
        controller: nameEditTextController,
        hintText: "name",
        hintStyle: theme.textTheme.labelLarge!,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(20.h, 13.v, 11.h, 13.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgLock,
            height: 20.adaptSize,
            width: 20.adaptSize,
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
    );
  }

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 9.h,
      ),
      child: CustomTextFormField(
        controller: emailEditTextController,
        hintText: "email",
        hintStyle: theme.textTheme.labelLarge!,
        textInputType: TextInputType.emailAddress,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(21.h, 8.v, 11.h, 8.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgLockBlueGray100,
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
    );
  }

  /// Section Widget
  Widget _buildEditText(BuildContext context) {
    return CustomTextFormField(
      width: 293.h,
      controller: editTextController,
      textInputAction: TextInputAction.done,
      alignment: Alignment.topCenter,
      obscureText: true,
    );
  }

  /// Section Widget
  Widget _buildEditTextStack(BuildContext context) {
    return SizedBox(
      height: 179.v,
      width: 293.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildEditText(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 46.v,
              width: 293.h,
              margin: EdgeInsets.only(bottom: 62.v),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  6.h,
                ),
                border: Border.all(
                  color: appTheme.gray300,
                  width: 2.h,
                ),
              ),
            ),
          ),
          CustomDropDown(
            width: 293.h,
            icon: Container(
              margin: EdgeInsets.fromLTRB(30.h, 14.v, 11.h, 13.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgArrowdown,
                height: 18.v,
                width: 24.h,
              ),
            ),
            alignment: Alignment.bottomCenter,
            items: dropdownItemList,
            onChanged: (value) {
            selectedUserRole = value; // Update the selectedUserRole variable
          },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 17.h,
                right: 140.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(left: 4.h),
                  //   child: Row(
                      // children: [
                      //   CustomImageView(
                      //     imagePath: ImageConstant.imgMaterialSymbolsLock,
                      //     height: 24.adaptSize,
                      //     width: 24.adaptSize,
                      //   ),
                      //   Padding(
                      //     padding: EdgeInsets.only(
                      //       left: 9.h,
                      //       top: 4.v,
                      //     ),
                      //     // child: Text(
                      //     //   "password",
                      //     //   style: theme.textTheme.labelLarge,
                      //     // ),
                      //   ),
                      // ],
                   // ),
                  //),
                  SizedBox(height: 47.v),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgCalendar,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 6.h,
                            top: 4.v,
                          ),
                          child: Text(
                            "date of birth",
                            style: theme.textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.v),
                  // Text(
                  //  // "Patient/Doctor/Others",
                  //   style: theme.textTheme.labelLarge,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNextButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Next",
      margin: EdgeInsets.only(
        left: 10.h,
        right: 9.h,
      ),
      buttonTextStyle:
          CustomTextStyles.titleMediumPoppinsOnErrorContainerMedium,

      onPressed: () {
          // Handle button press
          if (selectedUserRole == "Doctor") {
            // Navigate to Doctor registration screen
            // You should replace 'DoctorRegisterScreen' with the actual screen for doctor registration
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExpertRegistertwoScreen()),
            );
          } else if (selectedUserRole == "Patient") {
            // Navigate to Patient registration screen
            // You should replace 'PatientRegisterScreen' with the actual screen for patient registration
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPatientScreen()),
            );
          }
        },   
    );
  }
}
