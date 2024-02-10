import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/elevated_button.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final void Function()? toggleLogin;
  const Register({super.key, this.toggleLogin});

  @override
  State<Register> createState() => _RegisterState(toggleLogin: toggleLogin);
}

class _RegisterState extends State<Register> {
  final void Function()? toggleLogin;

  _RegisterState({this.toggleLogin});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ListView(children: [
                      // app logo

                      // image
                      Image.asset(
                        ImageConstant.login,
                        height: 300.v,
                        width: 400.h,
                      ),
                      const SizedBox(height: 30),
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
                      // login button
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                          text: "Register",
                          onPressed: () {
                            print("Register pressed");
                          }),
                      // register button
                      const SizedBox(height: 40),
                      const Center(child: Text("Already have an account?")),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                          text: "Login",
                          onPressed: () {
                            print("Login pressed");
                            toggleLogin!();
                          }),
                    ])))));
  }
}
