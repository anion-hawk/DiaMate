// import '../forum_screen/widgets/postlistcomponent_item_widget.dart';
// import 'package:diamate_frontend/core/app_export.dart';
// import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
// import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
// import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
// import 'package:diamate_frontend/widgets/custom_bottom_bar.dart';
// import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
// import 'package:diamate_frontend/widgets/form_text.dart';
// import 'package:diamate_frontend/config.dart';

// import 'package:diamate_frontend/presentation/own_post_screen/own_post_screen.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:flutter/material.dart';

// class ForumScreen extends StatefulWidget {
//   final String email;
//   final String password;
//   ForumScreen({required this.email, required this.password, Key? key})
//       : super(key: key);
//   // ForumScreen({Key? key})
//   //     : super(
//   //         key: key,
//   //       );
//   @override
//   _ForumScreenState createState() => _ForumScreenState();

// }



// class _ForumScreenState extends State<ForumScreen> {

//   TextEditingController inputDataController = TextEditingController();

//   GlobalKey<NavigatorState> navigatorKey = GlobalKey();


//    @override
//   void initState() {
//     super.initState();
//     // Fetch data from the backend when the widget is created
//     fetchPosts();
//   }

  


//   Future<List<Map<String, dynamic>>> fetchPosts() async {
//     final response = await http.get(Uri.parse(forum),
//            headers: {"token": cookies.join(''),});


//     print(cookies);       

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.cast<Map<String, dynamic>>();
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: _buildAppBar(context),
//         body: SingleChildScrollView(
//             child: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(horizontal: 11.h),
//           child: Column(
//             children: [
//               SizedBox(height: 6.v),
//               _buildSidebar(context),
//               SizedBox(height: 10.v),
//               _buildCreatPost(context),
//               SizedBox(height: 25.v),
//               _buildPostListComponent(context),
//             ],
//           ),
//         )),
//         bottomNavigationBar: _buildBottomBar(context),
//       ),
//     );
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       leadingWidth: 42.h,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgMegaphone,
//         margin: EdgeInsets.only(
//           left: 12.h,
//           top: 16.v,
//           bottom: 16.v,
//         ),
//       ),
//       actions: [
//         AppbarTrailingImage(
//           imagePath: ImageConstant.imgProfile,
//           margin: EdgeInsets.fromLTRB(10.h, 19.v, 18.h, 1.v),
//         ),
//         AppbarTrailingImage(
//           imagePath: ImageConstant.imgBellLightOnerrorcontainer,
//           margin: EdgeInsets.fromLTRB(17.h, 19.v, 18.h, 1.v),
//         ),
//         AppbarTrailingImage(
//           imagePath: ImageConstant.imgLockOnerrorcontainer,
//           margin: EdgeInsets.only(
//             left: 19.h,
//             top: 18.v,
//             right: 28.h,
//           ),
//         ),
//       ],
//       styleType: Style.bgFill_1,
//     );
//   }

