import 'dart:convert';

import 'package:diamate_frontend/config.dart';
import 'package:diamate_frontend/views/profile/patient_complete_profile.dart';
import 'package:diamate_frontend/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

class RoleGate extends StatefulWidget {
  const RoleGate({super.key});

  @override
  State<RoleGate> createState() => _RoleGateState();
}

class _RoleGateState extends State<RoleGate> {
  int role = -1;
  bool accountComplete = false;

  @override
  void initState() {
    super.initState();
    Requests.get(url_profileStatus).then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        setState(() {
          accountComplete = responseBody['isComplete'];
          role = responseBody['role'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case 0:
        return _buildRoleView('Admin Page');
      case 1:
        if (accountComplete) {
          return _buildRoleView('Patient Page');
        } else {
          return PatientCompleteProfile();
        }
      case 2:
        if (accountComplete) {
          return _buildRoleView('Expert Page');
        } else {
          return _buildRoleView('Expert Complete Profile Page');
        }
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  Widget _buildRoleView(String text) {
    return SafeArea(
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(text),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: CustomElevatedButton(
              text: "Log Out",
              onPressed: () {
                logOut();
              }),
        )
      ])),
    );
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
