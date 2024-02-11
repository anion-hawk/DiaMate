import 'package:diamate_frontend/core/app_export.dart';
import 'package:diamate_frontend/presentation/tracker_home_screen/tracker_home_screen.dart';
import 'package:diamate_frontend/presentation/forum_screen/newforum.dart';
//import 'package:diamate_frontend/presentation/tracker_side_bar_draweritem/tracker_side_bar_draweritem.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHomeBlue300,
      activeIcon: ImageConstant.imgHomeBlue300,
      type: BottomBarEnum.Homeblue300,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgCalendarOnerrorcontainer,
      activeIcon: ImageConstant.imgCalendarOnerrorcontainer,
      type: BottomBarEnum.Calendaronerrorcontainer,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgCalendarOnerrorcontainer24x24,
      activeIcon: ImageConstant.imgCalendarOnerrorcontainer24x24,
      type: BottomBarEnum.Calendaronerrorcontainer24x24,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSettings,
      activeIcon: ImageConstant.imgSettings,
      type: BottomBarEnum.Settings,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUserGray5001,
      activeIcon: ImageConstant.imgUserGray5001,
      type: BottomBarEnum.Usergray5001,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 24.adaptSize,
              width: 24.adaptSize,
              color: theme.colorScheme.onErrorContainer,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 20.adaptSize,
              width: 20.adaptSize,
              color: appTheme.blue300,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          if (bottomMenuList[index].type == BottomBarEnum.Calendaronerrorcontainer) {
            // If 'Calendaronerrorcontainer' is tapped, navigate to 'show_sugar_tracker'
            selectedIndex = index;
            widget.onChanged?.call(bottomMenuList[index].type);
            Navigator.push(context, MaterialPageRoute(builder: (context) => TrackerHomeScreen()),);
            
          } 
          else if(bottomMenuList[index].type == BottomBarEnum.Homeblue300){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewForum()),);
          }
            else {
            selectedIndex = index;
            widget.onChanged?.call(bottomMenuList[index].type);
            setState(() {});
          }
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Homeblue300,
  Calendaronerrorcontainer,
  Calendaronerrorcontainer24x24,
  Settings,
  Usergray5001,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
