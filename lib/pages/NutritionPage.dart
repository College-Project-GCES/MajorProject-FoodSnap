import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NutritionPage extends StatefulWidget {
  final File imageFile;

  const NutritionPage({Key? key, required this.imageFile}) : super(key: key);

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  bool isLoading = false;
  Map<String, dynamic>? predictionData;

  Future<void> predictFoodCategory(File image) async {
    final url = Uri.parse('http://192.168.1.83:8000/predictresult');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedData = json.decode(responseBody);
      print('API Response: $responseBody');
      setState(() {
        predictionData = parsedData;
      });
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
                setState(() {
                  isLoading = true;
                });

                await predictFoodCategory(widget.imageFile);

                setState(() {
                  isLoading = false;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff58B773),
              ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Perform Prediction'),
            ),
            const SizedBox(height: 20),
            if (predictionData != null)
              Expanded(
                child: ListView(
                  children: [
                    Text('Prediction Result: ${predictionData!["class"]}'),
                    Text('Confidence: ${predictionData!["confidence"]}'),
                    if (predictionData!["nutrition_diabetic_info"] != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: parseNutritionData(
                          predictionData!["nutrition_diabetic_info"],
                        ).map((field) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(field),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<String> parseNutritionData(String nutritionData) {
    List<String> lines = nutritionData.split('\n');
    return lines.where((line) => line.isNotEmpty).toList();
  }
}
