import 'package:flutter/material.dart';
import 'package:foodsnap/pages/home_page.dart';
import 'package:foodsnap/pages/signup_page.dart';

import '../components/square_tile.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/foodsnaplogo1.png',
              width: 200.0,
              height: 200.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // google button
                TextButton(
                  onPressed: () {
                    // Write Tap Code Here.
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(
                            username: 'Hari',
                          ),
                        ));
                  },
                  child: const SquareTile(
                    imagePath: 'assets/images/google.png',
                    text: 'SignUp with Google',
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const SignUpPage(),
                    //     ));
                  },
                  child: const SquareTile(
                    imagePath: 'assets/images/Gmaillogo.png',
                    text: 'SignUp with Email',
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "By signing up I accept the terms of \n use and data privacy policy",
                  style: TextStyle(
                    color: Color(0xff2A9A3B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?  "),
                    GestureDetector(
                      child: const Text(
                        "Login Here",
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
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
