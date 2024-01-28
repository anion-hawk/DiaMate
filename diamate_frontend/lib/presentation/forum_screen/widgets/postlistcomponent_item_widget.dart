import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';
import 'tags5_item_widget.dart';
import 'package:diamate_frontend/presentation/show_post_screen/show_post_screen.dart';

// ignore: must_be_immutable
class PostlistcomponentItemWidget extends StatelessWidget {
  const PostlistcomponentItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another page here
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPostScreen()));
      },
     child : Container(
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
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "56 comments",
                            style: CustomTextStyles.bodySmallPrimary,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(right: 44.h),
                            child: ListView(
                              children: [Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 170.h,
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula, sodales at lacinia ...",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles
                                        .labelLargeSourceSansProPrimary
                                        .copyWith(
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.v),
                                Wrap(
                                  runSpacing: 10.v,
                                  spacing: 10.h,
                                  children: List<Widget>.generate(
                                      2, (index) => Tags5ItemWidget()),
                                ),
                                SizedBox(height: 21.v),
                                Row(
                                  children: [
                                    Text(
                                      "651,324 Views",
                                      style: CustomTextStyles.bodySmallPrimary,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 30.h),
                                      child: Text(
                                        "36,6545 Likes",
                                        style:
                                            CustomTextStyles.bodySmallPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle4238,
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  radius: BorderRadius.circular(
                    10.h,
                  ),
                  alignment: Alignment.topRight,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    )
    );
  }
}
