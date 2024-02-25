import "package:diamate_frontend/config.dart";
import "package:diamate_frontend/services/auth/auth_view.dart";
import "package:diamate_frontend/views/home.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:requests/requests.dart";

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

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
            setCookie();
            return const HomeScreen();
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
        print("token: " + token);
        Requests.addCookie(Requests.getHostname(baseUrl), "token", token);
      }
    });
  }
}
