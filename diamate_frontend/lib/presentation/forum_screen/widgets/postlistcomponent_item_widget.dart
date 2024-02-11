import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';
import 'tags5_item_widget.dart';
import 'package:diamate_frontend/presentation/show_post_screen/show_post_screen.dart';

// ignore: must_be_immutable
class PostlistcomponentItemWidget extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostlistcomponentItemWidget({required this.post, Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Navigate to another page here
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShowPostScreen(post: post)));
        },
        child: Container(
          padding: EdgeInsets.all(13.h),
          decoration: AppDecoration.outlineBlue.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle24,
                  height: 56.adaptSize,
                  width: 56.adaptSize,
                  radius: BorderRadius.circular(
                    4.h,
                  ),
                  margin: EdgeInsets.only(bottom: 64.v),
                ),
                Container(
                  height: 119.v,
                  width: 237.h,
                  margin: EdgeInsets.only(left: 14.h),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 118.v,
                          width: 215.h,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              // Align(
                              //   alignment: Alignment.bottomRight,
                              //   child: Text(
                              //     "56 comments",
                              //     style: CustomTextStyles.bodySmallPrimary,
                              //   ),
                              // ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 44.h),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 170
                                          .h, // Set a maximum width for the ListView
                                    ),
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post['title'],
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTextStyles
                                                  .labelLargeSourceSansProPrimary
                                                  .copyWith(
                                                height: 1.50,
                                              ),
                                            ),
                                            SizedBox(height: 8.v),
                                            // Wrap(
                                            //   runSpacing: 10.v,
                                            //   spacing: 10.h,
                                            //   children: List<Widget>.generate(
                                            //       2, (index) => Tags5ItemWidget()),
                                            // ),
                                            SizedBox(height: 21.v),
                                            Row(
                                              children: [
                                                // Icon(Icons.remove_red_eye,
                                                //     size: 16,
                                                //     color: Colors.blue),
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       left: 8.h),
                                                //   child: Text(
                                                //     "651,324",
                                                //     style: CustomTextStyles
                                                //         .bodySmallPrimary,
                                                //   ),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.h),
                                                  child: Icon(Icons.thumb_up,
                                                      size: 16,
                                                      color: Colors.blue),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.h),
                                                  child: Text(
                                                    post['upvotes'].toString(),
                                                    style: CustomTextStyles
                                                        .bodySmallPrimary,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15.h),
                                                  child: Icon(Icons.comment,
                                                      size: 16,
                                                      color: Colors.blue),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.h),
                                                  child: Text(
                                                    post['comments'].toString(),
                                                    style: CustomTextStyles
                                                        .bodySmallPrimary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          // User details (name and time)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['author']['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                post['created'], // Replace with the actual time logic
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              width:
                                  8.0), // Adjust the spacing between user details and image
                          // Image
                          CustomImageView(
                           // imagePath: ImageConstant.imgRectangle4238,
                            height: 30.adaptSize,
                            width: 30.adaptSize,
                            radius: BorderRadius.circular(10.h),
                            alignment: Alignment.topRight,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
