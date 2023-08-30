import 'package:flutter/material.dart';
import 'package:foodsnap/pages/login_page.dart';
import 'package:foodsnap/pages/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// SHOW THE LOGIN PAGE
  bool showLogInPage = false;

  /// TOGGLE BETWEEN LOGIN and SIGNUP SCREENS
  void toggleScreen() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return LoginPage(showSignUpScreen: toggleScreen);
    } else {
      return SignUpPage(showLoginScreen: toggleScreen);
    }
  }
}