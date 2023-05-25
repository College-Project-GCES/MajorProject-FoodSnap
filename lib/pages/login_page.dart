import 'package:flutter/material.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/components/my_textfield.dart';
import 'package:foodsnap/components/square_tile.dart';
import 'package:foodsnap/pages/FoodlistPage.dart';
import 'package:foodsnap/pages/signup_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  "assets/images/FoodSnapLogo.png",
                  height: 80,
                  width: 80,
                ),
              ),
              const Text(
                'Log In',
                style: TextStyle(
                  color: Color(0xff2DB040),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                'Enter your credentials to continue.',
                style: TextStyle(
                  color: Color(0xff888181),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                text: "Log In",
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodlistPage(),
                      ));
                },
              ),

              const SizedBox(height: 15),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // google sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'assets/images/google.png'),
                ],
              ),

              const SizedBox(height: 15),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  GestureDetector(
                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                        color: Color(0xff2DB040),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Write Tap Code Here.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
