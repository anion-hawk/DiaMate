// import 'package:diamate_frontend/core/app_export.dart';
// import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
// import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
// import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
// import 'package:diamate_frontend/widgets/form_text.dart';
// import 'package:flutter/material.dart';
// import 'package:diamate_frontend/widgets/custom_flat_button.dart';
// import 'package:diamate_frontend/presentation/login_screen/login_screen.dart';


// class ExpertRegistertwoScreen extends StatelessWidget {
//   ExpertRegistertwoScreen({Key? key})
//       : super(
//           key: key,
//         );

//   TextEditingController nidController = TextEditingController();

//   TextEditingController certificatesValueController = TextEditingController();

//   TextEditingController experienceValueController = TextEditingController();

//   TextEditingController descriptionValueController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: _buildAppBar(context),
//         body: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(
//             horizontal: 33.h,
//             vertical: 64.v,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildNid(context),
//               SizedBox(height: 19.v),
//               _buildCertificatesValue(context),
//               SizedBox(height: 27.v),
//               _buildExperienceValue(context),
//               SizedBox(height: 16.v),
//               _buildDescriptionValue(context),
//               Spacer(),
//               _buildRegister(context),
//               SizedBox(height: 16.v),
//               Text(
//                 "Already have an account?",
//                 style: CustomTextStyles.labelLargeBluegray900,
//               ),
//               SizedBox(height: 4.v),
//               CustomFlatButton(
//                       text: "Login",
//                       buttonTextStyle: TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.blue,
//                       ),
//                       onPressed: () {
//                         // Handle button press
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()),
//                         );
//                       },
//                     ),
//               SizedBox(height: 5.v),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       height: 90.v,
//       leadingWidth: double.maxFinite,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgIcon3,
//         margin: EdgeInsets.only(
//           left: 24.h,
//           right: 276.h,
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildNid(BuildContext context) {
//     return CustomTextFormField(
//       controller: nidController,
//       hintText: "NID",
//       hintStyle: theme.textTheme.labelLarge!,
//     );
//   }

//   /// Section Widget
//   Widget _buildCertificatesValue(BuildContext context) {
//     return CustomTextFormField(
//       controller: certificatesValueController,
//       hintText: "Certificates",
//       hintStyle: theme.textTheme.labelLarge!,
//     );
//   }

//   /// Section Widget
//   Widget _buildExperienceValue(BuildContext context) {
//     return CustomTextFormField(
//       controller: experienceValueController,
//       hintText: "Experience",
//       hintStyle: theme.textTheme.labelLarge!,
//     );
//   }

//   /// Section Widget
//   Widget _buildDescriptionValue(BuildContext context) {
//     return CustomTextFormField(
//       controller: descriptionValueController,
//       hintText: "Description",
//       hintStyle: theme.textTheme.labelLarge!,
//       textInputAction: TextInputAction.done,
//       maxLines: 6,
//     );
//   }

//   /// Section Widget
//   Widget _buildRegister(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Register",
//       buttonTextStyle:
//           CustomTextStyles.titleMediumPoppinsOnErrorContainerMedium,
//     );
//   }
// }
