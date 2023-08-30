import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:foodsnap/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NutritionPage extends StatefulWidget {
  final String predictedFood;

  const NutritionPage({required this.predictedFood, Key? key})
      : super(key: key);

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  String diabeticRecommendation = '';

  Future<void> fetchNutritionData() async {
    final url = Uri.parse('http://192.168.18.12:8000/predict');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final diabeticRecommendationJson = jsonData['diabetic_recommendation'];

      final Box<NutritionData> nutritionDataBox =
          Hive.box<NutritionData>('nutritionData');
      final Box<DiabetesRecommendation> diabetesRecommendationBox =
          Hive.box<DiabetesRecommendation>('diabetesRecommendation');

      diabetesRecommendationBox.put(
          'diabetic_recommendation',
          DiabetesRecommendation(
            label: diabeticRecommendationJson['label'],
            reason: diabeticRecommendationJson['reason'],
            explanation: diabeticRecommendationJson['explanation'],
            suggestion: diabeticRecommendationJson['suggestion'],
          ));

      setState(() {
        diabeticRecommendation = diabetesRecommendationBox
                .get('diabetic_recommendation')
                ?.explanation ??
            '';
      });
    } else {
      print('Failed to fetch nutrition data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNutritionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Page - ${widget.predictedFood}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Diabetic Recommendation:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(diabeticRecommendation),
          ],
        ),
      ),
    );
  }
}
