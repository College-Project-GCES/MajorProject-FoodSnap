import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Details {
  @HiveField(0)
  String image;
  @HiveField(1)
  String productname;
  @HiveField(2)
  String percentage;

  Details({
    required this.image,
    this.productname = 'ok',
    this.percentage = 'ok',
  });
}

@HiveType(typeId: 1)
class NutritionData extends HiveObject {
  @HiveField(0)
  final String productName;

  @HiveField(1)
  final double energy100g;

  @HiveField(2)
  final double carbohydrates100g;

  @HiveField(3)
  final double sugars100g;

  @HiveField(4)
  final double proteins100g;

  @HiveField(5)
  final double fat100g;

  @HiveField(6)
  final double fiber100g;

  @HiveField(7)
  final double cholesterol100g;

  NutritionData({
    required this.productName,
    required this.energy100g,
    required this.carbohydrates100g,
    required this.sugars100g,
    required this.proteins100g,
    required this.fat100g,
    required this.fiber100g,
    required this.cholesterol100g,
  });
}

@HiveType(typeId: 2)
class DiabetesRecommendation extends HiveObject {
  @HiveField(0)
  final String label;

  @HiveField(1)
  final String reason;

  @HiveField(2)
  final String explanation;

  @HiveField(3)
  final String suggestion;

  DiabetesRecommendation({
    required this.label,
    required this.reason,
    required this.explanation,
    required this.suggestion,
  });
}
