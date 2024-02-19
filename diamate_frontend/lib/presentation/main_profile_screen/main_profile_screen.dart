import '../main_profile_screen/widgets/postlist_item_widget.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_subtitle.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatelessWidget {
  MainProfileScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController inputDataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 16.v),
            child: Container(
              margin: EdgeInsets.only(bottom: 4.v),
              padding: EdgeInsets.symmetric(horizontal: 9.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(context),
                  SizedBox(height: 17.v),
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "Posts",
                      style: CustomTextStyles.titleLargePoppinsIndigo900Medium,
                    ),
                  ),
                  SizedBox(height: 11.v),
                  _buildCreatePostSection(context),
                  SizedBox(height: 39.v),
                  _buildPostList(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 61.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMaterialSymbol,
        margin: EdgeInsets.only(
          left: 10.h,
          bottom: 27.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: " Profile",
        margin: EdgeInsets.only(top: 27.v),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgRectangle22499,
          margin: EdgeInsets.fromLTRB(15.h, 9.v, 14.h, 9.v),
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgVideoCamera,
          margin: EdgeInsets.only(
            left: 14.h,
            top: 8.v,
            right: 29.h,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildProfileSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 1.h,
        right: 32.h,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 102.v,
            width: 100.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 102.v,
                    width: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        51.h,
                      ),
                      border: Border.all(
                        color: theme.colorScheme.onError,
                        width: 1.h,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 99.v,
                    width: 96.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgEllipse2,
                          height: 99.v,
                          width: 96.h,
                          radius: BorderRadius.circular(
                            49.h,
                          ),
                          alignment: Alignment.center,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgSolarCameraMi,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(right: 5.h),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 11.h,
              top: 6.v,
              bottom: 6.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Melissa Peters",
                  style: CustomTextStyles.titleLargePoppinsIndigo900,
                ),
                SizedBox(height: 11.v),
                SizedBox(
                  width: 196.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildUserStats(
                        context,
                        dynamicText: "122",
                        dynamicText1: "followers",
                      ),
                      _buildUserStats(
                        context,
                        dynamicText: "67",
                        dynamicText1: "following",
                      ),
                      Column(
                        children: [
                          Text(
                            "37K",
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 5.v),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "likes",
                              style: CustomTextStyles.titleSmallInterGray800,
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
    );
  }

  /// Section Widget
  Widget _buildCreatePostSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7.h),
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
            CustomTextFormField(
              width: 174.h,
              controller: inputDataController,
              hintText: "Let’s share what going...",
              hintStyle: CustomTextStyles.bodySmallBluegray40002,
              textInputAction: TextInputAction.done,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 9.v,
              ),
              borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainer,
              filled: true,
              fillColor: theme.colorScheme.onErrorContainer,
            ),
            CustomElevatedButton(
              height: 34.v,
              width: 83.h,
              text: "Create Post",
              buttonStyle: CustomButtonStyles.fillIndigo,
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPostList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 1.h,
        right: 6.h,
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 20.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return PostlistItemWidget();
        },
      ),
    );
  }

  /// Common widget
  Widget _buildUserStats(
    BuildContext context, {
    required String dynamicText,
    required String dynamicText1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text(
            dynamicText,
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onError,
            ),
          ),
        ),
        SizedBox(height: 5.v),
        Text(
          dynamicText1,
          style: CustomTextStyles.titleSmallInterGray800.copyWith(
            color: appTheme.gray800,
          ),
        ),
      ],
    );
  }
}
