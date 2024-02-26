import 'dart:io';
import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import "package:diamate_frontend/presentation/register_patient_screen/widgets/coeliacdiseasechipview_item_widget.dart";
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
  @override
  void initState() {
    super.initState();
    // Fetch data from the backend when the widget is created
    getUserProfile();
  }

  final nameController = TextEditingController(text: "abcd");
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dobController = TextEditingController();
  String selectedRole = "";
  TextEditingController dateController = TextEditingController();
  List<String> selectedDiseases = [];
  String dType = "";
  TextEditingController ec1Controller = TextEditingController();
  TextEditingController ec2Controller = TextEditingController();
  TextEditingController ec3Controller = TextEditingController();

  List<String> dropdownItemList = [
    "Type 1",
    "Type 2",
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
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: SingleChildScrollView(
                      // Wrap your content with SingleChildScrollView
                      child: Column(children: [
                        const Center(
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        imageProfile(),
                        const SizedBox(height: 20),

                        // name
                        const Row(
                          children: [
                            Text(
                              "Name :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                            controller: nameController,
                            hintText: "Name",
                            obscureText: false,
                            icon: const Icon(Icons.person)),
                        const SizedBox(height: 20),

                        // email
                        const Row(
                          children: [
                            Text(
                              "Email :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                            controller: emailController,
                            hintText: "Email",
                            obscureText: false,
                            icon: const Icon(Icons.mail)),
                        const SizedBox(height: 20),

                        // password
                        const Row(
                          children: [
                            Text(
                              "Password :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                            controller: passwordController,
                            hintText: "Password",
                            obscureText: true,
                            icon: const Icon(Icons.lock)),
                        const SizedBox(height: 20),

                        // confirm password
                        const Row(
                          children: [
                            Text(
                              "Confirm Password :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),
                        const SizedBox(height: 10),
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
                        const Row(
                          children: [
                            Text(
                              "Date of Birth :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),
                        const SizedBox(height: 10),
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
                        const Row(
                          children: [
                            Text(
                              "Type of Diabetes :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),

                        CustomDropDown(
                            items: dropdownItemList,
                            hintText: "Type",
                            icon: const Icon(Icons.arrow_drop_down),
                            onChanged: (value) {
                              dType = value;
                            }),
                        const SizedBox(height: 20),

                        // date of diagnosis
                        const Row(
                          children: [
                            Text(
                              "Date of Diagnosis :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            _selectDiagnosisDate(context);
                          },
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                                controller: dateController,
                                hintText: "Date of Diagnosis",
                                obscureText: false,
                                icon: const Icon(Icons.calendar_today_rounded),
                                textInputType: TextInputType.datetime),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // other disieses
                        const Row(
                          children: [
                            Text(
                              "Other Diseases :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),

                        const SizedBox(height: 10),
                        _buildCoeliacDiseaseChipView(context),
                        //emergency contacts
                        const SizedBox(height: 20),
                        const SizedBox(height: 50),

                        const Row(
                          children: [
                            Text(
                              "Emergency Contact :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            // Add additional widgets as needed
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                            controller: ec1Controller,
                            hintText: "Emergency Contact 1",
                            obscureText: false,
                            icon: const Icon(Icons.phone)),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                            controller: ec2Controller,
                            hintText: "Emergency Contact 2",
                            obscureText: false,
                            icon: const Icon(Icons.phone)),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                            controller: ec3Controller,
                            hintText: "Emergency Contact 3",
                            obscureText: false,
                            icon: const Icon(Icons.phone)),
                        const SizedBox(height: 20),

                        // login button
                        CustomElevatedButton(
                            text: "Save Changes",
                            onPressed: () {
                              // register();
                            }),
                        const SizedBox(height: 20),
                        CustomElevatedButton(
                            text: "Log Out",
                            onPressed: () {
                              logOut();
                              Navigator.pop(context);

                            }),
                      ]),
                    )))));
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
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

  void _selectDiagnosisDate(context) {
    showDatePicker(
            context: context,
            initialDate:
                DateTime.now().subtract(const Duration(days: 18 * 365)),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        dateController.text = DateFormat('yyyy-MM-dd').format(value);
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
                      color: Color.fromARGB(255, 25, 12, 108),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 250, 250, 250)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(150.0, 50.0)), // Set your desired background color
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
                      color: Color.fromARGB(255, 25, 12, 108),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 250, 250, 250)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(150.0, 50.0)), // Set your desired background color
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
              color: Color.fromARGB(255, 255, 255, 255),
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  //   /// Section Widget
  /// Section Widget
  Widget _buildCoeliacDiseaseChipView(BuildContext context) {
    return DiseaseWidget(
      onOptionsChanged: (options) {
        print(options.runtimeType);
        // Receive the selected options from DiseaseWidget
        selectedDiseases = options;
        print("Selected Diseases: $selectedDiseases ");
        print(dateController.text);
        print(dType);
      },
    );
  }

  void getUserProfile() async {
    //   try {
    //     // Replace 'your_api_endpoint' with the actual API endpoint for fetching user profile
    //     var response = await Requests.get(url_selfProfile);
    //     print('User Profile: ${response.json()}');
    //     if (response.statusCode == 200) {
    //       // The response body contains the user profile information
    //       print('User Profile: ${response.json()}');
    //     } else {
    //       print(
    //           'Failed to fetch user profile. Status Code: ${response.statusCode}');
    //     }
    //   } catch (e) {
    //     print('Error during GET request: $e');
    //   }
  }
}
