import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'core/app_export.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:diamate_frontend/config.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  // await dotenv.dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'diamate',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