//   /// Section Widget
//   Widget _buildPopularButton(BuildContext context) {
//     return CustomElevatedButton(
//       height: 40.v,
//       width: 85.h,
//       text: "Popular",
//       leftIcon: Container(
//         margin: EdgeInsets.only(right: 10.h),
//         child: CustomImageView(
//           imagePath: ImageConstant.imgUserBlue300,
//           height: 20.adaptSize,
//           width: 20.adaptSize,
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildFollowingButton(BuildContext context) {
//     return CustomElevatedButton(
//       height: 40.v,
//       width: 121.h,
//       text: "Following",
//       rightIcon: Padding(
//         padding: EdgeInsets.fromLTRB(10.h, 14.v, 11.h, 13.v),
//         child: Text(
//           "24",
//           style: TextStyle(
//             color: Color(0XFFFFFFFF),
//             fontSize: 9.fSize,
//             fontFamily: 'Source Sans Pro',
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       leftIcon: Container(
//         margin: EdgeInsets.only(right: 10.h),
//         child: CustomImageView(
//           imagePath: ImageConstant.imgLockBlue300,
//           height: 20.adaptSize,
//           width: 20.adaptSize,
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildSidebar(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         left: 1.h,
//         right: 2.h,
//       ),
//       padding: EdgeInsets.symmetric(vertical: 10.v),
//       decoration: AppDecoration.outlineBlack900022.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder10,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Container(
//             width: 83.h,
//             padding: EdgeInsets.symmetric(vertical: 6.v),
//             decoration: AppDecoration.fillPrimary.copyWith(
//               borderRadius: BorderRadiusStyle.roundedBorder4,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Card(
//                   clipBehavior: Clip.antiAlias,
//                   elevation: 0,
//                   margin: EdgeInsets.all(0),
//                   color: theme.colorScheme.onErrorContainer,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadiusStyle.roundedBorder4,
//                   ),
//                   child: Container(
//                     height: 28.adaptSize,
//                     width: 28.adaptSize,
//                     padding: EdgeInsets.all(4.h),
//                     decoration: AppDecoration.fillOnErrorContainer.copyWith(
//                       borderRadius: BorderRadiusStyle.roundedBorder4,
//                     ),
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         CustomImageView(
//                           imagePath: ImageConstant.imgStar1,
//                           height: 20.adaptSize,
//                           width: 20.adaptSize,
//                           radius: BorderRadius.circular(
//                             1.h,
//                           ),
//                           alignment: Alignment.center,
//                         ),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "New",
//                             style:
//                                 CustomTextStyles.sourceSansProOnErrorContainer,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: 6.v,
//                     bottom: 5.v,
//                   ),
//                   child: Text(
//                     "Newest",
//                     style: CustomTextStyles
//                         .labelLargeSourceSansProOnErrorContainer,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _buildPopularButton(context),
//           _buildFollowingButton(context),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildInputData(BuildContext context) {
//     return Container(
//       width: 174.h,
//       padding: EdgeInsets.symmetric(
//         horizontal: 10.h,
//         vertical: 9.v,
//       ),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.onErrorContainer,
//         borderRadius:
//             BorderRadius.circular(10), // Set your desired border radius
//       ),
//       child:
//           //Text('Email: $email Password: $password'),
//           Text(
//         "Let’s share what going...",
//         style: CustomTextStyles.bodySmallBluegray40003,
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildCreatePostButton(BuildContext context) {
//     return CustomElevatedButton(
//       height: 34.v,
//       width: 83.h,
//       text: "Create Post",
//       onPressed: () {
//         // Add the functionality you want to execute when the button is pressed
//         // For example, you can navigate to a new screen:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => OwnPostScreen()),
//         );
//       },
//     );
//   }

//   /// Section Widget
//   Widget _buildCreatPost(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         left: 1.h,
//         right: 2.h,
//       ),
//       padding: EdgeInsets.all(14.h),
//       decoration: AppDecoration.fillBlue.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder10,
//       ),
//       child: Container(
//         decoration: AppDecoration.outlineBlack,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CustomImageView(
//               imagePath: ImageConstant.imgEllipse230x30,
//               height: 30.adaptSize,
//               width: 30.adaptSize,
//               radius: BorderRadius.circular(
//                 15.h,
//               ),
//             ),
//             _buildInputData(context),
//             _buildCreatePostButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildPostListComponent(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: fetchPosts(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Display a loading indicator
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Text('No posts available');
//         } else {
//           // Display the posts using ListView.builder
//           return ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(
//                     vertical: 8.0), // Adjust the vertical spacing as needed
//                 child: PostlistcomponentItemWidget(post: snapshot.data![index]),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }

// /// Section Widget
// Widget _buildBottomBar(BuildContext context) {
//   return CustomBottomBar(
//     onChanged: (BottomBarEnum type) {},
//   );
// }
