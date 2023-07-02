import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/pages/login_page.dart';
import 'package:foodsnap/pages/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Utils utils = Utils();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      /// Showing Message That user enters email correctly and reset password will be sent
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password reset link sent! Check your Email"),
      ));

      /// After 2 seconds we automatically pop forgot screen
      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));

      ///
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);

      /// Showing Error with SnackBar if the user enter the wrong Email or Enter nothing
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Column(children: [
          const SizedBox(height: 150),
          const Text(
            'Forgot Passwrord',
            style: TextStyle(
              color: Color(0xff2DB040),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 325,
            child: Container(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text:
                                'Enter your Email and we will send you a Password Reset Link',
                            style: TextStyle(
                              color: Color.fromARGB(255, 28, 56, 36),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 147, 219, 167),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 147, 219, 167)),
                            ),
                            hintText: 'Email address',
                          ),
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
                        const SizedBox(
                          height: 30,
                        ),
                        TextButton(
                            onPressed: resetPassword,
                            child: const MyButton(
                              text: "RESET",
                            ))
                      ],
                    )),
              ),
            ),
          )
        ])));
  }
}
