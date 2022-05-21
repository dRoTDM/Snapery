import 'package:flutter/material.dart';

class RecommendedFoodModel {
  String dietType;
  String breakfast;
  String lunch;
  String snack;
  String dinner;
  String totalCalorie;

  RecommendedFoodModel({
    @required this.dietType,
    @required this.breakfast,
    @required this.lunch,
    @required this.snack,
    @required this.dinner,
    @required this.totalCalorie,
  });

  factory RecommendedFoodModel.fromJson(Map<String, dynamic> json) {
    return RecommendedFoodModel(
      dietType: json["dietType"] as String,
      breakfast: json["breakfast"] as String,
      lunch: json["lunch"] as String,
      snack: json["snack"] as String,
      dinner: json["dinner"] as String,
      totalCalorie: json["totalCalorie"] as String,
    );
  }
}
