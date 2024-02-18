import "dart:async";

import "package:diamate_frontend/config.dart";
import "package:diamate_frontend/widgets/elevated_button.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:requests/requests.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    User user = FirebaseAuth.instance.currentUser!;
    user.getIdToken(true).then((token) {
      print(token);
      if (token != null) {
        Requests.addCookie(Requests.getHostname(baseUrl), "token", token);
      }
    });

    // User user = FirebaseAuth.instance.currentUser!;
    // String cookie = (await user.getIdToken())!;
    // Requests.addCookie(Requests.getHostname(baseUrl), "cookie", cookie);
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void checkCookie() async {
    var response = await Requests.get(url_cookieCheck);
    print(response.statusCode);
    print(response.body);
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
                text: "Check Cookie",
                onPressed: () {
                  checkCookie();
                }),
            CustomElevatedButton(
                text: "Log Out",
                onPressed: () {
                  logOut();
                }),
          ],
        ),
      ),
    );
  }
}
