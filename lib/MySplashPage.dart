// ignore_for_file: prefer_const_constructors, unused_import, import_of_legacy_library_into_null_safe, file_names

import 'package:flutter/material.dart';
import 'package:snapery/homepage.dart';
import 'package:snapery/main.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashPage extends StatefulWidget {
  const MySplashPage({Key? key}) : super(key: key);

  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: HomePage,
      imageBackground: Image.asset("assets/logo.jpg").image,
      useLoader: true,
      loaderColor: Colors.pink,
      loadingText: Text(
        "loading..",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
