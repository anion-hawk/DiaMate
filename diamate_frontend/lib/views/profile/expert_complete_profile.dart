import 'package:diamate_frontend/config.dart';
import 'package:diamate_frontend/routes/app_routes.dart';
import 'package:diamate_frontend/widgets/elevated_button.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class ExpertCompleteProfile extends StatefulWidget {
  const ExpertCompleteProfile({super.key});

  @override
  State<ExpertCompleteProfile> createState() => _ExpertCompleteProfileState();
}

class _ExpertCompleteProfileState extends State<ExpertCompleteProfile> {
  final specialController = TextEditingController();
  final expController = TextEditingController();
  final bmdcController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: ListView(children: [
                      const Center(
                          child: Text("Complete Profile",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 30),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Speciality :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                          controller: specialController,
                          hintText: "Sprecial Degree On",
                          obscureText: false,
                          icon: const Icon(Icons.school),
                          textInputType: TextInputType.text),
                      const SizedBox(height: 20),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Experience :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                          controller: expController,
                          hintText: "in years",
                          obscureText: false,
                          icon: const Icon(Icons.work_history),
                          textInputType: TextInputType.text),
                      const SizedBox(height: 20),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("BM&DC Registration Number :",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                          controller: bmdcController,
                          hintText: "6 digit number",
                          obscureText: false,
                          icon: const Icon(Icons.numbers_outlined),
                          textInputType: TextInputType.text),
                      const SizedBox(height: 30),
                      CustomElevatedButton(
                          text: "Save Profile",
                          onPressed: () {
                            saveDetails();
                          })
                    ])))));
  }

  AppBar _appBar(context) {
    return AppBar(actions: [
      InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
          },
          child: const Row(
            children: [
              Text("Skip",
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 110, 110, 110))),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Color.fromARGB(255, 110, 110, 110),
                size: 30,
              ),
            ],
          ))
    ]);
  }

  void saveDetails() async {
    var b = {
      "speciality": specialController.text,
      "experience": expController.text,
      "bmdc": bmdcController.text
    };
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    await Requests.post(url_complete_profile, body: b).then((response) {
      Navigator.pop(context);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Navigator.pushReplacementNamed(context, AppRoutes.expertHomeScreen);
      } else {
        print("Error: ${response.statusCode}");
      }
    });
  }
}
