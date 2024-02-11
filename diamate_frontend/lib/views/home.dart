import "package:diamate_frontend/widgets/elevated_button.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to DiaMate"),
            const Text("You are now logged in"),
            CustomElevatedButton(
                text: "Log Out",
                onPressed: () {
                  logOut();
                }),
            const Text("let's log out")
          ],
        ),
      ),
    );
  }
}
