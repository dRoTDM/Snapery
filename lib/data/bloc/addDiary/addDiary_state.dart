import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AddDiaryState extends Equatable {}

class AddToFoodDiaryInitial extends AddDiaryState {
  @override
  List<Object> get props => [];
}

class AddToFoodDiaryState extends AddDiaryState {
  final String username;
  final String name;
  final String calories;
  final String carbohydrate;
  final String protein;
  final String fat;

  AddToFoodDiaryState({
    @required this.username,
    @required this.name,
    @required this.calories,
    @required this.carbohydrate,
    @required this.protein,
    @required this.fat,
  });

  @override
  List<Object> get props =>
      [username, name, calories, carbohydrate, protein, fat];
}

class AddToFoodDiarySuccessState extends AddDiaryState {
  final String successMsg;

  AddToFoodDiarySuccessState({@required this.successMsg});

  @override
  List<Object> get props => [successMsg];
}

class AddToFoodDiaryFailState extends AddDiaryState {
  final String errorMsg;

  AddToFoodDiaryFailState({
    @required this.errorMsg,
  });
  @override
  List<Object> get props => [errorMsg];
}
