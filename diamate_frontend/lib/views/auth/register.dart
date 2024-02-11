import 'dart:developer';

import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/elevated_button.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  final void Function()? toggleLogin;
  const Register({super.key, this.toggleLogin});

  @override
  State<Register> createState() => _RegisterState(toggleLogin: toggleLogin);
}

class _RegisterState extends State<Register> {
  final void Function()? toggleLogin;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _RegisterState({this.toggleLogin});

  List<String> accountTypes = ["Patient", "Expert"];

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dobController = TextEditingController();
  String selectedRole = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: ListView(children: [
        const Center(
          child: Text(
            "Register",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 30), // image
        const CircleAvatar(
            radius: 40,
            backgroundColor: Color.fromARGB(255, 19, 81, 153),
            child: Icon(Icons.person, color: Colors.white, size: 40)),
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

        //role
        CustomDropDown(
            items: accountTypes,
            hintText: "Account Type",
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (value) {
              selectedRole = value;
            }),
        const SizedBox(height: 20),

        // login button
        CustomElevatedButton(
            text: "Register",
            onPressed: () {
              register();
            }),
        // register button
        const SizedBox(height: 40),
        const Center(child: Text("Already have an account?")),
        const SizedBox(height: 20),
        CustomElevatedButton(
            text: "Login",
            onPressed: () {
              toggleLogin!();
            })
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

  void register() async {
    try {
      // if (!_formKey.currentState!.validate()) {
      //   return;
      // }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
