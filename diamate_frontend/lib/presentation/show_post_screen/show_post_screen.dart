import 'package:diamate_frontend/config.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_search_view.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final int maxVisibleNestedComments = 3;

class Comment {
  String content;
  List<Comment> nestedComments;

  Comment(this.content, this.nestedComments);
}

// ignore_for_file: must_be_immutable
class ShowPostScreen extends StatefulWidget {
  ShowPostScreen({Key? key}) : super(key: key);

  @override
  _ShowPostScreenState createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {
  String postTime = "";
  String postTitle = "";
  String postContent = "";
  String userName = "";
  String userTimeAgo = "";

  TextEditingController textController = TextEditingController();

  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from the backend when the widget is created
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Replace 'YOUR_BACKEND_URL' with your actual backend API endpoint to get post data
      final response = await http.get(Uri.parse(show_post));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          postTime = data["post_time"];
          postTitle = data["post_title"];
          postContent = data["post_content"];
          userName = data["user_name"];
          userTimeAgo = data["user_time_ago"];
        });
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 1.v),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 11.v),
            Padding(
                padding: EdgeInsets.only(left: 15.h),
                child: Text(postTime,
                    style: CustomTextStyles.bodyMediumPoppinsBlue300)),
            SizedBox(height: 13.v),
            Container(
                width: 313.h,
                margin: EdgeInsets.only(left: 14.h, right: 32.h),
                child: Text(
                    //postTitle,
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula, sodales at lacinia eget, volutpat a augue. Aliquam auctor nisi nisi, vel tristique enim faucibus non. Integer venenatis dui eu diam facilisis consectetur. Nulla facilisi. Sed sed consequat justo. ",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleLargeOxygenPrimary
                        .copyWith(height: 1.20))),
            SizedBox(height: 15.v),
            Align(
                alignment: Alignment.center,
                child: Container(
                    width: 328.h,
                    margin: EdgeInsets.only(left: 15.h, right: 17.h),
                    child: Text(
                        //postContent,
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula, sodales at lacinia eget, volutpat a augue. Aliquam auctor nisi nisi, vel tristique enim faucibus non. Integer venenatis dui eu diam facilisis consectetur. Nulla facilisi. Sed sed consequat justo. ",
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.bodyMediumPoppinsBlack90002))),
            SizedBox(height: 10.v),
            CustomImageView(
                imagePath: ImageConstant.imgRectangle22474,
                height: 240.v,
                width: 349.h),
            SizedBox(height: 12.v),
            _buildArrowRightRow(context),
            SizedBox(height: 21.v),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      // Replace this with your image logic
                      child: Icon(Icons.person),
                      radius: 12.0,
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: CustomTextFormField(
                        controller: textController,
                        hintText: "Write a Comment",
                        hintColor: appTheme.gray500,
                        alignment: Alignment.center,
                        borderDecoration: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                        width:
                            8.0), // Adjust the spacing between the text field and button
                    InkWell(
                      onTap: () {
                        // Handle send button tap
                        // You can access the entered text using textController.text
                      },
                      child: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18.v),

            // Container(
            //     width: 242.h,
            //     margin: EdgeInsets.only(left: 40.h),
            // child: Text(
            //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula",
            //     maxLines: 2,
            //     overflow: TextOverflow.ellipsis,
            //     style: CustomTextStyles.bodySmallPoppinsPrimary)
            _buildComments(comments)

            // )
          ])),
    ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 29.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftOnerrorcontainer,
            margin: EdgeInsets.only(left: 11.h, top: 18.v, bottom: 19.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title:
            AppbarSubtitleOne(text: "Back", margin: EdgeInsets.only(left: 5.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSettingsOnerrorcontainer,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 19.v))
        ],
        styleType: Style.bgFill_1);
  }

  /// Section Widget
  Widget _buildArrowRightRow(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(left: 5.h, right: 15.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRightPrimary,
                  height: 20.v,
                  width: 26.h),
              Text("56.9k", style: CustomTextStyles.titleMediumPoppinsBlue300),
              CustomImageView(
                  imagePath: ImageConstant.imgLightBulb,
                  height: 20.v,
                  width: 26.h),
              Spacer(flex: 39),
              CustomImageView(
                  imagePath: ImageConstant.imgSettingsBlue300,
                  height: 20.adaptSize,
                  width: 20.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 5.h),
                  child: Text("4682",
                      style: CustomTextStyles.titleMediumPoppinsBlue300)),
              Spacer(flex: 60),
              CustomImageView(
                  imagePath: ImageConstant.imgBookmark,
                  height: 20.v,
                  width: 21.h,
                  margin: EdgeInsets.only(bottom: 2.v)),
              CustomImageView(
                  imagePath: ImageConstant.imgTwitter,
                  height: 15.v,
                  width: 16.h,
                  margin: EdgeInsets.only(left: 5.h, top: 4.v, bottom: 4.v))
            ])));
  }

  /// Section Widget
  Widget _buildUserRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 13.h, right: 27.h),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgEllipse169,
              height: 24.v,
              width: 23.h,
              radius: BorderRadius.circular(12.h)),
          Padding(
              padding: EdgeInsets.only(left: 3.h, top: 2.v),
              child: Text("User",
                  style: CustomTextStyles.titleSmallPoppinsBlue300)),
          Spacer(),
          Padding(
              padding: EdgeInsets.only(top: 7.v),
              child: Text("30 minutes ago",
                  style: CustomTextStyles.labelMediumBlue300))
        ]));
  }

  /// Section Widget
  Widget _buildArrowRightRow1(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 39.h, right: 34.h, bottom: 9.v),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
              width: 141.h,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomImageView(
                    imagePath: ImageConstant.imgArrowRightBlueGray300,
                    height: 20.adaptSize,
                    width: 20.adaptSize),
                Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child:
                        Text("50", style: CustomTextStyles.labelLargeBlue300)),
                CustomImageView(
                    imagePath: ImageConstant.imgLightBulbPrimary,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    margin: EdgeInsets.only(left: 2.h)),
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(top: 2.v),
                    child: Text("Reply",
                        style: CustomTextStyles.labelLargeBlue300))
              ])),
          Text("Delete", style: CustomTextStyles.labelLargeBlue300)
        ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildComments(List<Comment> comments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: comments.map((comment) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display current comment content
            _buildUserRow(context),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodySmallPoppinsPrimary

                //style: CustomTextStyles.bodySmallPoppinsPrimary,
                ),
            // Display nested comments
            _buildNestedComments(comment.nestedComments),
            // See More button for additional nested comments
            if (comment.nestedComments.length > maxVisibleNestedComments)
              TextButton(
                onPressed: () {
                  // Handle "See More" button tap
                  print("show more");
                },
                child: Text("See More"),
              ),

            _buildArrowRightRow1(context)
          ],
        );
      }).toList(),
    );
  }

  Widget _buildNestedComments(List<Comment> nestedComments) {
    if (nestedComments.isEmpty) {
      return Container(); // No nested comments
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          nestedComments.take(maxVisibleNestedComments).map((nestedComment) {
        return _buildComments(
            [nestedComment]); // Recursively build nested comments
      }).toList(),
    );
  }
}
