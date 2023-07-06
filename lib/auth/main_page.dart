import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/auth/verify_email_page.dart';
import 'package:foodsnap/pages/home_page.dart';
import '../auth/auth_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator if the authentication state is still being checked
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user != null && user.emailVerified) {
              // User is logged in and email is verified, navigate to HomePage
              return const HomePage();
            } else {
              // User is logged in but email is not verified, navigate to VerifyEmailPage
              return const VerifyEmailPage();
            }
          } else {
            // User is not logged in, navigate to AuthScreen
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
