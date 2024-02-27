import "package:diamate_frontend/config.dart";
import "package:diamate_frontend/presentation/forum_screen/forum_screen.dart";
import "package:diamate_frontend/services/auth/auth_view.dart";
import "package:diamate_frontend/services/role_gate.dart";
import "package:diamate_frontend/views/home.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:requests/requests.dart";

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool cookieLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            if (cookieLoaded == false) {
              setCookie();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const RoleGate();
          }
          return const AuthView();
        },
      ),
    );
  }

  void setCookie() {
    User user = FirebaseAuth.instance.currentUser!;
    user.getIdToken(true).then((token) {
      if (token != null) {
        print("token: $token");
        Requests.addCookie(Requests.getHostname(baseUrl), "token", token);
        setState(() {
          cookieLoaded = true;
        });
      }
    });
  }
}
