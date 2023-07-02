import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/components/my_textfield.dart';
import 'package:foodsnap/components/square_tile.dart';
import 'package:foodsnap/pages/login_page.dart';
import 'package:foodsnap/pages/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controllers
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;

  Utils utils = Utils();
  // text editing controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                hintText: 'Email address',
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
              // username textfield
              const SizedBox(height: 10),

              MyTextField(
                controller: usernameController,
                hintText: 'Full Name',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Username is required');
                  } else {
                    return (null);
                  }
                },
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value != null && value.length < 7) {
                      return 'Enter minimum 7 characters';
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 10),

              MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value != null && value.length < 7) {
                      return 'Enter minimum 7 characters';
                    } else {
                      return null;
                    }
                  }),

              const SizedBox(height: 10),

              // sign in button
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());

                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  print(userId);
                  print(FirebaseAuth.instance.currentUser?.email);

                  final docUser =
                      FirebaseFirestore.instance.collection('users');

                  final user = User(
                      username: usernameController.text,
                      userEmailAddress: emailController.text);

                  final json = user.toJson();

                  await docUser.doc(userId).set(json);

                  if (_formKey.currentState!.validate()) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, 'login');
                  }
                },
                child: const MyButton(
                  text: "Sign Up",
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
              TextButton(
                onPressed: _isLoading ? null : _signInWithGoogle,
                child: const SquareTile(
                  imagePath: 'assets/images/google.png',
                  text: "Log In with Google",
                ),
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
                            builder: (context) => const LoginPage(),
                          ));
                    },
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}

class User {
  final String id;
  final String username;
  final String userEmailAddress;

  User({
    this.id = '',
    required this.username,
    required this.userEmailAddress,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': username,
        'email': userEmailAddress,
      };

  static User fromJson(Map<String, dynamic> Function() json) => User(
        username: 'name',
        userEmailAddress: 'email',
      );
}
