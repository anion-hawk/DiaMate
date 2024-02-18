import 'dart:io';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
//import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:diamate_frontend/widgets/elevated_button.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:diamate_frontend/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:requests/requests.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key})
      : super(
          key: key,
        );
  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dobController = TextEditingController();
  String selectedRole = "";

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  List<String> dropdownItemList1 = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  TextEditingController editProfileDateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final networkHandler = NetworkHandler();
  bool circular = false;
  PickedFile? _imageFile = null;

  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
            child: Center(
                child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: ListView(children: [
        const Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        imageProfile(),
        const SizedBox(height: 20),

        // name
        CustomTextFormField(
            controller: nameController,
            hintText: "Name",
            obscureText: false,
            icon: const Icon(Icons.person)),
        const SizedBox(height: 20),

        // email
        CustomTextFormField(
            controller: emailController,
            hintText: "Email",
            obscureText: false,
            icon: const Icon(Icons.mail)),
        const SizedBox(height: 20),

        // password
        CustomTextFormField(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
            icon: const Icon(Icons.lock)),
        const SizedBox(height: 20),

        // confirm password
        CustomTextFormField(
            controller: confirmPasswordController,
            hintText: "Confirm Password",
            obscureText: true,
            icon: const Icon(Icons.lock),
            validator: (value) {
              if (value != passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            }),
        const SizedBox(height: 20),

        // dob
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: AbsorbPointer(
            child: CustomTextFormField(
                controller: dobController,
                hintText: "Date of Birth",
                obscureText: false,
                icon: const Icon(Icons.calendar_today_rounded),
                textInputType: TextInputType.datetime),
          ),
        ),

        const SizedBox(height: 20),

        // login button
        CustomElevatedButton(
            text: "Register",
            onPressed: () {
              // register();
            }),
        // register button
        const SizedBox(height: 40),
        const Center(child: Text("Already have an account?")),
      ]),
    ))));
  }

  void _selectDate(context) {
    showDatePicker(
            context: context,
            initialDate:
                DateTime.now().subtract(const Duration(days: 18 * 365)),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        dobController.text = DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  label: const Text(
                    "Camera",
                    style: TextStyle(
                      color: Color.fromARGB(255, 121, 163, 167),
                    ),
                  ),
                  style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 162, 218, 174)),
                   minimumSize: MaterialStateProperty.all<Size>(Size(150.0, 50.0)), // Set your desired background color
                   ),
                ),
                SizedBox(width: 18.0), // Add horizontal space
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  label: const Text(
                    "Gallery",
                    style: TextStyle(
                      color: Color.fromARGB(255, 121, 163, 167),
                    ),
                  ),
                  style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 162, 218, 174)),
                   minimumSize: MaterialStateProperty.all<Size>(Size(150.0, 50.0)), // Set your desired background color
                   ),
                ),
              ],
            )
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    try {
      XFile? pickedFile = await _picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = PickedFile(pickedFile.path);
        });
      } else {
        // The user canceled the image selection
        print('Image selection canceled');
      }
    } catch (e) {
      // Handle any exceptions that might occur during image selection
      print('Error during image selection: $e');
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? const AssetImage("assets/images/img_icon_2.png")
                  as ImageProvider<Object>?
              : FileImage(File(_imageFile?.path ?? "")),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 92, 150, 0),
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }
}
