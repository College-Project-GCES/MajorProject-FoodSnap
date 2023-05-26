import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String image;
  final String text;
  final int totalCalorie;

  const CustomCard({
    super.key,
    required this.image,
    required this.text,
    required this.totalCalorie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            image,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              totalCalorie as String,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
