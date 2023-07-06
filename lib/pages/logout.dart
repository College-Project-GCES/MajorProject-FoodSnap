import 'package:foodsnap/auth/main_page.dart';
import 'package:foodsnap/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Card(
          child: Column(children: [
            const SizedBox(
              height: 180,
            ),
            const Text(
              "Are you sure to exit?",
              style: TextStyle(
                color: Color(0xff2DB040),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  height: 40,
                  width: 80,
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'home');
                    },
                    child: const Text('Cancel')),
                const SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      // Navigator.pushAndRemoveUntil(context, 'login');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MainScreen()),
                          ModalRoute.withName('/'));
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    )),
              ],
            )
          ]),
        ),
      ),
    ));
  }
}