import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/elevated_button.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? toggleLogin;
  const LoginScreen({super.key, this.toggleLogin});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState(toggleLogin: toggleLogin);
}

class _LoginScreenState extends State<LoginScreen> {
  final void Function()? toggleLogin;

  _LoginScreenState({this.toggleLogin});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";

  void logIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Navigator.pop(context);
        print("Invalid email or password");
        showError();
      }
    }
  }

  void showError() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: const Text("Invalid email or password"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ]));
  }

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
                          text: "Login",
                          onPressed: () {
                            logIn();
                          }),
                      // register button
                      const SizedBox(height: 40),
                      const Center(child: Text("Don't have an account?")),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                          text: "Register",
                          onPressed: () {
                            print("Register pressed");
                            toggleLogin!();
                          }),
                    ])))));
  }
}
