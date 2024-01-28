import '../own_post_screen/widgets/healthchipview_item_widget.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_title.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_icon_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class OwnPostScreen extends StatefulWidget {

  @override
  _OwnPostScreen createState() => _OwnPostScreen();
}

class _OwnPostScreen extends State<OwnPostScreen> {

  //OwnPostScreen({Key? key}) : super(key: key);

  late XFile? _image;

  

  Future<void> _pickImage() async {
    print('pressed');
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 17.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 9.v),
                      //TextField(
                        // decoration: InputDecoration(
                        //   hintText: "Enter title",
                        //   hintStyle: theme.textTheme.headlineLarge,
                        //   border: InputBorder.none,
                        //   filled: true,
                        //   fillColor: Colors.transparent,
                        //   contentPadding: EdgeInsets.symmetric(
                        //       horizontal: 10.0, vertical: 15.0),
                        // ),
                      //),
                      SizedBox(height: 21.v),
                      TextField(
                        style: CustomTextStyles.bodyLargePoppinsPrimary,
                        maxLines:
                            null, // Set to null or a specific number to allow multiline input
                        decoration: InputDecoration(
                          hintText: "Let's share what's going....",
                          hintStyle: CustomTextStyles.bodyLargePoppinsPrimary
                              .copyWith(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none, // Remove the border
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 15.0), // Adjust padding as needed
                        ),
                      ),
                      Spacer(),
                      _buildHealthChipView(context),
                      SizedBox(height: 17.v),
                      Row(children: [
                        CustomIconButton(
                            height: 40.adaptSize,
                            width: 40.adaptSize,
                            //onPressed: _pickImage,
                            child: CustomImageView(
                                imagePath: ImageConstant.imgUserPrimary40x40)
                                ),
                        
                      ])
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgClose,
            margin: EdgeInsets.only(left: 15.h, top: 16.v, bottom: 13.v),
            onTap: () {
              onTapClose(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Create Post"),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSave,
              margin: EdgeInsets.fromLTRB(5.h, 13.v, 5.h, 9.v))
        ],
        styleType: Style.bgFill_1);
  }

  /// Section Widget
  Widget _buildHealthChipView(BuildContext context) {
    return Wrap(
        runSpacing: 9.49.v,
        spacing: 9.49.h,
        children:
            List<Widget>.generate(1, (index) => HealthchipviewItemWidget()));
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }
}