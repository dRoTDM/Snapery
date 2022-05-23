import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../widgets/stats_info.dart';

class FoodDiary extends StatelessWidget {
  final String username;

  const FoodDiary({
    Key key,
    @required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference foodDiary =
        FirebaseFirestore.instance.collection('foodDiary');
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text("Food Diary", style: fieldBMIHeader),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: foodDiary.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CircularProgressIndicator(),
                ],
              );

            return ListView(
              children: snapshot.data.docs.map((diary) {
                final DateTime date = diary['date'].toDate();
                final String year = DateFormat.y().format(date);
                final String month = DateFormat.MMMM().format(date);
                final String day = DateFormat.d().format(date);

                return Center(
                  child: ListTile(
                    title: username == diary['username']
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("Recorded Food for $year, $month $day:",
                                  style: fieldBMIHeader),
                              SizedBox(
                                height: 20,
                              ),
                              StatsInfo(
                                name: diary['name'],
                                carbohydrate: diary['carbohydrate'],
                                fat: diary['fat'],
                                protein: diary['protein'],
                                totalCalories: diary['calories'],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
