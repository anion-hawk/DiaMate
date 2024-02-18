// import 'package:diamate_frontend/core/app_export.dart';
// import 'package:diamate_frontend/widgets/custom_drop_down.dart';
// import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
// import 'package:diamate_frontend/widgets/form_text.dart';
// import 'package:flutter/material.dart';

// class EditProfileScreen extends StatelessWidget {
//   EditProfileScreen({Key? key})
//       : super(
//           key: key,
//         );

//   TextEditingController editProfileNameController = TextEditingController();

//   TextEditingController editProfileEmailController = TextEditingController();

//   TextEditingController editProfilePasswordController = TextEditingController();

//   List<String> dropdownItemList = [
//     "Item One",
//     "Item Two",
//     "Item Three",
//   ];

//   List<String> dropdownItemList1 = [
//     "Item One",
//     "Item Two",
//     "Item Three",
//   ];

//   TextEditingController editProfileDateController = TextEditingController();

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Form(
//           key: _formKey,
//           child: SizedBox(
//             width: double.maxFinite,
//             child: Column(
//               children: [
//                 SizedBox(height: 12.v),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 11.v),
//                       padding: EdgeInsets.symmetric(horizontal: 9.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CustomImageView(
//                                 imagePath: ImageConstant.imgMaterialSymbol,
//                                 height: 30.adaptSize,
//                                 width: 30.adaptSize,
//                                 margin: EdgeInsets.only(bottom: 27.v),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 87.h,
//                                   top: 27.v,
//                                 ),
//                                 child: Text(
//                                   "Edit Profile",
//                                   style: CustomTextStyles
//                                       .titleLargePoppinsBlack90002Bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16.v),
//                           Align(
//                             alignment: Alignment.center,
//                             child: SizedBox(
//                               height: 102.v,
//                               width: 100.h,
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: Container(
//                                       height: 102.v,
//                                       width: 100.h,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                           51.h,
//                                         ),
//                                         border: Border.all(
//                                           color: theme.colorScheme.onError,
//                                           width: 1.h,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: SizedBox(
//                                       height: 99.v,
//                                       width: 96.h,
//                                       child: Stack(
//                                         alignment: Alignment.bottomRight,
//                                         children: [
//                                           CustomImageView(
//                                             imagePath:
//                                                 ImageConstant.imgEllipse2,
//                                             height: 99.v,
//                                             width: 96.h,
//                                             radius: BorderRadius.circular(
//                                               49.h,
//                                             ),
//                                             alignment: Alignment.center,
//                                           ),
//                                           CustomImageView(
//                                             imagePath:
//                                                 ImageConstant.imgSolarCameraMi,
//                                             height: 18.adaptSize,
//                                             width: 18.adaptSize,
//                                             alignment: Alignment.bottomRight,
//                                             margin: EdgeInsets.only(right: 5.h),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 17.v),
//                           Text(
//                             "Name",
//                             style: CustomTextStyles.titleMediumBlack90002,
//                           ),
//                           SizedBox(height: 7.v),
//                           _buildEditProfileName(context),
//                           SizedBox(height: 18.v),
//                           Text(
//                             "Email",
//                             style: CustomTextStyles.titleMediumBlack90002,
//                           ),
//                           SizedBox(height: 7.v),
//                           _buildEditProfileEmail(context),
//                           SizedBox(height: 18.v),
//                           Text(
//                             "Password",
//                             style: CustomTextStyles.titleMediumBlack90002,
//                           ),
//                           SizedBox(height: 7.v),
//                           _buildEditProfilePassword(context),
//                           SizedBox(height: 11.v),
//                           Text(
//                             "Date of Birth",
//                             style: CustomTextStyles.titleMediumBlack90002,
//                           ),
//                           SizedBox(height: 7.v),
//                           CustomDropDown(
//                             icon: Container(
//                               margin:
//                                   EdgeInsets.fromLTRB(30.h, 8.v, 20.h, 16.v),
//                               child: CustomImageView(
//                                 imagePath: ImageConstant.imgFavorite,
//                                 height: 20.adaptSize,
//                                 width: 20.adaptSize,
//                               ),
//                             ),
//                             hintText: "23/05/1995",
//                             hintStyle: CustomTextStyles.bodyMediumGray800,
//                             items: dropdownItemList,
//                             onChanged: (value) {},
//                           ),
//                           SizedBox(height: 20.v),
//                           Text(
//                             "Type of Diabetes",
//                             style: CustomTextStyles.titleMediumBlack90002,
//                           ),
//                           SizedBox(height: 5.v),
//                           CustomDropDown(
//                             icon: Container(
//                               margin:
//                                   EdgeInsets.fromLTRB(30.h, 8.v, 20.h, 16.v),
//                               child: CustomImageView(
//                                 imagePath: ImageConstant.imgFavorite,
//                                 height: 20.adaptSize,
//                                 width: 20.adaptSize,
//                               ),
//                             ),
//                             hintText: "Type 1",
//                             hintStyle: CustomTextStyles.bodyMediumGray800,
//                             items: dropdownItemList1,
//                             onChanged: (value) {},
//                           ),
//                           SizedBox(height: 8.v),
//                           Text(
//                             "Date of Diagnosis",
//                             style: CustomTextStyles.titleMediumBlack90002,
//                           ),
//                           SizedBox(height: 5.v),
//                           _buildEditProfileDate(context),
//                           SizedBox(height: 73.v),
//                           _buildSaveChanges(context),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildEditProfileName(BuildContext context) {
//     return CustomTextFormField(
//       controller: editProfileNameController,
//       hintText: "Melissa Peters",
//       hintStyle: CustomTextStyles.bodyMediumGray800,
//     );
//   }

//   /// Section Widget
//   Widget _buildEditProfileEmail(BuildContext context) {
//     return CustomTextFormField(
//       controller: editProfileEmailController,
//       hintText: "melpeters@gmail.com",
//       hintStyle: CustomTextStyles.bodyMediumGray800,
//       textInputType: TextInputType.emailAddress,
//     );
//   }

//   /// Section Widget
//   Widget _buildEditProfilePassword(BuildContext context) {
//     return CustomTextFormField(
//       controller: editProfilePasswordController,
//       hintText: "************",
//       textInputType: TextInputType.visiblePassword,
//       obscureText: true,
//     );
//   }

//   /// Section Widget
//   Widget _buildEditProfileDate(BuildContext context) {
//     return CustomTextFormField(
//       controller: editProfileDateController,
//       hintText: "dd/mm/yyyy",
//       hintStyle: CustomTextStyles.bodyMediumGray800,
//       textInputAction: TextInputAction.done,
//     );
//   }

//   /// Section Widget
//   Widget _buildSaveChanges(BuildContext context) {
//     return CustomElevatedButton(
//       height: 32.v,
//       width: 165.h,
//       text: "Save changes",
//       buttonStyle: CustomButtonStyles.fillOnError,
//       buttonTextStyle: CustomTextStyles.bodyMediumOnErrorContainer14,
//       alignment: Alignment.centerRight,
//     );
//   }
// }
