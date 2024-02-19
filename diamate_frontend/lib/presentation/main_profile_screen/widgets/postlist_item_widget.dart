import 'package:diamate_version2/core/app_export.dart';
import 'package:flutter/material.dart';
import 'tags3_item_widget.dart';

// ignore: must_be_immutable
class PostlistItemWidget extends StatelessWidget {
  const PostlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: theme.colorScheme.onErrorContainer,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.blue300,
          width: 1.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 148.v,
        width: 335.h,
        padding: EdgeInsets.all(13.h),
        decoration: AppDecoration.outlineBlue.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 22.h),
                child: Text(
                  "56 comments",
                  style: CustomTextStyles.bodySmallIndigo900,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle24,
                    height: 56.adaptSize,
                    width: 56.adaptSize,
                    radius: BorderRadius.circular(
                      4.h,
                    ),
                    margin: EdgeInsets.only(bottom: 63.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 14.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 170.h,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisi ligula, sodales at lacinia ...",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles
                                .labelLargeSourceSansProIndigo900
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
                              3, (index) => Tags3ItemWidget()),
                        ),
                        SizedBox(height: 21.v),
                        Row(
                          children: [
                            Text(
                              "651,324 Views",
                              style: CustomTextStyles.bodySmallIndigo900,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.h),
                              child: Text(
                                "36,6545 Likes",
                                style: CustomTextStyles.bodySmallIndigo900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
