//github::::::::::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

import 'dart:js';

import 'package:flutter/material.dart';
// import 'package:diamate_frontend/presentation/others_profile_screen/others_profile_screen.dart';
// import 'package:diamate_frontend/presentation/main_profile_screen/main_profile_screen.dart';
// import 'package:diamate_frontend/presentation/edit_profile_screen/edit_profile_screen.dart';
// import 'package:diamate_frontend/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:diamate_frontend/presentation/register_screen/register_screen.dart';
import 'package:diamate_frontend/presentation/register_patient_screen/register_patient_screen.dart';
import 'package:diamate_frontend/presentation/login_screen/login_screen.dart';
//import 'package:diamate_frontend/presentation/planner_screen/planner_screen.dart';
// import 'package:diamate_frontend/presentation/add_diet_screen/add_diet_screen.dart';
// import 'package:diamate_frontend/presentation/show_planner_screen/show_planner_screen.dart';
// import 'package:diamate_frontend/presentation/medicine_container_screen/medicine_container_screen.dart';
// import 'package:diamate_frontend/presentation/medicine_edit_screen/medicine_edit_screen.dart';
import 'package:diamate_frontend/presentation/forum_screen/forum_screen.dart';
// import 'package:diamate_frontend/presentation/post_screen/post_screen.dart';
// import 'package:diamate_frontend/presentation/notifications_screen/notifications_screen.dart';
// import 'package:diamate_frontend/presentation/own_post_screen/own_post_screen.dart';
// import 'package:diamate_frontend/presentation/edit_sugar_level_screen/edit_sugar_level_screen.dart';
// import 'package:diamate_frontend/presentation/tracker_home_screen/tracker_home_screen.dart';
// import 'package:diamate_frontend/presentation/sugar_tracker_screen/sugar_tracker_screen.dart';
// import 'package:diamate_frontend/presentation/blood_pressure_show_all_screen/blood_pressure_show_all_screen.dart';
// import 'package:diamate_frontend/presentation/blood_pressure_edit_screen/blood_pressure_edit_screen.dart';
// import 'package:diamate_frontend/presentation/selection_screen/selection_screen.dart';
// import 'package:diamate_frontend/presentation/doctor_hospital_tab_container_screen/doctor_hospital_tab_container_screen.dart';
// import 'package:diamate_frontend/presentation/about_doctor_screen/about_doctor_screen.dart';
// import 'package:diamate_frontend/presentation/new_screen/new_screen.dart';
// import 'package:diamate_frontend/presentation/groups_tab_container_screen/groups_tab_container_screen.dart';
// import 'package:diamate_frontend/presentation/new_group_one_screen/new_group_one_screen.dart';
// import 'package:diamate_frontend/presentation/msg_screen/msg_screen.dart';
// import 'package:diamate_frontend/presentation/messegewithpeers_tab_container_screen/messegewithpeers_tab_container_screen.dart';
import 'package:diamate_frontend/presentation/expert_register_screen/expert_register_screen.dart';
import 'package:diamate_frontend/presentation/expert_registertwo_screen/expert_registertwo_screen.dart';
// import 'package:diamate_frontend/presentation/doctor_profile_screen/doctor_profile_screen.dart';
// import 'package:diamate_frontend/presentation/doctor_edit_profile_screen/doctor_edit_profile_screen.dart';
// import 'package:diamate_frontend/presentation/doctor_edit_profile_two_screen/doctor_edit_profile_two_screen.dart';
// import 'package:diamate_frontend/presentation/doctor_forum_screen/doctor_forum_screen.dart';
import 'package:diamate_frontend/presentation/show_post_screen/show_post_screen.dart';
// import 'package:diamate_frontend/presentation/admin_forum_screen/admin_forum_screen.dart';
// import 'package:diamate_frontend/presentation/post_report_screen/post_report_screen.dart';
// import 'package:diamate_frontend/presentation/show_post_report_screen/show_post_report_screen.dart';
// import 'package:diamate_frontend/presentation/doctor_list_screen/doctor_list_screen.dart';
// import 'package:diamate_frontend/presentation/verify_doctor_screen/verify_doctor_screen.dart';
// import 'package:diamate_frontend/presentation/message_admin_tab_container_screen/message_admin_tab_container_screen.dart';
// import 'package:diamate_frontend/presentation/diet_medicine_screen/diet_medicine_screen.dart';
// import 'package:diamate_frontend/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String othersProfileScreen = '/others_profile_screen';

  static const String mainProfileScreen = '/main_profile_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String userProfileScreen = '/user_profile_screen';

  static const String registerScreen = '/register_screen';

  static const String registerPatientScreen = '/register_patient_screen';

  static const String loginScreen = '/login_screen';

  static const String plannerScreen = '/planner_screen';

  static const String addDietScreen = '/add_diet_screen';

  static const String showPlannerScreen = '/show_planner_screen';

  static const String medicinePage = '/medicine_page';

  static const String medicineContainerScreen = '/medicine_container_screen';

  static const String medicineEditScreen = '/medicine_edit_screen';

  static const String forumScreen = '/forum_screen';

  static const String postScreen = '/post_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String ownPostScreen = '/own_post_screen';

  static const String editSugarLevelScreen = '/edit_sugar_level_screen';

  static const String trackerHomeScreen = '/tracker_home_screen';

  static const String sugarTrackerScreen = '/sugar_tracker_screen';

  static const String bloodPressureShowAllScreen =
      '/blood_pressure_show_all_screen';

  static const String bloodPressureEditScreen = '/blood_pressure_edit_screen';

  static const String selectionScreen = '/selection_screen';

  static const String doctorHospitalPage = '/doctor_hospital_page';

  static const String doctorHospitalTabContainerScreen =
      '/doctor_hospital_tab_container_screen';

  static const String aboutDoctorScreen = '/about_doctor_screen';

  static const String newScreen = '/new_screen';

  static const String groupsPage = '/groups_page';

  static const String groupsTabContainerScreen = '/groups_tab_container_screen';

  static const String newGroupOneScreen = '/new_group_one_screen';

  static const String msgScreen = '/msg_screen';

  static const String messegewithpeersPage = '/messegewithpeers_page';

  static const String messegewithpeersTabContainerScreen =
      '/messegewithpeers_tab_container_screen';

  static const String expertRegisterScreen = '/expert_register_screen';

  static const String expertRegistertwoScreen = '/expert_registertwo_screen';

  static const String doctorProfileScreen = '/doctor_profile_screen';

  static const String doctorEditProfileScreen = '/doctor_edit_profile_screen';

  static const String doctorEditProfileTwoScreen =
      '/doctor_edit_profile_two_screen';

  static const String doctorForumScreen = '/doctor_forum_screen';

  static const String showPostScreen = '/show_post_screen';

  static const String adminForumScreen = '/admin_forum_screen';

  static const String postReportScreen = '/post_report_screen';

  static const String showPostReportScreen = '/show_post_report_screen';

  static const String doctorListScreen = '/doctor_list_screen';

  static const String verifyDoctorScreen = '/verify_doctor_screen';

  static const String messageAdminPage = '/message_admin_page';

  static const String messageAdminTabContainerScreen =
      '/message_admin_tab_container_screen';

  static const String dietMedicineScreen = '/diet_medicine_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    // othersProfileScreen: (context) => OthersProfileScreen(),
    // mainProfileScreen: (context) => MainProfileScreen(),
    // editProfileScreen: (context) => EditProfileScreen(),
    // userProfileScreen: (context) => UserProfileScreen(),
    registerScreen: (context) => RegisterScreen(),
    registerPatientScreen: (context) => RegisterPatientScreen(),
    loginScreen: (context) => LoginScreen(),

    // plannerScreen: (context) => PlannerScreen(),
    // addDietScreen: (context) => AddDietScreen(),
    // showPlannerScreen: (context) => ShowPlannerScreen(),
    // medicineContainerScreen: (context) => MedicineContainerScreen(),
    // medicineEditScreen: (context) => MedicineEditScreen(),
    forumScreen: (context) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final email = arguments['email'];
      final password = arguments['password'];
      return ForumScreen(email: email, password: password);
    },
    // postScreen: (context) => PostScreen(),
    // notificationsScreen: (context) => NotificationsScreen(),
    // ownPostScreen: (context) => OwnPostScreen(),
    // editSugarLevelScreen: (context) => EditSugarLevelScreen(),
    // trackerHomeScreen: (context) => TrackerHomeScreen(),
    // sugarTrackerScreen: (context) => SugarTrackerScreen(),
    // bloodPressureShowAllScreen: (context) => BloodPressureShowAllScreen(),
    // bloodPressureEditScreen: (context) => BloodPressureEditScreen(),
    // selectionScreen: (context) => SelectionScreen(),
    // doctorHospitalTabContainerScreen: (context) =>
    //     DoctorHospitalTabContainerScreen(),
    // aboutDoctorScreen: (context) => AboutDoctorScreen(),
    // newScreen: (context) => NewScreen(),
    // groupsTabContainerScreen: (context) => GroupsTabContainerScreen(),
    // newGroupOneScreen: (context) => NewGroupOneScreen(),
    // msgScreen: (context) => MsgScreen(),
    // messegewithpeersTabContainerScreen: (context) =>
    //     MessegewithpeersTabContainerScreen(),
    expertRegisterScreen: (context) => ExpertRegisterScreen(),
    expertRegistertwoScreen: (context) => ExpertRegistertwoScreen(),
    // doctorProfileScreen: (context) => DoctorProfileScreen(),
    // doctorEditProfileScreen: (context) => DoctorEditProfileScreen(),
    // doctorEditProfileTwoScreen: (context) => DoctorEditProfileTwoScreen(),
    // doctorForumScreen: (context) => DoctorForumScreen(),

    showPostScreen: (context) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      if (arguments != null && arguments.containsKey('post')) {
        return ShowPostScreen(post: arguments['post']);
      } else {
        // Handle the case when 'post' is not present in the arguments
        return Scaffold(
          body: Center(
            child: Text('Invalid arguments for ShowPostScreen'),
          ),
        );
      }
    }

    // adminForumScreen: (context) => AdminForumScreen(),
    // postReportScreen: (context) => PostReportScreen(),
    // showPostReportScreen: (context) => ShowPostReportScreen(),
    // doctorListScreen: (context) => DoctorListScreen(),
    // verifyDoctorScreen: (context) => VerifyDoctorScreen(),
    // messageAdminTabContainerScreen: (context) =>
    //     MessageAdminTabContainerScreen(),
    // dietMedicineScreen: (context) => DietMedicineScreen(),
    // appNavigationScreen: (context) => AppNavigationScreen()
  };
}
