import 'package:flutter/material.dart';
import 'package:foodsnap/pages/login_page.dart';
import 'package:foodsnap/pages/signup_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignup = false;
  callback() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: isSignup ? const SignUpPage() : const LoginPage(),
        ),
      ),
    );
  }
}
