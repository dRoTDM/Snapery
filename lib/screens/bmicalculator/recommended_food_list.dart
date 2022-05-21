import 'dart:convert';

import 'package:snapery/data/model/recommended_food_model.dart';
import 'package:snapery/screens/widgets/no_data_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

class RecommendedFood extends StatelessWidget {
  final double bmi;
  const RecommendedFood({Key key, @required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("This is $bmi");

    int foodIndex;
    if (bmi < 18.5 && bmi != 0) {
      foodIndex = 0;
    } else if (bmi > 18.5 && bmi < 24.9) {
      foodIndex = 1;
    } else if (bmi > 24.9) {
      foodIndex = 2;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: bmi == 0
          ? NoRecommendationData(
              emptyMsg:
                  "No Food Suggestion can be Listed. \n Please calculate your BMI First",
            )
          : Padding(
              padding: const EdgeInsets.only(left: 21.0, right: 22),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Food for you",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: readJsonData(),
                      builder: (context, data) {
                        if (data.hasError) {
                          return const Center(
                            child: Text('Error loading the json data'),
                          );
                        } else if (data.hasData) {
                          final items = data.data as List<RecommendedFoodModel>;
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.isEmpty ? 0 : 1,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: Column(
                                  children: <Widget>[
                                    ExpansionTile(
                                      title: Text(
                                        items[foodIndex].dietType.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            height: 1.5),
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            items[foodIndex]
                                                .breakfast
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            items[foodIndex].lunch.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            items[foodIndex].snack.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            items[foodIndex].dinner.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                height: 1.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            shrinkWrap: true,
                          );
                        } else {
                          return Container(
                            height: 50,
                            width: 50,
                            color: Colors.red,
                          );
                        }
                      }),
                ],
              ),
            ),
    );
  }

  static Future<List<RecommendedFoodModel>> readJsonData() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/recommended_food.json');

    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list
        .map((e) => RecommendedFoodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
