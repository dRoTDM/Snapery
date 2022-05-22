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

                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessfulState) {
                      jumpToHomePage(
                        context: context,
                        firebaseUser: state.user,
                      );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginInitialState) {
                        return SizedBox();
                      } else if (state is LoginLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is LoginSuccessfulState) {
                        return SizedBox();
                      } else if (state is LoginFailureState) {
                        return Text(
                          state.errorMsg,
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        return null;
                      }
                    },
                  ),
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
                        loginBloc.add(
                          LoginButtonPressed(
                              email: _emailCntrller.text,
                              password: _passwordCntrller.text),
                        );
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        jumpToRegisterPage(context: context);
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Material(
                  elevation: 2,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  child: MaterialButton(
                    padding: fieldTextContentPadding,
                    minWidth: MediaQuery.of(context).size.width / 2,
                    //Todo app login method
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        loginBloc.add(
                          LoginButtonPressed(
                              email: _emailCntrller.text,
                              password: _passwordCntrller.text),
                        );
                      }
                    },
                    child: Text(
                      "Google Sign In",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
