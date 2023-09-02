import 'package:flutter/material.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/components/my_textfield.dart';
import 'package:foodsnap/components/square_tile.dart';
import 'package:foodsnap/pages/login_page.dart';

class FoodlistPage extends StatelessWidget {
  FoodlistPage({super.key});

  // text editing controllers

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user in method
  void signUpUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/FoodSnapLogo.png",
                height: 80,
                width: 80,
              ),
              const Text(
                'FoodList',
                style: TextStyle(
                  color: Color(0xff2DB040),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
