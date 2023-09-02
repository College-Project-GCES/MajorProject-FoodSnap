// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailsAdapter extends TypeAdapter<Details> {
  @override
  final int typeId = 0;

  @override
  Details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Details(
      image: fields[0] as String,
      productname: fields[1] as String,
      percentage: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Details obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.productname)
      ..writeByte(2)
      ..write(obj.percentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NutritionDataAdapter extends TypeAdapter<NutritionData> {
  @override
  final int typeId = 1;

  @override
  NutritionData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionData(
      productName: fields[0] as String,
      energy100g: fields[1] as double,
      carbohydrates100g: fields[2] as double,
      sugars100g: fields[3] as double,
      proteins100g: fields[4] as double,
      fat100g: fields[5] as double,
      fiber100g: fields[6] as double,
      cholesterol100g: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.energy100g)
      ..writeByte(2)
      ..write(obj.carbohydrates100g)
      ..writeByte(3)
      ..write(obj.sugars100g)
      ..writeByte(4)
      ..write(obj.proteins100g)
      ..writeByte(5)
      ..write(obj.fat100g)
      ..writeByte(6)
      ..write(obj.fiber100g)
      ..writeByte(7)
      ..write(obj.cholesterol100g);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiabetesRecommendationAdapter
    extends TypeAdapter<DiabetesRecommendation> {
  @override
  final int typeId = 2;

  @override
  DiabetesRecommendation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiabetesRecommendation(
      label: fields[0] as String,
      reason: fields[1] as String,
      explanation: fields[2] as String,
      suggestion: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DiabetesRecommendation obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.reason)
      ..writeByte(2)
      ..write(obj.explanation)
      ..writeByte(3)
      ..write(obj.suggestion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiabetesRecommendationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
