import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessfulState extends LoginState {
  final User user;

  LoginSuccessfulState({@required this.user});
  @override
  List<Object> get props => [user];
}

class LoginFailureState extends LoginState {
  final String errorMsg;

  LoginFailureState({@required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
