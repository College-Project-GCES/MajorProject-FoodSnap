import 'dart:io';

import 'package:flutter/material.dart';

class NutritionPage extends StatelessWidget {
  final File? image;
  final String predictedFood;

  const NutritionPage(
      {required this.image, required this.predictedFood, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Nutrition Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Image.file(image!),
                ),
              const SizedBox(height: 16.0),
              Text(
                'Predicted Food: $predictedFood',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Detailed Nutrition',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                },
                children: const [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Carbohydrate'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Fat'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text('Protein'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Diabetic Recommend',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const LinearProgressIndicator(
                value: 0.75, // Replace with the actual value
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.red,
              ),
              const SizedBox(height: 16.0),
              const Text('Explanation:'),
              const SizedBox(height: 16.0),
              const Text('Suggestion:'),
            ],
          ),
        ),
      ),
    );
  }
}
