import '../../screens/constants/constants.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key key,
    @required TextEditingController emailCntrller,
  })  : _emailCntrller = emailCntrller,
        super(key: key);

  final TextEditingController _emailCntrller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your Email Address";
          } else if (value != null &&
              !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
            return "Please enter a Valid Email";
          } else {
            return null;
          }
        },
        autofocus: false,
        textInputAction: TextInputAction.done,
        style: fieldTextStyle,
        controller: _emailCntrller,
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: fieldTextStyle,
          prefixIcon: Icon(
            Icons.mail,
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
    );
  }
}
