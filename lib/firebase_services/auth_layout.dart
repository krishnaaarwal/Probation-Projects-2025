import 'package:flutter/material.dart';
import 'package:quiz_app/AppScreens/homescreen.dart';
import 'package:quiz_app/AuthecationScreens/registerpage.dart';
import 'package:quiz_app/firebase_services/auth_services.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});
  final Widget? pageIfNotConnected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasData) {
              return const HomeScreen();
            }

            return const RegisterScreen();
          },
        );
      },
    );
  }
}
