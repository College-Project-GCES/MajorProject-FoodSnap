import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff66BAB7)),
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xffECFBF0),
      ),
      child: Row(
        crossAxisAlignment : CrossAxisAlignment.start,
          children : [
            Image.asset(
              imagePath,
            height: 30,
            ),
            const SizedBox(width: 30),
            const Center(
              child: Text(
              "SignUp with Google",
              style: TextStyle(
                color: Color(0xff2DB040),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
        ),
          ]
        )
     
    );
  }
}
