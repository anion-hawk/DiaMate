import '../../presentation/main_profile_screen/widgets/postlist_item_widget.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_subtitle.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:diamate_frontend/widgets/new.dart';
import 'package:diamate_frontend/presentation/own_post_screen/own_post_screen.dart';
import "package:requests/requests.dart";
import 'package:diamate_frontend/config.dart';
import "package:firebase_auth/firebase_auth.dart";

import 'package:diamate_frontend/views/profile/edit_profile_screen.dart';
import 'package:diamate_frontend/presentation/own_post_screen/own_post_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({Key? key})
      : super(
          key: key,
        );
  @override
  State<MainProfileScreen> createState() => _MainProfileScreen();
}

class _MainProfileScreen extends State<MainProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserFollowDetails();
    fetchPosts();
  }

  int _state = 0;

  void reload() {
    setState(() {
      _state = 0;
    });
  }

  String author = "";
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    try {
       final response = await Requests.get(selfPosts, timeoutSeconds: 300);
      // var response = await Requests.get(
      //   '$selfPosts?id=$author',
      //   headers: {'Content-Type': 'application/json'},
      //   timeoutSeconds: 120,
      // );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('Failed to load posts: $e');
    }
  }

  String name = "gg";
  String followers = "12";
  String followee = "22";
  String likes = "45";
  TextEditingController dateController = TextEditingController();
  List<String> selectedDiseases = [];
  String dType = "";
  TextEditingController ec1Controller = TextEditingController();
  TextEditingController ec2Controller = TextEditingController();
  TextEditingController ec3Controller = TextEditingController();

  TextEditingController editProfileDateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    //getUserFollowDetails();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 6.v),
                  _buildTopPart(context),
                  SizedBox(height: 10.v),
                  const Text('POSTS :',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                      selectionColor: Color.fromARGB(0, 113, 163, 228)),
                  _buildCreatPost(context),
                  SizedBox(height: 25.v),
                  _buildPostListComponent(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopPart(BuildContext context) {
    return FutureBuilder(
      future: getUserFollowDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Data has been successfully fetched, update UI
          return Row(
            children: <Widget>[
              const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color.fromARGB(255, 19, 81, 153),
                  child: Icon(Icons.person, color: Colors.white, size: 40)),
              SizedBox(height: 20.v),
              SizedBox(width: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      selectionColor: const Color.fromARGB(0, 37, 37, 163)),
                  SizedBox(width: 15.h),
                  Row(
                    children: <Widget>[
                      Text('$followers\n followers',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          selectionColor: Color.fromARGB(167, 52, 52, 167)),
                      SizedBox(width: 15.h),
                      Text('$followee\n followee',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          selectionColor:
                              const Color.fromARGB(167, 52, 52, 167)),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildInputData(BuildContext context) {
    return Container(
      width: 120.h,
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 9.v,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer,
        borderRadius:
            BorderRadius.circular(10), // Set your desired border radius
      ),
      child:
          //Text('Email: $email Password: $password'),
          Text(
        "Let’s share what going...",
        style: CustomTextStyles.bodySmallBluegray40003,
      ),
    );
  }

  /// Section Widget
  Widget _buildCreatePostButton(BuildContext context) {
    return CustomElevatedButton(
      height: 34.v,
      width: 100.h,
      text: "Create Post",
      buttonTextStyle: const TextStyle(
        color: Color.fromARGB(255, 250, 254, 255), // Set the desired text color
      ),
      buttonStyle: CustomButtonStyles.fillIndigo,
      onPressed: () async {
        // Add the functionality you want to execute when the button is pressed
        // For example, you can navigate to a new screen:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OwnPostScreen()),
        );

        // After returning from OwnPostScreen, refresh the post list
        await fetchPosts();
        setState(() {}); // Trigger a rebuild to update the UI

        // After returning from OwnPostScreen, refresh the post list
        await fetchPosts();
        setState(() {}); // Trigger a rebuild to update the UI
      },
    );
  }

  Widget _buildCreatPost(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 1.h,
        right: 2.h,
      ),
      padding: EdgeInsets.all(14.h),
      decoration: AppDecoration.fillBlue.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        decoration: AppDecoration.outlineBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgEllipse230x30,
              height: 30.adaptSize,
              width: 30.adaptSize,
              radius: BorderRadius.circular(
                15.h,
              ),
            ),
            _buildInputData(context),
            Expanded(
              child: _buildCreatePostButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostListComponent(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Display a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No posts available');
        } else {
          // Display the posts using ListView.builder
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // Adjust the vertical spacing as needed
                child: PostlistcomponentItemWidget(post: snapshot.data![index]),
              );
            },
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> getUserFollowDetails() async {
    try {
      // Replace 'your_api_endpoint' with the actual API endpoint for fetching user profile
      var response = await Requests.get(selffollowdetails, timeoutSeconds: 120);
      if (response.statusCode == 200) {
        // The response body contains the user profile information
        print('follow Profile: ${response.json()}');
        Map<String, dynamic> responseBody = response.json();

        // Extract values
        name = responseBody['user']['name'].toString();
        followers = responseBody['followerDetails']['count'].toString();
        followee = responseBody['followingDetails']['count'].toString();
        author = responseBody['user']['id'].toString();
        print(name + ' ' + followers + ' ' + author);
        return responseBody;
      } else {
        print(
            'Failed to fetch follow profile. Status Code: ${response.statusCode}');
        print(response.body);
        throw Exception('Failed to load status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during GET request: $e');
      throw Exception('exception: ${e}');
    }
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true, // Center the title
      title: const Text(
        'Profile',
        style: TextStyle(
          fontWeight: FontWeight.bold, // Bold letters
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Back button icon
        onPressed: () {
          // Handle back button press
          // You can add your own logic here
          Navigator.of(context).pop(); // Example: Navigate back
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_hospital),
          color: Colors.red, // Set emergency button color to red
          onPressed: () {
            // Handle emergency button press
            // You can add your own logic here
          },
        ),
        IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.blue, // Set edit button color to blue
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            }),
      ],
    );
  }
}
// class MainProfileScreen extends StatelessWidget {
//   MainProfileScreen({Key? key})
//       : super(
//           key: key,
//         );

