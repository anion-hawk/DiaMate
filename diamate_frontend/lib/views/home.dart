import "dart:async";

import "package:diamate_frontend/config.dart";
import "package:diamate_frontend/presentation/forum_screen/forum_screen.dart";
import "package:diamate_frontend/widgets/elevated_button.dart";
import "package:diamate_frontend/presentation/all_tracker_screen/sugar_tracker_screen.dart";
import "package:diamate_frontend/presentation/tracker_home_screen/tracker_home_screen.dart";
import "package:diamate_frontend/presentation/show_planner_screen/show_planner_screen.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:requests/requests.dart";



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;

  final List<Widget> _pages = [
    ForumScreen(),
    ShowPlanner(),
    TrackerHomeScreen(),
    ForumScreen(),
    ForumScreen(),
  ];
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
  }

  bool state = false;

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void toggleState() {
    setState(() {
      state = !state;
    });
  }

  void checkCookie() async {
    var response = await Requests.get(url_cookieCheck);
    print(response.statusCode);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {

    if (state) return ForumScreen();

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
                text: "Forum",
                onPressed: () {
                  toggleState();

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
