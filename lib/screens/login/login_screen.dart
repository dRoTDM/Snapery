import '../../screens/widgets/email_field.dart';
import '../../screens/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
