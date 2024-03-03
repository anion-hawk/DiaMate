import "doctor_list.dart";
import "forum.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    AdminForumPage(),
    DoctorScreen(),
  ];
  @override
  void initState() {
    super.initState();
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
            label: 'Doctors Verification',
            icon: Icon(Icons.medical_services_outlined,),
          ),
          
        ],
        backgroundColor: const Color.fromARGB(255, 8, 22, 106),
        selectedItemColor: Colors.blue, // Change the selected icon color here
        unselectedItemColor:
            Colors.white, // Change the unselected icon color here
      ),
    );
  }
}
