import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodsnap/pages/result_page.dart';
import 'package:http/http.dart' as http;

class NutritionPage extends StatefulWidget {
  final File imageFile;

  const NutritionPage({super.key, required this.imageFile});

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  bool isLoading = false; // Add this line

  String predictionResult = '';
  String nutritionValues = ''; // Declare the variable here
  String diabeticRecommendations = ''; // Declare the variable here

  Future<void> predictFoodCategory(File image) async {
    final url = Uri.parse(
        'http://192.168.3.153:8000/predictresult'); // Replace with your FastAPI endpoint
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseJson = await http.Response.fromStream(response);

      Map<String, dynamic> parsedData = json.decode(responseJson.body);

      setState(() {
        predictionResult = parsedData['class'];

        nutritionValues = "Product Name: ${parsedData['product_name']}\n"
            "Energy: ${parsedData['energy']} kJ\n"
            "Carbohydrates: ${parsedData['carbohydrates']} g\n"
            "Sugars: ${parsedData['sugars']} g\n"
            "Proteins: ${parsedData['proteins']} g\n"
            "Fat: ${parsedData['fat']} g\n"
            "Fiber: ${parsedData['fiber']} g\n"
            "Cholesterol: ${parsedData['cholesterol']} mg\n";

        diabeticRecommendations =
            "Recommendation Level: ${parsedData['recommendation']['label']}\n"
            "Reason: ${parsedData['recommendation']['reason']}\n"
            "Explanation: ${parsedData['recommendation']['explanation']}\n"
            "Suggestions: ${parsedData['recommendation']['suggestion']}\n";
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            predictionResult: predictionResult,
            nutritionValues: nutritionValues,
            diabeticRecommendations: diabeticRecommendations,
          ),
        ),
      );
    } else {
      print('Failed to predict food category');
    }
  }

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
            Image.file(widget.imageFile, width: 300, height: 300),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await predictFoodCategory(widget.imageFile);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      predictionResult:
                          predictionResult, // Fetched prediction result
                      nutritionValues:
                          nutritionValues, // Constructed nutrition values string
                      diabeticRecommendations:
                          diabeticRecommendations, // Constructed diabetic recommendations string
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff58B773),
              ),
              child: const Text('Perform Prediction'),
            ),
            const SizedBox(height: 20),
            if (predictionResult.isNotEmpty)
              Text('Prediction Result: $predictionResult'),
          ],
        ),
      ),
    );
  }
}
