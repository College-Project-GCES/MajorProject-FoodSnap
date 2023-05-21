import 'package:flutter/material.dart';
import 'package:foodsnap/pages/signup_page.dart';

import '../components/square_tile.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required String title}) : super(key: key);

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
                  onPressed: () {},
                  child: const SquareTile(
                    imagePath: 'assets/images/google.png',
                    text: 'SignUp with Google',
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                  },
                  child: const SquareTile(
                    imagePath: 'assets/images/Gmaillogo.png',
                    text: 'SignUp with Email',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
