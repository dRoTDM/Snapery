// ignore_for_file: prefer_const_constructors, deprecated_member_use, import_of_legacy_library_into_null_safe, unnecessary_null_comparison, sized_box_for_whitespace, unused_import

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:snapery/main.dart';
import 'package:snapery/MySplashPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isWorking = false;
  String result = "";
  late CameraImage imgCamera;
  late CameraController cameraController;

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imagesFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imagesFromStream,
                }
            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/logo.jpg"))),
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      color: Colors.black,
                      height: 300,
                      width: 300,
                      child: Image.asset("assets/logo.jpg"),
                    ),
                  ),
                  Center(
                    child: FlatButton(
                      onPressed: () {
                        initCamera();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 270,
                        width: 300,
                        child: imgCamera == null
                            ? Container(
                                height: 270,
                                width: 300,
                                child: Icon(
                                  Icons.photo_camera_front,
                                  color: Colors.blueAccent,
                                  size: 40,
                                ),
                              )
                            : AspectRatio(
                                aspectRatio: cameraController.value.aspectRatio,
                                child: CameraPreview(cameraController),
                              ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
