import "package:diamate_frontend/view_widgets/medicine_tracker/medicine_tracker.dart";
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:diamate_frontend/core/app_export.dart';
//import 'package:diamate_frontend/presentation/all_tracker_screen/pressure_tracker_screen.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_leading_image.dart';
import 'package:diamate_frontend/widgets/app_bar/appbar_trailing_image.dart';
import 'package:diamate_frontend/widgets/app_bar/custom_app_bar.dart';
import 'package:diamate_frontend/widgets/custom_drop_down.dart';
import 'package:diamate_frontend/widgets/custom_floating_button.dart';
import 'package:diamate_frontend/view_widgets/diet_planner/add_diet_screen.dart';

import 'package:diamate_frontend/view_widgets/diet_planner/mealListwidget.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ShowPlanner(),
  ));
}

class ShowPlanner extends StatefulWidget {
  const ShowPlanner({super.key});

  @override
  State<ShowPlanner> createState() => _ShowPlannerState();
}

class _ShowPlannerState extends State<ShowPlanner> {
  DateTime? selectedDay =
      DateTime.now(); // Define a variable to store the selected day

  bool isHovering = false;
  void _ondaySelected(DateTime day, DateTime focused) {
    setState(() {
      today = day;
      selectedDay = day;
    });
  }

  DateTime today = DateTime.now();
  @override
  int selectedIndex = 0; // Default selected index

  List<String> menuItems = ["Diet Planner", "Medicine Planner"];

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
        body: SingleChildScrollView( 
          child: Row(
          children: [
            //_buildNavigationSidebar(context),
            Expanded(
              child: content(),
            ),
          ],
        ),
      ),
        // bottomNavigationBar: _buildBottomBar(context),
        drawer: _buildDrawer(context),
      ),
    );
  }

  Widget _buildNavigationSidebar(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed
      decoration: BoxDecoration(
        color: Color(0xff012b68), // Change the color of the sidebar
      ),
      child: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            menuItems[index],
            style: TextStyle(
              color: index == selectedIndex ? Color(0xff012b68) : Colors.white,
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

  /// Section Widget

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
              margin: EdgeInsets.only(left: 10.0, top: 13.0),
              alignment: Alignment.topLeft,
            ),
            SizedBox(height: 200),
            ListTile(
              title: Text(
                'Diet Planner',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowPlanner()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Medicine Planner',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Handle menu item 3
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedicineTrackerScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        Container(
          child: TableCalendar(
            locale: "en_US",
            rowHeight: 40,
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 365 * 5)),
            onDaySelected: _ondaySelected,
          ),
        ),
        SizedBox(
            height: 20), // Add some space between the calendar and the button
        selectedDay != null ? _buildSetScedule(context) : SizedBox(),

        // Render _buildSetSchedule only if a day is selected
        SizedBox(height: 20.v),
        selectedDay != null ? _buildUserMealList(context) : SizedBox(),
      ],
    );
  }

  Widget _buildSetScedule(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // Implement your logic for setting schedule here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddDietScreen()),
            );
          },
          onTapUp: (_) {
            setState(() {
              isHovering = true;
            });
          },
          onTapDown: (_) {
            setState(() {
              isHovering = false;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: isHovering
                  ? Color.fromARGB(255, 22, 56, 85)
                  : Color(0xff3366ff),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Set Schedule',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
            width:
                20), // Add some space between the button and the edge of the screen
      ],
    );
  }

  Widget _buildUserMealList(BuildContext context) {
    return  Container(
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 10.v);
        },
        itemCount: 50,
        itemBuilder: (context, index) {
          return UserMeallistItemWidget(
              // Pass any necessary data to UserMeallistItemWidget
              );
        },
      ),
    );
  }
}
