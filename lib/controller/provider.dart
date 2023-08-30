import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note.dart'; // Import your Hive models here

class ProviderApp with ChangeNotifier {
  Future<void> addImage(Details details) async {
    var box = await Hive.openBox<Details>('details');
    box.add(details);
    notifyListeners();
  }

  Future<Details> showImage() async {
    var box = await Hive.openBox<Details>('details');
    var image = box.getAt(box.length - 1);
    return image!;
  }

  Future<void> updateImage(Details details) async {
    var box = await Hive.openBox<Details>('details');
    box.putAt(box.length - 1, details);
    notifyListeners();
  }

  // Functions related to NutritionData
  Future<void> addNutrition(NutritionData nutritionData) async {
    var nutritionBox = await Hive.openBox<NutritionData>('nutritionData');
    nutritionBox.add(nutritionData);
    notifyListeners();
  }

  Future<List<NutritionData>> getAllNutritionData() async {
    var nutritionBox = await Hive.openBox<NutritionData>('nutritionData');
    return nutritionBox.values.toList();
  }

  // Functions related to DiabetesRecommendation
  Future<void> addDiabetesRecommendation(
      DiabetesRecommendation recommendation) async {
    var recommendationBox =
        await Hive.openBox<DiabetesRecommendation>('diabetesRecommendation');
    recommendationBox.add(recommendation);
    notifyListeners();
  }

  Future<List<DiabetesRecommendation>> getAllDiabetesRecommendations() async {
    var recommendationBox =
        await Hive.openBox<DiabetesRecommendation>('diabetesRecommendation');
    return recommendationBox.values.toList();
  }
}
