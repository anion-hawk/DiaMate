import "package:diamate_frontend/config.dart";
import "package:diamate_frontend/presentation/forum_screen/forum_screen.dart";
import "package:diamate_frontend/widgets/elevated_button.dart";
import "package:diamate_frontend/views/tracker.dart";
import "package:diamate_frontend/views/planner.dart";

import 'package:diamate_frontend/views/chat/conversation_list.dart';
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
    ConversationList(),
  ];
  @override
  void initState() {
    super.initState();
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
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (int newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
          // Navigate to the respective page based on the selected index
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF012b68),
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Planner',
            icon: Icon(Icons.calendar_month),
          ),
          BottomNavigationBarItem(
            label: 'Tracker',
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            label: 'Doctor',
            icon: Icon(Icons.medication),
          ),
          BottomNavigationBarItem(
            label: 'Message',
            icon: Icon(Icons.message),
          ),
        ],

        selectedItemColor: Colors.blue, // Change the selected icon color here
        unselectedItemColor:
            Colors.white, // Change the unselected icon color here
      ),
    );
  }
}