//   TextEditingController inputDataController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: _buildAppBar(context),
//         body: SizedBox(
//           width: SizeUtils.width,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(top: 16.v),
//             child: Container(
//               margin: EdgeInsets.only(bottom: 4.v),
//               padding: EdgeInsets.symmetric(horizontal: 9.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildProfileSection(context),
//                   SizedBox(height: 17.v),
//                   Padding(
//                     padding: EdgeInsets.only(left: 8.h),
//                     child: Text(
//                       "Posts",
//                       style: CustomTextStyles.titleLargePoppinsIndigo900Medium,
//                     ),
//                   ),
//                   SizedBox(height: 11.v),
//                   _buildCreatePostSection(context),
//                   SizedBox(height: 39.v),
//                   _buildPostList(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       height: 61.v,
//       leadingWidth: 40.h,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgMaterialSymbol,
//         margin: EdgeInsets.only(
//           left: 10.h,
//           bottom: 27.v,
//         ),
//       ),
//       centerTitle: true,
//       title: AppbarSubtitle(
//         text: " Profile",
//         margin: EdgeInsets.only(top: 27.v),
//       ),
//       actions: [
//         AppbarTrailingImage(
//           imagePath: ImageConstant.imgRectangle22499,
//           margin: EdgeInsets.fromLTRB(15.h, 9.v, 14.h, 9.v),
//         ),
//         AppbarTrailingImage(
//           imagePath: ImageConstant.imgVideoCamera,
//           margin: EdgeInsets.only(
//             left: 14.h,
//             top: 8.v,
//             right: 29.h,
//           ),
//         ),
//       ],
//     );
//   }

//   /// Section Widget
//   Widget _buildProfileSection(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 1.h,
//         right: 32.h,
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             height: 102.v,
//             width: 100.h,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Container(
//                     height: 102.v,
//                     width: 100.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                         51.h,
//                       ),
//                       border: Border.all(
//                         color: theme.colorScheme.onError,
//                         width: 1.h,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     height: 99.v,
//                     width: 96.h,
//                     child: Stack(
//                       alignment: Alignment.bottomRight,
//                       children: [
//                         CustomImageView(
//                           imagePath: ImageConstant.imgEllipse2,
//                           height: 99.v,
//                           width: 96.h,
//                           radius: BorderRadius.circular(
//                             49.h,
//                           ),
//                           alignment: Alignment.center,
//                         ),
//                         CustomImageView(
//                           imagePath: ImageConstant.imgSolarCameraMi,
//                           height: 18.adaptSize,
//                           width: 18.adaptSize,
//                           alignment: Alignment.bottomRight,
//                           margin: EdgeInsets.only(right: 5.h),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: 11.h,
//               top: 6.v,
//               bottom: 6.v,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Melissa Peters",
//                   style: CustomTextStyles.titleLargePoppinsIndigo900,
//                 ),
//                 SizedBox(height: 11.v),
//                 SizedBox(
//                   width: 196.h,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildUserStats(
//                         context,
//                         dynamicText: "122",
//                         dynamicText1: "followers",
//                       ),
//                       _buildUserStats(
//                         context,
//                         dynamicText: "67",
//                         dynamicText1: "following",
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             "37K",
//                             style: theme.textTheme.titleLarge,
//                           ),
//                           SizedBox(height: 5.v),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               "likes",
//                               style: CustomTextStyles.titleSmallInterGray800,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildCreatePostSection(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 7.h),
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
//             CustomTextFormField(
//               width: 174.h,
//               controller: inputDataController,
//               hintText: "Let’s share what going...",
//               hintStyle: CustomTextStyles.bodySmallBluegray40002,
//               textInputAction: TextInputAction.done,
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: 10.h,
//                 vertical: 9.v,
//               ),
//               borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainer,
//               filled: true,
//               fillColor: theme.colorScheme.onErrorContainer,
//             ),
//             CustomElevatedButton(
//               height: 34.v,
//               width: 83.h,
//               text: "Create Post",
//               buttonStyle: CustomButtonStyles.fillIndigo,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildPostList(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 1.h,
//         right: 6.h,
//       ),
//       child: ListView.separated(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         separatorBuilder: (
//           context,
//           index,
//         ) {
//           return SizedBox(
//             height: 20.v,
//           );
//         },
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           return PostlistItemWidget();
//         },
//       ),
//     );
//   }

//   /// Common widget
//   Widget _buildUserStats(
//     BuildContext context, {
//     required String dynamicText,
//     required String dynamicText1,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: 16.h),
//           child: Text(
//             dynamicText,
//             style: theme.textTheme.titleLarge!.copyWith(
//               color: theme.colorScheme.onError,
//             ),
//           ),
//         ),
//         SizedBox(height: 5.v),
//         Text(
//           dynamicText1,
//           style: CustomTextStyles.titleSmallInterGray800.copyWith(
//             color: appTheme.gray800,
//           ),
//         ),
//       ],
//     );
//   }
// }
