import 'package:flutter/material.dart';

class NoRecommendationData extends StatelessWidget {
  final String emptyMsg;
  const NoRecommendationData({
    Key key,
    @required this.emptyMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.20),
            Icon(
              Icons.no_backpack,
              color: Colors.white60,
              size: 200,
            ),
            SizedBox(height: 30),
            Text(
              emptyMsg,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
