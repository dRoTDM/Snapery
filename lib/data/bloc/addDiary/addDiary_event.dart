import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddDiaryEvent extends Equatable {}

class AddFoodDiaryButtonSelected extends AddDiaryEvent {
  final CollectionReference foodDiary;
  final String username;
  final String name;
  final String calories;
  final String carbohydrate;
  final String protein;
  final String fat;

  AddFoodDiaryButtonSelected({
    @required this.foodDiary,
    @required this.username,
    @required this.name,
    @required this.calories,
    @required this.carbohydrate,
    @required this.protein,
    @required this.fat,
  });

  @override
  List<Object> get props =>
      [foodDiary, username, name, calories, carbohydrate, protein, fat];
}
