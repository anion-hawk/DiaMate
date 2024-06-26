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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    child: ListView(children: [
                      // app logo

                      // image
                      Image.asset(
                        ImageConstant.login,
                        height: 300.v,
                        width: 400.h,
                      ),
                      const SizedBox(height: 10),

                      const Center(
                        child: Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                      const SizedBox(height: 5),

                      if (errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
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
                            toggleLogin!();
                          })
                    ])))));
  }

  void logIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the loading dialog

      // Show error dialog based on the exception code
      showError(e.code);
    }
  }

   void showError(String errorCode) {
    setState(() {
      if (errorCode == 'user-not-found') {
        errorMessage = "User not found";
      } else if (errorCode == 'wrong-password') {
        errorMessage = "Wrong password";
      } else {
        errorMessage = "Invalid email or password";
      }
    });
  }
}
