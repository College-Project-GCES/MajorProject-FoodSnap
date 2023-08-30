import 'dart:html';
import 'dart:convert' show json;
import 'package:foodsnap/predict.dart';

List<FoodPredictionModel> FoodPredictionModelFromJson(String str) =>
    List<FoodPredictionModel>.from(json.decode(str).map((x) => FoodPredictionModel.fromJson(x)));

String FoodPredictionToJson(List< FoodPredictionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodPredictionModel {
  late String foodName;
  late double confidence;
  late String imageData;
  late String prediction;

  FoodPredictionModel({
    required this.foodName,
    required this.confidence,
    required this.imageData,
    required this.prediction,
  });
   factory FoodPredictionModel.fromJson(Map<String, dynamic> json) => FoodPredictionModel(

        foodName:json["name"],
        confidence:json["name"],
        imageData:json["name"],
        prediction:json["name"],
        
      );
      
  Map<String, dynamic> toJson() => {
       "foodName":foodName,
        "confidence":confidence,
        "imageData":imageData,
        "prediction":prediction,
      };

  void toggleInfo() {
    var infoDiv = querySelector('#info-${foodName}');
    var button = querySelector('#more-info-button-${foodName}');
    if (infoDiv?.style.display == 'none') {
      infoDiv?.style.display = 'block';
      button?.text = 'Less Info';
    } else {
      infoDiv?.style.display = 'none';
      button?.text = 'More Info';
    }
  }
}


