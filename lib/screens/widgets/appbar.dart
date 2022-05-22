import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;

  const AppBarTitle({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 17.0,
          height: 1.3),
    );
  }
}
