import 'dart:ui';

import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';
import 'tags5_item_widget.dart';
import 'package:intl/intl.dart';
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
                  //imagePath: ImageConstant.profile,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  radius: BorderRadius.circular(
                    4.h,
                  ),
                  margin: EdgeInsets.only(bottom: 64.v),
                ),
                Container(
                  height: 119.v,
                  width: 237.h,
                  margin: EdgeInsets.only(left: 14.h),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User details (name and time)
                    _buildNameTime(context),

                    SizedBox(height: 5.v),

                    // Post title
                    _buildTitle(context),

                    SizedBox(height: 12.v),

                    // Like and comment information
                    Row(
                      children: [
                        _buildUpvote(context),
                        _buildUpvoteText(context),
                        _buildComment(context),
                        _buildCommentText(context),
                      ],
                    ),
                  ],
                ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      post['title'],
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: CustomTextStyles.labelLargeSourceSansProPrimary.copyWith(
        //FontVariation.opticalSize(32),
        height: 1.50,
      ),
    );
  }

  Widget _buildUpvote(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Icon(Icons.arrow_upward,weight: 1200,
          size: 23, color: Color(0xDD6699ff)),
    );
  }

  Widget _buildUpvoteText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Text(
        post['upvotes'].toString(),
        style: CustomTextStyles.bodySmallPrimary,
      ),
    );
  }

  Widget _buildComment(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.h),
      child: Icon(Icons.comment,
          size: 23, color: Color(0xDD6699ff)),
    );
  }

  Widget _buildCommentText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h),
      child: Text(
        post['comments'].toString(),
        style: CustomTextStyles.bodySmallPrimary,
      ),
    );
  }

  Widget _buildContextList(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.v),
            //title
            _buildTitle(context),
            SizedBox(height: 8.v),

            SizedBox(height: 12.v),
            Row(
              children: [
//upvote
                _buildUpvote(context),
                _buildUpvoteText(context),
                _buildComment(context),
                _buildCommentText(context),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNameTime(BuildContext context) {
    return Row(
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
              DateFormat('HH:mm a, dd MMM yyyy').format(DateTime.parse(post['created'])),
  // Replace with the actual time logic
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 7.h),
          ],
        ),
      ],
    );
  }
}