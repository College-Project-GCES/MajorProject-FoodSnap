import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String predictionResult;
  final String nutritionValues;
  final String diabeticRecommendations;

  const ResultPage({
    Key? key,
    required this.predictionResult,
    required this.nutritionValues,
    required this.diabeticRecommendations,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Result'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prediction: ${widget.predictionResult}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nutrition Values:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.nutritionValues),
            const SizedBox(height: 10),
            const Text(
              'Diabetic Recommendations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.diabeticRecommendations),
          ],
        ),
      ),
    );
  }
}
