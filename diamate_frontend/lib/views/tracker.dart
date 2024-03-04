import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/view_widgets/pressure_tracker/pressure_tracker_screen.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_floating_button.dart';
import 'package:diamate_frontend/view_widgets/sugar_tracker/sugar_tracker_screen.dart';
import 'package:flutter/material.dart';

class TrackerHomeScreen extends StatefulWidget {
  TrackerHomeScreen({Key? key}) : super(key: key);

  @override
  _TrackerHomeScreenState createState() => _TrackerHomeScreenState();
}

class _TrackerHomeScreenState extends State<TrackerHomeScreen> {
  int selectedIndex = 0; // Default selected index

  List<String> menuItems = ["Statistics", "Blood Sugar", "Blood Pressure"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(menuItems[selectedIndex]),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: Row(
          children: [
            //_buildNavigationSidebar(context),
            Expanded(
              child: _buildMainContent(context),
            ),
          ],
        ),
        //bottomNavigationBar: _buildBottomBar(context),
        floatingActionButton: _buildFloatingActionButton(context),
        drawer: _buildDrawer(context),
      ),
    );
  }

  Widget _buildNavigationSidebar(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed
      decoration: BoxDecoration(
        color: Colors.blue, // Change the color of the sidebar
      ),
      child: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            menuItems[index],
            style: TextStyle(
              color: index == selectedIndex ? Color(0xdd6699ff) : Colors.white,
            ),
          ),
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            // Handle navigation or content update based on the selected item
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    // Replace this with your main content based on the selected option
    return Center(
      child: Text(
        menuItems[selectedIndex],
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  // /// Section Widget
//   Widget _buildBottomBar(BuildContext context) {
//   return 
//       //body: Placeholder(), // Replace Placeholder with your desired content
//       BottomNavigationBar(
//         currentIndex: 0, // Set the initial index as needed
//         onTap: (int newIndex) {
//           // Handle navigation when tabs are tapped
//           // You can implement navigation logic here
//         },
//         items: const [
//           BottomNavigationBarItem(
//             label: 'Home',
//             backgroundColor: Color(0xFF3366ff),
//             icon: Icon(Icons.home),
//           ),
//           BottomNavigationBarItem(
//             label: 'Planner',
//             icon: Icon(Icons.calendar_month),
//           ),
//           BottomNavigationBarItem(
//             label: 'Tracker',
//             icon: Icon(Icons.calendar_today),
//           ),
//           BottomNavigationBarItem(
//             label: 'Doctor',
//             icon: Icon(Icons.medication),
//           ),
//           BottomNavigationBarItem(
//             label: 'Message',
//             icon: Icon(Icons.message),
//           ),
//         ],
//       );
    
// }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
      height: 50,
      width: 50,
      backgroundColor: appTheme.indigo900,
      child: CustomImageView(
        imagePath: ImageConstant.imgMaterialSymbolsAdd,
        height: 25.0.v,
        width: 25.0.h,
      ),
    );
  }

 
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF142a68),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgIcon2,
              height: 60.adaptSize,
              width: 60.adaptSize,
              margin:  EdgeInsets.only(left: 10.0, top: 13.0),
              alignment: Alignment.topLeft,
            ),
                SizedBox(height: 100,),
            
            ListTile(
              title: Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Handle menu item 1
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrackerHomeScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Blood Sugar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SugarTrackerScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Blood Pressure',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Handle menu item 3
                 Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PressureTrackerScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
