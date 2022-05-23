import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/bloc/addDiary/addDiary_bloc.dart';
import '../../../data/bloc/addDiary/addDiary_event.dart';
import '../../../data/bloc/addDiary/addDiary_state.dart';
import '../../widgets/stats_info.dart';

class ImageRecognizedInfoParent extends StatelessWidget {
  final List<String> output;
  final PickedFile image;
  final String username;
  const ImageRecognizedInfoParent({
    Key key,
    @required this.image,
    @required this.output,
    @required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDiaryBloc(),
      child: ImageRecognizedInfo(
        image: image,
        output: output,
        username: username,
      ),
    );
  }
}

class ImageRecognizedInfo extends StatelessWidget {
  final List<String> output;
  final PickedFile image;
  final String username;
  ImageRecognizedInfo({
    Key key,
    @required this.image,
    @required this.output,
    @required this.username,
  }) : super(key: key);

  AddDiaryBloc appDiaryBloc;

  @override
  Widget build(BuildContext context) {
    appDiaryBloc = BlocProvider.of<AddDiaryBloc>(context);
    CollectionReference foodDiary =
        FirebaseFirestore.instance.collection('foodDiary');
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.height * 0.4,
          child: Image.file(
            File(image.path),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        StatsInfo(
          name: output[0],
          totalCalories: output[2],
          carbohydrate: output[3],
          protein: output[4],
          fat: output[5],
        ),
        SizedBox(
          height: 25,
        ),
        GestureDetector(
          onTap: () => appDiaryBloc.add(
            AddFoodDiaryButtonSelected(
              username: username,
              name: output[0],
              calories: output[2],
              carbohydrate: output[3],
              protein: output[4],
              fat: output[5],
              foodDiary: foodDiary,
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Text(
                "Add to Food Diary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<AddDiaryBloc, AddDiaryState>(
          builder: (context, state) {
            if (state is AddToFoodDiaryInitial) {
              return SizedBox();
            } else if (state is AddToFoodDiaryState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddToFoodDiarySuccessState) {
              var snackBar = SnackBar(
                content: Text(
                  '${state.successMsg}',
                ),
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });

              return SizedBox();
            } else if (state is AddToFoodDiaryFailState) {
              var snackBar = SnackBar(
                content: Text('${state.errorMsg}'),
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              return SizedBox();
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
