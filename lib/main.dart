// ignore_for_file: prefer_const_constructors, unused_import, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'MySplashPage.dart';
import 'package:camera/camera.dart';

import 'HomePage.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snapery',
      home: MySplashPage(),
    );
  }
}
