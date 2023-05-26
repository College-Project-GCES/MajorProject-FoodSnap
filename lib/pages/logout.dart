import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          child: Column(children: [
            const SizedBox(
              height: 180,
            ),
            const Text('Are you sure to exit?'),
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
                                  const LoginPage()),
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
