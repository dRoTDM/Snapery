import '../../screens/widgets/email_field.dart';
import '../../screens/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/bloc/register/register_bloc.dart';
import '../../data/bloc/register/register_event.dart';
import '../../data/bloc/register/register_state.dart';
import '../../screens/constants/constants.dart';

class RegisterPageParent extends StatelessWidget {
  const RegisterPageParent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);