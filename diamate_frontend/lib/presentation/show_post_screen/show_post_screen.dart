import 'package:diamate_frontend/config.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/choice_chips_static.dart';
import 'package:diamate_frontend/widgets/custom_search_view.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  List<String> tags = [];

  @override
  _ShowPostScreenState createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {
  bool showAllComments = true;

  TextEditingController _commentController = TextEditingController();

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
    likeCount = int.parse(widget.post['upvote_count'].toString());
    //fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Replace 'YOUR_BACKEND_URL' with your actual backend API endpoint to get post data
      final response = await Requests.get(show_post);

      if (response.statusCode == 200) {
        // final data = json.decode(response.body);

        setState(() {});
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
                child: Text(
                    DateFormat('HH:mm a, dd MMM yyyy')
                        .format(DateTime.parse(widget.post['created'])),
                    style: CustomTextStyles.bodyMediumPoppinsBlue300)),
            SizedBox(height: 13.v),
            Padding(
                padding: EdgeInsets.only(left: 15.h),
                child: Text(widget.post['author_name'],
                    style: CustomTextStyles.bodyMediumPoppinsBlue300)),
            SizedBox(height: 13.v),
            Container(
                width: 313.h,
                margin: EdgeInsets.only(left: 14.h, right: 32.h),
                child: Text(
                    //postTitle,
                    widget.post['title'],
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
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.bodyMediumPoppinsBlack90002))),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: StaticChoiceChips(
                    options:
                        List<String>.from(jsonDecode(widget.post["tags"]))),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildArrowRightRow(context),
            ),
            const SizedBox(height: 20),
            Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            labelText: 'Write a comment...',
                          ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            _postComment();
                          })
                    ]))),
            const SizedBox(height: 3.5),
            _buildComments(
                context), // Adjust the spacing between the text field and button
          ])),
    ));
  }

  void _postComment() async {
    final req = {
      'id': widget.post['id'],
      'content': _commentController.text,
      'parent': '00000000-0000-0000-0000-000000000000'
    };
    final response = await Requests.post('${url_comments}comment', body: req);

    print(response.statusCode);
  }

  Widget _buildComments(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchComments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No comments'));
        } else {
          // Display the posts using ListView.builder
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  _buildCommentWidget(comments[index]));
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchComments() async {
    try {
      final response = await Requests.get(
          '${url_comments + widget.post['id']}/comments',
          timeoutSeconds: 300);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load comments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching comments: $e');
      throw Exception('Failed to load comments: $e');
    }
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 29.h,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              icon: const Icon(Icons.arrow_back, size: 40, color: Colors.white),
              onPressed: () {
                onTapArrowLeft(context);
              }),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AppbarSubtitleOne(text: widget.post['title']),
        ),
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
                    child: const Icon(Icons.arrow_upward_rounded, size: 25),
                  ),
                  Text(likeCount.toString(),
                      style: CustomTextStyles.titleMediumPoppinsBlue300),
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
                    const Icon(Icons.comment, size: 25),
                    Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: Text(widget.post['comment_count'],
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

  Widget _buildCommentWidget(comment, {int indent = 1}) {
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
                        comment['author_name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm a, dd MMM yyyy')
                            .format(DateTime.parse(comment['created'])),
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
              Text(comment['content']),
            ],
          ),
          // subtitle: Row(
          //   children: [
          //     IconButton(
          //       icon: const Icon(Icons.arrow_upward, size: 20.0),
          //       onPressed: () {
          //         // Handle like/upvote button press
          //         setState(() {
          //           comment.likeCount++;
          //         });
          //       },
          //     ),
          //     Text(comment.likeCount.toString()),
          //     IconButton(
          //       icon: const Icon(Icons.arrow_downward, size: 20.0),
          //       onPressed: () {
          //         // Handle dislike/downvote button press
          //         setState(() {
          //           comment.likeCount--;
          //         });
          //       },
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.reply, size: 20.0),
          //       onPressed: () {
          //         // Handle reply button press
          //       },
          //     ),
          //     IconButton(
          //       icon: const Icon(Icons.delete, size: 20.0),
          //       onPressed: () {
          //         // Handle delete button press
          //       },
          //     ),
          //     if (comment.nestedComments.isNotEmpty)
          //       TextButton(
          //         onPressed: () {
          //           setState(() {
          //             showReplies = !showReplies;
          //           });
          //         },
          //         child: Text(showReplies ? "Hide Replies" : "View Replies"),
          //       ),
          //   ],
          // ),
        ),
        // if (showReplies)
        //   // Display nested comments with replies using recursion
        //   for (int i = 0; i < comment.nestedComments.length; i++)
        //     _buildCommentWidget(comment.nestedComments[i], indent: indent + 2),
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
