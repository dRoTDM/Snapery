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

  final TextEditingController _emailCntrller = TextEditingController();
  final TextEditingController _passwordCntrller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterBloc registerBloc;

  @override
  Widget build(BuildContext context) {
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
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
              Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              BlocBuilder<RegisterBloc, RegisterState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is RegisterIntialState) {
                    return SizedBox();
                  } else if (state is RegisterLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is RegisterSuccessfulState) {
                    return Text(
                      "User sucessfully Registered. You can sign in now",
                      style: TextStyle(color: Colors.white),
                    );
                  } else if (state is RegisterFailureState) {
                    return Text(
                      state.errorMsg,
                      style: TextStyle(color: Colors.red),
                    );
                  }
                },
              ),
              SizedBox(height: 25),
              EmailField(emailCntrller: _emailCntrller),
              SizedBox(height: 15),
              PasswordField(passwordCntrller: _passwordCntrller),
              SizedBox(height: 25),
              Material(
                elevation: 2,
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
                child: MaterialButton(
                  padding: fieldTextContentPadding,
                  minWidth: MediaQuery.of(context).size.width / 2,
                  //Todo app login method
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      registerBloc.add(
                        SignUpButtonPressedEvent(
                            email: _emailCntrller.text,
                            password: _passwordCntrller.text),
                      );
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    //Todo add gesture detector navigation to register screen
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
