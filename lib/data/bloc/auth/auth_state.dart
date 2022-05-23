import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthenicatedState extends AuthState {
  final User user;

  AuthenicatedState({@required this.user});

  @override
  List<Object> get props => [user];
}

class UnAuthenicatedState extends AuthState {
  @override
  List<Object> get props => [];
}
