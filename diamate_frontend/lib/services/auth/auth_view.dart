import "package:diamate_frontend/views/auth/login.dart";
import "package:diamate_frontend/views/auth/register.dart";
import "package:flutter/material.dart";

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool showLogin = true;

  void toggleLogin() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginScreen(toggleLogin: toggleLogin)
        : Register(toggleLogin: toggleLogin);
  }
}
