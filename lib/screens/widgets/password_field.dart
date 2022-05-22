import '../../screens/constants/constants.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key key,
    @required TextEditingController passwordCntrller,
  })  : _passwordCntrller = passwordCntrller,
        super(key: key);

  final TextEditingController _passwordCntrller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: TextFormField(
        obscureText: true,
        autofocus: false,
        textInputAction: TextInputAction.done,
        style: fieldTextStyle,
        controller: _passwordCntrller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your Password.";
          } else if (value.length < 6 && value != null) {
            return "Please enter a Password more than 6 characters";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: fieldTextStyle,
          prefixIcon: Icon(
            Icons.vpn_key,
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
