import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/widgets/form_text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    child: Column(children: [
                      // app logo

                      // image
                      Image.asset(
                        ImageConstant.login,
                        height: 300.v,
                        width: 400.h,
                      ),
                      const SizedBox(height: 40),
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
                          icon: const Icon(Icons.lock))
                      // login button

                      // register button
                    ])))));
  }
}
