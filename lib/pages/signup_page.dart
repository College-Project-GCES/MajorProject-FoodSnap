import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/components/my_textfield.dart';
import 'package:foodsnap/components/square_tile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foodsnap/auth/verify_email_page.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginScreen;

  const SignUpPage({Key? key, required this.showLoginScreen}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Color.fromARGB(255, 245, 61, 61),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Password =! ConfirmPassword
  var aSnackBar = const SnackBar(
    content: Text('The password in not match with confirm password'),
  );

  /// Password & ConfirmPassword is Empty
  var bSnackBar = const SnackBar(
    content: Text('The Password & Confirm Password fields must fill!'),
  );

  /// Confirm Password is Empty
  var cSnackBar = const SnackBar(
    content: Text('The Confirm Password field must fill!'),
  );

  /// Password is Empty
  var dSnackBar = const SnackBar(
    content: Text('The Password field must fill!'),
  );

  /// Email & Confirm Password is Empty
  var eSnackBar = const SnackBar(
    content: Text('The Email & Confirm Password fields must fill!'),
  );

  /// Email is Empty
  var fSnackBar = const SnackBar(
    content: Text('The Email field must fill!'),
  );

  /// Email & password is Empty
  var gSnackBar = const SnackBar(
    content: Text('The Email & Password fields must fill!'),
  );

  /// All Fields Empty
  var xSnackBar = const SnackBar(
    content: Text('You must fill all fields'),
  );
  bool _passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  Future<void> _signUp() async {
    if (emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (_passwordConfirmed()) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          if (userCredential.user != null) {
            // Send email verification
            await userCredential.user!.sendEmailVerification();

            // Navigate to VerifyEmailPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const VerifyEmailPage(),
              ),
            );
          }
        } catch (e) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error Happened'),
                content: const SingleChildScrollView(
                  child: Text(
                      "An error occurred during sign up. Please try again later."),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(aSnackBar);
      }
    } else if (emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isEmpty &&
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(bSnackBar);
    } else if (emailController.text.isNotEmpty &
        nameController.text.isNotEmpty &
        passwordController.text.isNotEmpty &
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(cSnackBar);
    }

    ///
    else if (emailController.text.isNotEmpty &
        nameController.text.isNotEmpty &
        passwordController.text.isEmpty &
        confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(dSnackBar);
    }

    ///
    else if (emailController.text.isEmpty &
        nameController.text.isNotEmpty &
        passwordController.text.isNotEmpty &
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(eSnackBar);
    }

    ///
    else if (emailController.text.isEmpty &
        nameController.text.isNotEmpty &
        passwordController.text.isNotEmpty &
        confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(fSnackBar);
    }

    ///
    else if (emailController.text.isEmpty &
        nameController.text.isNotEmpty &
        passwordController.text.isEmpty &
        confirmPasswordController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(gSnackBar);
    }

    ///
    else {
      ScaffoldMessenger.of(context).showSnackBar(xSnackBar);
    }
  }

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        child: SingleChildScrollView(
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
                  'Please enter your credentials',
                  style: TextStyle(
                    color: Color(0xff888181),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email address',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  hintText: 'Full Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
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
                TextButton(
                    onPressed: _signUp,
                    child: const MyButton(
                      text: "Sign Up",
                    )),
                const SizedBox(height: 15),
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
                TextButton(
                  onPressed: _isLoading ? null : _signInWithGoogle,
                  child: const SquareTile(
                    imagePath: 'assets/images/google.png',
                    text: "Log In with Google",
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member?  "),
                    GestureDetector(
                      onTap: widget.showLoginScreen,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xff2DB040),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
