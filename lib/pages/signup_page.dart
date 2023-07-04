import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/components/my_textfield.dart';
import 'package:foodsnap/components/square_tile.dart';
import 'package:foodsnap/firebase_constants.dart';
import 'package:foodsnap/pages/login_page.dart';
import 'package:foodsnap/pages/utils.dart';
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

  static Future<User?> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('The password does not match the confirm password.')),
      );
      return null;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update user's display name
        User user = userCredential.user!;
        await user.updateDisplayName(name);

        return user;
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The account already exists for that email.')),
        );
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
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
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    User? signedUpUser = await signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      confirmPassword: confirmPasswordController.text,
                      context: context,
                    );

                    if (signedUpUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const VerifyEmailPage()),
                      );
                    }

                    setState(() {
                      _isLoading = false;
                    });
                  },
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
    );
  }
}
