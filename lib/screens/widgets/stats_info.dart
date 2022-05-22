import 'package:flutter/material.dart';

class StatsInfo extends StatelessWidget {
  final String name;
  final String totalCalories;
  final String carbohydrate;
  final String protein;
  final String fat;

  const StatsInfo({
    Key key,
    @required this.name,
    @required this.totalCalories,
    @required this.carbohydrate,
    @required this.protein,
    @required this.fat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StatInfoTile(
          stat: "Name",
          amount: name,
        ),
        _StatInfoTile(
          stat: "Calories",
          amount: totalCalories,
        ),
        _StatInfoTile(
          stat: "Carbohydrate",
          amount: carbohydrate,
        ),
        _StatInfoTile(
          stat: "Protein",
          amount: protein,
        ),
        _StatInfoTile(
          stat: "Fat",
          amount: fat,
        ),
      ],
    );
  }
}

class _StatInfoTile extends StatelessWidget {
  final String stat;
  final String amount;
  const _StatInfoTile({
    Key key,
    @required this.stat,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          stat,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        Text(
          "  :",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          amount,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
