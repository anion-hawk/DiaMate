import 'dart:convert';

import 'package:diamate_frontend/config.dart';
import "package:diamate_frontend/view_widgets/medicine_tracker/medicine_tracker.dart";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:requests/requests.dart';
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

  @override
  void initState() {
    super.initState();
    // User user = FirebaseAuth.instance.currentUser!;
    // user.getIdToken(true).then((token) {
    //   print("Token");
    //   print(token);
    //   if (token != null) {
    //     Requests.addCookie(Requests.getHostname(baseUrl), "token", token);
    //   }
    // });
    // // Fetch data from the backend when the widget is created
    fetchDietList();
  }

  Future<List<Map<String, dynamic>>> fetchDietList() async {
    try {
      String s =DateFormat('yyyy/MM/dd').format(selectedDay!);
     var b = {"dt": s};
     print(b);

      final response =
          await Requests.post(dietlist,body:b, timeoutSeconds: 120);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load diet list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching diets: $e');
      throw Exception('Failed to load dietlists: $e');
    }
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
            firstDay: DateTime.utc(2010, 10, 16),
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

  // Widget _buildUserMealList(BuildContext context) {
  //   return  Container(
  //     child: ListView.separated(
  //       physics: NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       separatorBuilder: (context, index) {
  //         return SizedBox(height: 10.v);
  //       },
  //       itemCount: 50,
  //       itemBuilder: (context, index) {
  //         return UserMeallistItemWidget(
  //             // Pass any necessary data to UserMeallistItemWidget
  //             );
  //       },
  //     ),
  //   );
  // }
  Widget _buildUserMealList(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDietList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error in fetching the data, display an error message
          return Text('Error: ${snapshot.error}');
        } else {
          // If the data has been successfully fetched, build the UI using the data
          List<Map<String, dynamic>> meds = snapshot.data ?? [];
          return Padding(
            padding: EdgeInsets.only(left: 7.h, right: 4.h),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 21.v);
              },
              itemCount: meds.length,
              itemBuilder: (context, index) {
                return UserMeallistItemWidget(data: meds[index]);
              },
            ),
          );
        }
      },
    );
  }
}
