import 'dart:io';

import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  final File imageFile;

  const NutritionPage({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Prediction'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(imageFile, width: 300, height: 300),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform your prediction logic here
              },
              child: const Text('Perform Prediction'),
            ),
          ],
        ),
      ),
    );
  }
}
