import '../../screens/widgets/email_field.dart';
import '../../screens/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/app_navigation.dart';
import '../../data/bloc/login/login_bloc.dart';
import '../../data/bloc/login/login_event.dart';
import '../../data/bloc/login/login_state.dart';
import '../../screens/constants/constants.dart';
import '../constants/ic_config.dart';

class LoginPageParent extends StatelessWidget {
  const LoginPageParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  final TextEditingController _emailCntrller = TextEditingController();
  final TextEditingController _passwordCntrller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurpleAccent,
        body: Form(
          key: _formKey,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Todo change icon of the application
                SvgPicture.asset(
                  IconLogo,
                  color: Colors.white,
                  height: 250,
                  width: 250,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),