import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/components/my_textfield.dart';
import 'package:foodsnap/components/square_tile.dart';
import 'package:foodsnap/pages/forgot_password.dart';
import 'package:foodsnap/pages/signup_page.dart';
import 'package:foodsnap/pages/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Utils utils = Utils();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                validator: (value) {
                  // Check if this field is empty
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }

                  // using regular expression
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }

                  // the email is valid
                  return null;
                },
              ),

              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value != null && value.length < 7) {
                    return 'Enter minimum 7 characters';
                  } else {
                    return null;
                  }
                },
                obscureText: true,
              ),
              // password textfield

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      onTap: () {
                        // Write Tap Code Here.
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ));
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                  } on FirebaseAuthException catch (e) {
                    print(e);
                    // Utils.showSnackBar(e.message);
                    utils.showSnackBar('Try with new email address');
                  }
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, 'bottom_nav');
                  } else {
                    print('It is not working');
                  }
                },
                child: const MyButton(
                  text: "Log In",
                ),
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
                            builder: (context) => const SignUpPage(),
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
