import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BMICalculatorForm extends StatelessWidget {
  final String username;
  final CollectionReference bmi;
  BMICalculatorForm({
    Key key,
    @required this.bmi,
    @required this.username,
  }) : super(key: key);

  final ageCntrler = TextEditingController();
  final heightCntrler = TextEditingController();
  final weightCntrler = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Text(
              "BMI CALCULATOR",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an Age";
                        } else if (value != null &&
                            !RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                          return "Please enter a Valid Age";
                        } else {
                          return null;
                        }
                      },
                      controller: ageCntrler,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      style: fieldTextStyle,
                      decoration: InputDecoration(
                        hintText: "Age",
                        hintStyle: fieldTextStyle,
                        prefixIcon: Icon(
                          Icons.face,
                          color: Colors.white,
                        ),
                        contentPadding: fieldTextContentPadding,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Height";
                        } else if (value != null &&
                            !RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                          return "Please enter a Valid Height";
                        } else {
                          return null;
                        }
                      },
                      controller: heightCntrler,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      style: fieldTextStyle,
                      decoration: InputDecoration(
                        hintText: "Height (In Cms)",
                        hintStyle: fieldTextStyle,
                        prefixIcon: Icon(
                          Icons.height_outlined,
                          color: Colors.white,
                        ),
                        contentPadding: fieldTextContentPadding,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Weight";
                        } else if (value != null &&
                            !RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                          return "Please enter a Valid Weight";
                        } else {
                          return null;
                        }
                      },
                      controller: weightCntrler,
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      style: fieldTextStyle,
                      decoration: InputDecoration(
                        hintText: "Weight (In Kgs)",
                        hintStyle: fieldTextStyle,
                        prefixIcon: Icon(
                          Icons.line_weight,
                          color: Colors.white,
                        ),
                        contentPadding: fieldTextContentPadding,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Material(
                    elevation: 2,
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(25),
                    child: MaterialButton(
                      padding: fieldTextContentPadding,
                      minWidth: MediaQuery.of(context).size.width / 2,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          bmi.add({
                            'username': username,
                            'age': ageCntrler.text,
                            'height': heightCntrler.text,
                            'weight': weightCntrler.text,
                            'date': DateTime.now(),
                          });
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
