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
    final url = Uri.parse('http://192.168.1.85:8000/predictresult');
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
        backgroundColor: Color(0xFF2DB040), // Set the app bar color
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/FoodSnapLogo.png',
              height: 50,
              width: 50,
            ),
            Text(
              'Nutrition of Food',
              style: TextStyle(
                color: Colors.white, // Set text color
                fontSize: 18, // Increase font size
                fontWeight: FontWeight.bold, // Add bold font weight
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 4, // Add elevation/shadow to the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Set container background color
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Add shadow to the container
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.file(
                  widget.imageFile,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
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
                primary: Color(0xFF2DB040), // Set button color
                onPrimary: Colors.white, // Set text color
                elevation: 4, // Add elevation to the button
              ),
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Perform Prediction',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(height: 20),
            if (predictionData != null)
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'Prediction Result: ${predictionData!["class"]}',
                      style: TextStyle(
                        color: Color(0xFFE65100), // Set text color
                        fontSize: 20, // Increase font size
                        fontWeight: FontWeight.bold, // Add bold font weight
                      ),
                    ),
                    Text(
                      'Confidence: ${predictionData!["confidence"]}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    if (predictionData!["nutrition_diabetic_info"] != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: parseNutritionData(
                          predictionData!["nutrition_diabetic_info"],
                        ).map((field) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              field,
                              style: TextStyle(
                                color: Colors.teal, // Set text color
                                fontSize: 14, // Adjust font size
                              ),
                            ),
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
