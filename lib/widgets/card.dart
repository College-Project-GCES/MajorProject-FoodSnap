import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String image;
  final String text;
  final String totalCalorie;

  const CustomCard({
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
          Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            totalCalorie,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
