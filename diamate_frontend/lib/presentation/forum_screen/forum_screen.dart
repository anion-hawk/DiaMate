import 'package:diamate_frontend/widgets/elevated_button.dart';

import '../forum_screen/widgets/new.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/config.dart';
import "package:firebase_auth/firebase_auth.dart";


import 'package:diamate_frontend/views/profile/main_profile_screen.dart';

import "package:requests/requests.dart";

import 'package:diamate_frontend/presentation/own_post_screen/own_post_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  
  ForumScreen({Key? key})
      : super(key: key);
  
  @override
  _ForumScreenState createState() => _ForumScreenState();

}

class _ForumScreenState extends State<ForumScreen> {

  TextEditingController inputDataController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  int _state = 0;

  void reload() {
    setState(() {
      _state = 0;
    });
  }

   @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser!;
    user.getIdToken(true).then((token) {
      print("Token");
      print(token);
      if (token != null) {
        Requests.addCookie(Requests.getHostname(baseUrl), "token", token);
      }
    });
    // Fetch data from the backend when the widget is created
    fetchPosts();
  }

  

 Future<List<Map<String, dynamic>>> fetchPosts() async {
  try {
    final response = await Requests.get(forum,timeoutSeconds: 300);

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
            child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 11.h),
          child: Column(
            children: [
              SizedBox(height: 6.v),
              _buildRowBar(context),
              SizedBox(height: 10.v),
              _buildCreatPost(context),
              SizedBox(height: 25.v),
              _buildPostListComponent(context),
            ],
          ),
        )),
        //bottomNavigationBar: _buildBottomBar(context),
        //bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }


   Widget _buildRowBar(BuildContext context){
    return SizedBox( 
      child:SizedBox(
      height:100,
      width: 450,
      child: Row(
        children: [
          Expanded(child: ElevatedButton(onPressed: (){print('New');}, child: const Text('Newest',selectionColor: Color.fromARGB(255,255,255,255),),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Colors.white),
            ),)),
          SizedBox(width: 10),
          Expanded(child: ElevatedButton(onPressed: (){print('Popular');}, child: const Text('Popular'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Colors.white),
            ),)),
          SizedBox(width: 10),
          Expanded(child: ElevatedButton(onPressed: (){print('following');}, child: const Text('Following'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Colors.white),
            ),)),      
        ],
      ),
      ),);
  }

  Color iconColor = Colors.white;
  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return  AppBar(
         title: const Text('DiaMate'),
         actions: [
        IconButton(
          onPressed: () {
            setState(() {
              iconColor = Colors.blue; // Change icon color to blue
            });
            // Add functionality for search action
          },
          icon: Icon(Icons.search),
          color: iconColor,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              iconColor = Colors.blue; // Change icon color to blue
            });
            // Add functionality for notifications action
          },
          icon: Icon(Icons.notifications),
          color: iconColor,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              iconColor = Colors.blue; // Change icon color to blue
            });

             Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainProfileScreen()),
        );
            // Add functionality for person action
          },
          icon: Icon(Icons.person),
          color: iconColor,
        ),
      ],
         backgroundColor: Color(0xFF042142),
        );
  }

  
  /// Section Widget
  Widget _buildInputData(BuildContext context) {
    return Container(
      width: 174.h,
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
      width: 83.h,
      text: "Create Post",
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

 

  /// Section Widget
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
            _buildCreatePostButton(context),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPostListComponent(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No posts available');
        } else {
          // Display the posts using ListView.builder
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0), // Adjust the vertical spacing as needed
                child: PostlistcomponentItemWidget(post: snapshot.data![index]),
              );
            },
          );
        }
      },
    );
  }
}
