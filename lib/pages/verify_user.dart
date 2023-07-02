import 'package:flutter/material.dart';
import '../components/my_button.dart';

class VerifiedUser extends StatefulWidget {
  const VerifiedUser({super.key});

  @override
  State<VerifiedUser> createState() => _VerifiedUserState();
}

class _VerifiedUserState extends State<VerifiedUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 400,
            ),
            const Text(
              'Congratulations!! You have been our verified user',
              style: TextStyle(
                color: Color(0xff2DB040),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.verified_user),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () => {Navigator.pushNamed(context, 'login')},
              child: const MyButton(
                text: "Log In",
              ),
            )
          ],
        ),
      ),
    );
  }
}
