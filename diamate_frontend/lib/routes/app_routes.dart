//github::::::::::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

import 'package:diamate_frontend/presentation/forum_screen/forum_screen.dart';
import 'package:diamate_frontend/views/home.dart';
import 'package:flutter/material.dart';

import 'package:diamate_frontend/services/auth/auth_view.dart';
import 'package:diamate_frontend/services/auth/auth_gate.dart';
// import 'package:diamate_frontend/presentation/all_tracker_screen/pressure_tracker_screen.dart';
// import 'package:diamate_frontend/presentation/show_planner_screen/show_planner_screen.dart';
// import 'package:diamate_frontend/presentation/tracker_home_screen/tracker_home_screen.dart';
import 'package:diamate_frontend/views/profile/edit_profile_screen.dart';
import 'package:diamate_frontend/views/profile/main_profile_screen.dart';

class AppRoutes {
  static const String authGate = '/auth_gate';
  static const String authView = '/auth_view';
  static const String homeScreen = '/home_screen';

  static const String othersProfileScreen = '/others_profile_screen';

  static const String mainProfileScreen = '/main_profile_screen';

  static const String editProfileScreen = '/edit_profile_screen';

  static const String userProfileScreen = '/user_profile_screen';

  static const String registerScreen = '/register_screen';

  static const String registerPatientScreen = '/register_patient_screen';

  static const String loginScreen = '/login';

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
    authGate: (context) => const AuthGate(),
    authView: (context) => const AuthView(),
    forumScreen: (context) => ForumScreen(),
    homeScreen: (context) => HomeScreen(),
    // editProfileScreen: (context) => EditProfileScreen(),
    editProfileScreen: (context) => EditProfileScreen(),
    mainProfileScreen: (context) => MainProfileScreen(),
    // registerScreen: (context) => RegisterScreen(),
    // registerPatientScreen: (context) => RegisterPatientScreen(),
    // loginScreen: (context) => const LoginScreen(),
    // forumScreen: (context) {
    //   final arguments =
    //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //   final email = arguments['email'];
    //   final password = arguments['password'];
    //   return ForumScreen(email: email, password: password);
    // },
    // expertRegisterScreen: (context) => ExpertRegisterScreen(),
    // expertRegistertwoScreen: (context) => ExpertRegistertwoScreen(),
    // showPostScreen: (context) {
    //   final arguments =
    //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // if (arguments != null && arguments.containsKey('post')) {
    //   return ShowPostScreen(post: arguments['post']);
    // } else {
    //   // Handle the case when 'post' is not present in the arguments
    //   return const Scaffold(
    //     body: Center(
    //       child: Text('Invalid arguments for ShowPostScreen'),
    //     ),
    //   );
    //   }
    // }
  };
}
