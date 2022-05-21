import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BMICalculator extends StatelessWidget {
  final String username;
  const BMICalculator({Key key, @required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference bmi = FirebaseFirestore.instance.collection('bmi');
    double totalBMI = 0;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text("BMI Records", style: fieldBMIHeader),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: bmi.snapshots(),
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
              children: snapshot.data.docs.map((bmi) {
                final DateTime date = bmi['date'].toDate();
                final String year = DateFormat.y().format(date);
                final String month = DateFormat.MMMM().format(date);
                final String day = DateFormat.d().format(date);

                final double height = double.tryParse(bmi['height']);
                final double weight = double.tryParse(bmi['weight']) / 100;
                double calculatedBMI;
                if (username == bmi['username']) {
                  // TODO Subin: fix bmi formula
                  calculatedBMI = height / weight;
                  totalBMI = calculatedBMI;
                }

                return Center(
                  child: ListTile(
                    title: username == bmi['username']
                        ? Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("Recorded BMI for $year, $month $day:",
                                  style: fieldBMIHeader),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                calculatedBMI
                                    .toString(), //TODO Subin: roudnup calculated BMI
                                style: fieldTextStyle,
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 5,
            ),
            child: MaterialButton(
              onPressed: () =>
                  navigateToRecommendedFood(context: context, bmi: totalBMI),
              child: Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green,
                ),
                child: Center(
                    child: Text('Recommended Food', style: fieldTextStyle)),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () => navigateToBMIForm(
                context: context, bmi: bmi, username: username),
            backgroundColor: Colors.white,
            child: Icon(Icons.calculate, color: Colors.cyan, size: 35),
          ),
        ],
      ),
    );
  }
}
