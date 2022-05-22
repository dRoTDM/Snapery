import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

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