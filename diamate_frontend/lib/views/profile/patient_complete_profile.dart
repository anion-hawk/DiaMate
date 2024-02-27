import 'package:diamate_frontend/routes/app_routes.dart';
import 'package:diamate_frontend/widgets/choice_chips.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientCompleteProfile extends StatelessWidget {
  PatientCompleteProfile({super.key});

  final List<String> diabetesTypes = ["Type 1", "Type 2", "None"];
  final List<String> diseases = [
    'Hypertension',
    'Cataract',
    'PCOS',
    'Coeliac disease',
    'Diabetes insipidus',
    'Thyroid disease',
    'Insulin resistance',
  ];

  String diabetesType = "None";
  final diagnosisDateController = TextEditingController();
  List<String> selectedOptions = [];

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
                      CustomDropDown(
                          items: diabetesTypes,
                          hintText: "Diabetes Type",
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (value) {
                            diabetesType = value;
                          }),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          _selectDate(context, diagnosisDateController);
                        },
                        child: AbsorbPointer(
                          child: CustomTextFormField(
                              controller: diagnosisDateController,
                              hintText: "Date of Diagnosis",
                              obscureText: false,
                              icon: const Icon(Icons.calendar_today_rounded),
                              textInputType: TextInputType.datetime),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Other Diseases",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      _diseaseChoiceChips(),
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
            Navigator.pushReplacementNamed(context, AppRoutes.forumScreen);
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

  Widget _diseaseChoiceChips() {
    return ChoiceChips(
        onOptionsChanged: (options) {
          selectedOptions = options;
          print("Selected Diseases: $selectedOptions");
        },
        options: diseases);
  }

  void _selectDate(context, controller) {
    showDatePicker(
            context: context,
            initialDate:
                DateTime.now().subtract(const Duration(days: 18 * 365)),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        controller.text = DateFormat('yyyy-MM-dd').format(value);
      }
    });
  }

  void saveDetails() {
    print("Diabetes Type: $diabetesType");
    print("Diagnosis Date: ${diagnosisDateController.text}");
    print("Selected Diseases: $selectedOptions");
  }
}
