import 'package:diamate_frontend/config.dart';
import 'package:diamate_frontend/widgets/app_bar/app_bar_trailing_button.dart';
import 'package:diamate_frontend/widgets/choice_chips.dart';
import 'package:requests/requests.dart';

import '../own_post_screen/widgets/healthchipview_item_widget.dart';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_title.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_icon_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  final List<String> availableTags = [
    'health',
    'medicine',
    'lifestyle',
    'exercise',
    'motivation'
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<String> selectedTags = [];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void savePost(BuildContext context) async {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      var reqbody = {
        "title": titleController.text,
        "content": contentController.text,
        "tags": jsonEncode(selectedTags)
      };
      print(reqbody);
      var response = await Requests.post(own_post, body: reqbody);
      print(response.statusCode);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        //Navigator.pop(context);
      } else {
        print("Error: ${response.statusCode}");
      }
    } else {
      print("hoynaiiiiiiii");
    }
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
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "Enter title",
                          hintStyle: theme.textTheme.headlineLarge,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.transparent,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                        ),
                      ),
                      SizedBox(height: 21.v),
                      TextField(
                        controller: contentController,
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
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 15.0), // Adjust padding as needed
                        ),
                      ),
                      const Spacer(),
                      _buildTags(),
                    ]))));
  }

  Widget _buildTags() {
    return ChoiceChips(
        onOptionsChanged: (options) {
          selectedTags = options;
        },
        options: availableTags);
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
          IconButton(
              color: Colors.white,
              onPressed: () {
                savePost(context);

                onTapClose(context);
              },
              icon: const Icon(Icons.send))
        ],
        styleType: Style.bgFill_1);
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }
}
