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
  bool isLoading = false;
  Map<String, dynamic>?
      predictionData; // Change the type to Map<String, dynamic>?

  Future<void> predictFoodCategory(File image) async {
    final url = Uri.parse('http://192.168.3.104:8000/predictresult');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedData = json.decode(responseBody);

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
              Column(
                children: [
                  Text('Prediction Result: ${predictionData!["class"]}'),
                  Text('Confidence: ${predictionData!["confidence"]}'),
                  Text('Confidence: ${predictionData!["confidence"]}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
