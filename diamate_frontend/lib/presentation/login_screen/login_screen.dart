// import 'dart:convert';
// import 'dart:io';

// import 'package:diamate_frontend/core/app_export.dart';
// import 'package:diamate_frontend/presentation/forum_screen/forum_screen.dart';
// import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
// import 'package:diamate_frontend/widgets/form_text.dart';
// import 'package:diamate_frontend/widgets/custom_flat_button.dart';
// import 'package:diamate_frontend/presentation/register_screen/register_screen.dart';
// import 'package:diamate_frontend/routes/app_routes.dart';

// import 'package:http/http.dart' as http;
// import 'package:diamate_frontend/config.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// //0 - Admin; 1 - Patient; 2 - Doctor

// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key})
//       : super(
//           key: key,
//         );
//   bool _isNotValid = false;
//   TextEditingController emailController = TextEditingController();

//   TextEditingController passwordController = TextEditingController();

//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   // void loginUser() async {
//   //   if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//   //     var reqbody = {
//   //       "email": emailController.text,
//   //       "password": passwordController.text
//   //     };
//   //     print(reqbody);
//   //     var response = await http.post(Uri.parse(login),
//   //         headers: {"ContentType": "application/json"}, body: reqbody);
//   //     print(response.body);
//   //   } else {
//   //     print("hoynaiiiiiiii");
//   //   }
//   // }
//   void loginUser(BuildContext context) async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       var reqbody = {
//         "email": emailController.text,
//         "password": passwordController.text
//       };
//       print(reqbody);

//       try {
//         var response = await http.post(Uri.parse(login),
//             headers: {"ContentType": "application/json"}, body: reqbody);

//         if (response.statusCode == 200) {
//           // Login successful
//           print(response.body);
//           cookies.add(jsonDecode(response.body)['cookie']);
//           print(cookies);
//           // Navigate to the next screen or perform any other actions
//           Navigator.pushNamed(
//             context,
//             AppRoutes.forumScreen,
//             arguments: {
//               'email': emailController.text,
//               'password': passwordController.text,
//             },
//           );
//         } else {
//           // Login unsuccessful
//           print("Login failed. Incorrect email or password.");

//           // Show an AlertDialog with an error message
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Login Failed"),
//                 content: Text("Incorrect email or password. Please try again."),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                     },
//                     child: Text("OK"),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       } catch (error) {
//         // Handle network errors or other exceptions
//         print("An error occurred: $error");

//         // Show an AlertDialog with an error message
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Error"),
//               content: Text("An error occurred. Please try again later."),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   child: Text("OK"),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Empty Field"),
//             content: Text("Please Enter Username and Password"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: SizedBox(
//           width: SizeUtils.width,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Container(
//                 width: double.maxFinite,
//                 padding: EdgeInsets.symmetric(vertical: 29.v),
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Container(
//                         height: 63.v,
//                         width: 60.h,
//                         margin: EdgeInsets.only(left: 27.h),
//                         child: Stack(
//                           alignment: Alignment.bottomLeft,
//                           children: [
//                             CustomImageView(
//                               imagePath: ImageConstant.imgIcon3,
//                               height: 60.adaptSize,
//                               width: 60.adaptSize,
//                               alignment: Alignment.topCenter,
//                             ),
//                             // CustomImageView(
//                             //   imagePath: ImageConstant.imgIcon1,
//                             //   height: 42.adaptSize,
//                             //   width: 42.adaptSize,
//                             //   alignment: Alignment.bottomLeft,
//                             //   margin: EdgeInsets.only(left: 3.h),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     CustomImageView(
//                       imagePath: ImageConstant.login,
//                       height: 268.v,
//                       width: 360.h,
//                     ),
//                     SizedBox(height: 40.v),
//                     // Padding(
//                     //   padding: EdgeInsets.only(
//                     //     left: 33.h,
//                     //     right: 34.h,
//                     //   ),
//                     //   child: CustomTextFormField(
//                     //     controller: emailController,
//                     //     hintText: "email",
//                     //     hintStyle: theme.textTheme.labelLarge!,
//                     //     textInputType: TextInputType.emailAddress,
//                     //     prefix: Container(
//                     //       margin: EdgeInsets.fromLTRB(18.h, 15.v, 11.h, 15.v),
//                     //       child: CustomImageView(
//                     //         imagePath: ImageConstant.imgLockBlueGray100,
//                     //         height: 16.v,
//                     //         width: 20.h,
//                     //       ),
//                     //     ),
//                     //     prefixConstraints: BoxConstraints(
//                     //       maxHeight: 46.v,
//                     //     ),
//                     //     contentPadding: EdgeInsets.only(
//                     //       top: 14.v,
//                     //       right: 30.h,
//                     //       bottom: 14.v,
//                     //     ),
//                     //   ),
//                     // ),
//                     // SizedBox(height: 16.v),
//                     // Padding(
//                     //   padding: EdgeInsets.only(
//                     //     left: 33.h,
//                     //     right: 34.h,
//                     //   ),
//                     //   child: CustomTextFormField(
//                     //     controller: passwordController,
//                     //     hintText: "password",
//                     //     hintStyle: theme.textTheme.labelLarge!,
//                     //     textInputAction: TextInputAction.done,
//                     //     textInputType: TextInputType.visiblePassword,
//                     //     prefix: Container(
//                     //       margin: EdgeInsets.fromLTRB(16.h, 9.v, 9.h, 13.v),
//                     //       child: CustomImageView(
//                     //         imagePath: ImageConstant.imgMaterialSymbolsLock,
//                     //         height: 24.adaptSize,
//                     //         width: 24.adaptSize,
//                     //       ),
//                     //     ),
//                     //     prefixConstraints: BoxConstraints(
//                     //       maxHeight: 46.v,
//                     //     ),
//                     //     obscureText: true,
//                     //     contentPadding: EdgeInsets.only(
//                     //       top: 14.v,
//                     //       right: 30.h,
//                     //       bottom: 14.v,
//                     //     ),
//                     //   ),
//                     // ),
//                     SizedBox(height: 16.v),
//                     CustomElevatedButton(
//                         text: "Login",
//                         margin: EdgeInsets.only(
//                           left: 33.h,
//                           right: 34.h,
//                         ),
//                         buttonTextStyle: CustomTextStyles
//                             .titleMediumPoppinsOnErrorContainerMedium,
//                         onPressed: () {
//                           print('pressed');

//                           loginUser(context);
//                         }),
//                     SizedBox(height: 37.v),
//                     Text(
//                       "Don’t have an account?",
//                       style: CustomTextStyles.labelLargeBluegray900,
//                     ),
//                     SizedBox(height: 6.v),
//                     CustomFlatButton(
//                       text: "Register Now",
//                       buttonTextStyle: const TextStyle(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.blue,
//                       ),
//                       onPressed: () {
//                         // Handle button press
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => RegisterScreen()),
//                         );
//                       },
//                     ),
//                     SizedBox(height: 5.v),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
