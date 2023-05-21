import 'package:flutter/material.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/components/my_textfield.dart';
import 'package:foodsnap/components/square_tile.dart';
import 'package:foodsnap/pages/login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

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
                'Sign Up',
                style: TextStyle(
                  color: Color(0xff2DB040),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                'Please enter your credentials ',
                style: TextStyle(
                  color: Color(0xff888181),
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 15),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              // username textfield
              const SizedBox(height: 10),

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

              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // sign in button
              MyButton(
                text: "Sign Up",
                onTap: signUpUser,
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
                  SquareTile(
                    imagePath: 'assets/images/google.png',
                    text: 'SignUp with Google',
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Already a  member? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member?  "),
                  GestureDetector(
                    child: const Text(
                      "Login",
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
                            builder: (context) => LoginPage(),
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
