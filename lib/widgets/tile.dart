import 'package:flutter/material.dart';

class TileCard extends StatelessWidget {
  final int totalCalories;

  const TileCard({
    super.key,
    required this.totalCalories,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 320,
          height: 50,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 167, 240, 238)),
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xffECFBF0),
          ),
          child: Center(
            child: Text(
              'Total Calories: $totalCalories',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 0, 1, 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
