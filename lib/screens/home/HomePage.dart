import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../config/app_navigation.dart';
import '../../data/bloc/homePage/home_page_bloc.dart';
import '../../data/bloc/homePage/home_page_event.dart';
import '../../data/bloc/homePage/home_page_state.dart';
import '../constants/constants.dart';
import 'navigation_drawer.dart';
import 'widgets/image_info.dart';

class HomePageParent extends StatelessWidget {
  final User firebaseUser;
  const HomePageParent({Key key, @required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: HomePage(
        firebaseUser: firebaseUser,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final User firebaseUser;

  const HomePage({Key key, @required this.firebaseUser}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc homePageBloc;

  bool _loading = false;
  PickedFile image;
  final ImagePicker _picker = ImagePicker();

  void initState() {
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

//Load the Tflite model
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: NavigationDrawer(
          firebaseUser: widget.firebaseUser,
        ),
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Text('Calorie Calculator', style: fieldCalorieCalculatorHeader),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: BlocBuilder<HomePageBloc, HomePageState>(
                    builder: (context, state) {
                      print("This is the current state $state");
                      if (state is ImageRecognitionInitialState) {
                        // resize and change color of image
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.8,
                            color: Colors.deepPurple,
                            child: Icon(
                              Icons.photo_album,
                              size: 300,
                              color: Colors.white,
                            ));
                      } else if (state is ImageRecognitionLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ImageRecognitionImageIdentified) {
                        return ImageRecognizedInfoParent(
                          output: state.outputs,
                          image: state.image,
                          username: widget.firebaseUser.email,
                          key: ValueKey(state.outputs),
                        );
                      } else if (state is ImageRecognitionImageNotIdentified) {
                        return Text(
                          state.errorMsg,
                          style: TextStyle(color: Colors.red),
                        );
                      } else if (state is LogOutInitial) {
                        return SizedBox();
                      } else if (state is LogOutSuccess) {
                        return SizedBox();
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                BlocListener<HomePageBloc, HomePageState>(
                  listener: (context, state) {
                    if (state is LogOutSuccess) {
                      jumpToLoginPage(context: context);
                    }
                  },
                  child: SizedBox(),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  backgroundColor: Colors.deepPurpleAccent,
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        GestureDetector(
                          child: Text(
                            "Take a Picture",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            openCamera();
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        GestureDetector(
                          child: Text(
                            "Select image ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            openGallery();
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          backgroundColor: Colors.white,
          child: Icon(Icons.image, color: Colors.cyan, size: 35),
        ),
      ),
    );
  }

  Future openCamera() async {
    var piture = await _picker.getImage(source: ImageSource.camera);

    image = piture;
    homePageBloc.add(ImageSelectionButtonSelected(image: piture));
  }

  Future openGallery() async {
    var piture = await _picker.getImage(source: ImageSource.gallery);

    image = piture;
    homePageBloc.add(ImageSelectionButtonSelected(image: piture));
  }
}
