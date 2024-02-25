import 'package:diamate_frontend/config.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_search_view.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:http/http.dart' as http;
import 'dart:convert';

const maxVisibleNestedComments = 3;
bool showReplies = false;
bool showComment = false;
bool showLikes = false;
int likeCount = 0;

class Comment {
  String content;
  User user;
  List<Comment> nestedComments;
  int likeCount;
  DateTime timestamp;

  Comment(this.content, this.user, this.likeCount, this.timestamp,
      this.nestedComments);
}

class User {
  String username;
  String profilePicture;

  User(this.username, this.profilePicture);
}

// ignore_for_file: must_be_immutable
class ShowPostScreen extends StatefulWidget {
  final Map<String, dynamic> post;
  ShowPostScreen({required this.post, Key? key}) : super(key: key);

  @override
  _ShowPostScreenState createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {
  bool showAllComments = true;
  // String postTime = "";
  // String postTitle = "";
  // String postContent = "";
  // String userName = "";
  // String userTimeAgo = "";

  TextEditingController textController = TextEditingController();

  List<Comment> comments = [
    Comment(
      "This is the first comment.",
      User("User1", "profile_picture_url1"),
      12,
      DateTime.now(),
      [
        Comment("Reply to the first comment.",
            User("User2", "profile_picture_url2"), 10, DateTime.now(), []),
        Comment("Another reply to the first comment.",
            User("User3", "profile_picture_url3"), 12, DateTime.now(), []),
      ],
    ),
    Comment("This is the second comment.",
        User("User4", "profile_picture_url4"), 11, DateTime.now(), []),
    Comment(
      "This is the third comment.",
      User("User5", "profile_picture_url5"),
      12,
      DateTime.now(),
      [
        Comment("Reply to the third comment.",
            User("User6", "profile_picture_url6"), 16, DateTime.now(), []),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch data from the backend when the widget is created
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Replace 'YOUR_BACKEND_URL' with your actual backend API endpoint to get post data
      final response = await Requests.get(show_post);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // postTime = data["post_time"];
          // postTitle = data["post_title"];
          // postContent = data["post_content"];
          // userName = data["user_name"];
          // userTimeAgo = data["user_time_ago"];
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
                child: Text(widget.post['created'],
                    style: CustomTextStyles.bodyMediumPoppinsBlue300)),
            SizedBox(height: 13.v),
            Container(
                width: 313.h,
                margin: EdgeInsets.only(left: 14.h, right: 32.h),
                child: Text(
                    //postTitle,
                    widget.post['title'],
                    //"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula, sodales at lacinia eget, volutpat a augue. Aliquam auctor nisi nisi, vel tristique enim faucibus non. Integer venenatis dui eu diam facilisis consectetur. Nulla facilisi. Sed sed consequat justo. ",
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
                        widget.post['content'],
                        //"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula, sodales at lacinia eget, volutpat a augue. Aliquam auctor nisi nisi, vel tristique enim faucibus non. Integer venenatis dui eu diam facilisis consectetur. Nulla facilisi. Sed sed consequat justo. ",
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
                      if (showComment)
                        const CircleAvatar(
                          radius: 12.0,
                          child: Icon(Icons.person),
                        ),
                      if (showComment) const SizedBox(width: 5.0),
                      if (showComment)
                        Expanded(
                          child: CustomTextFormField(
                            controller: textController,
                            hintText: "Write a Comment",
                            obscureText: false,
                          ),
                        ),
                      if (showComment) const SizedBox(width: 8.0),
                      if (showComment)
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.send),
                        ),
                    ],
                  )),
            ),
            const SizedBox(
                height:
                    3.5), // Adjust the spacing between the text field and button

            if (showAllComments)
              // Render all comments
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) =>
                      _buildCommentWidget(comments[index]),
                ),
              ),

            // Container(
            //     width: 242.h,
            //     margin: EdgeInsets.only(left: 40.h),
            // child: Text(
            //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula",
            //     maxLines: 2,
            //     overflow: TextOverflow.ellipsis,
            //     style: CustomTextStyles.bodySmallPoppinsPrimary)

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
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle increase button tap
                      setState(() {
                        likeCount++;
                      });
                    },
                    child: CustomImageView(
                      imagePath: ImageConstant.imgArrowRightPrimary,
                      height: 20.v,
                      width: 26.h,
                    ),
                  ),
                  Text(likeCount.toString(),
                      style: CustomTextStyles.titleMediumPoppinsBlue300),
                  GestureDetector(
                    onTap: () {
                      // Handle decrease button tap
                      setState(() {
                        likeCount--;
                      });
                    },
                    child: CustomImageView(
                      imagePath: ImageConstant.imgLightBulb,
                      height: 20.v,
                      width: 26.h,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Toggle the visibility of the section when the button is pressed
                    showComment = !showComment;
                  });
                },
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgSettingsBlue300,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: Text("4682",
                          style: CustomTextStyles.titleMediumPoppinsBlue300),
                    ),
                  ],
                ),
              )

              //Spacer(flex: 60),
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
          const Spacer(),
          Padding(
              padding: EdgeInsets.only(top: 7.v),
              child: Text("30 minutes ago",
                  style: CustomTextStyles.labelMediumBlue300))
        ]));
  }

  Widget _buildCommentWidget(Comment comment, {int indent = 1}) {
    const indentWidth = 25.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(
              left: indent * indentWidth, right: 15.h, top: 5.v, bottom: 5.v),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(comment.user.profilePicture),
                    radius: 20.0,
                    child: Align(
                      alignment: const Alignment(0, 0),
                      child: Container(),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.user.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        timeago.format(comment.timestamp, locale: 'en_short'),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Text(comment.content),
            ],
          ),
          subtitle: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_upward, size: 20.0),
                onPressed: () {
                  // Handle like/upvote button press
                  setState(() {
                    comment.likeCount++;
                  });
                },
              ),
              Text(comment.likeCount.toString()),
              IconButton(
                icon: const Icon(Icons.arrow_downward, size: 20.0),
                onPressed: () {
                  // Handle dislike/downvote button press
                  setState(() {
                    comment.likeCount--;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.reply, size: 20.0),
                onPressed: () {
                  // Handle reply button press
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20.0),
                onPressed: () {
                  // Handle delete button press
                },
              ),
              if (comment.nestedComments.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      showReplies = !showReplies;
                    });
                  },
                  child: Text(showReplies ? "Hide Replies" : "View Replies"),
                ),
            ],
          ),
        ),
        if (showReplies)
          // Display nested comments with replies using recursion
          for (int i = 0; i < comment.nestedComments.length; i++)
            _buildCommentWidget(comment.nestedComments[i], indent: indent + 2),
      ],
    );
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
                const Spacer(),
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
}
