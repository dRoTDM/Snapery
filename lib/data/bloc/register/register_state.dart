import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable {}

class RegisterIntialState extends RegisterState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RegisterLoadingState extends RegisterState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RegisterSuccessfulState extends RegisterState {
  User user;

  RegisterSuccessfulState({@required this.user});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class RegisterFailureState extends RegisterState {
  String errorMsg;

  RegisterFailureState({@required this.errorMsg});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
