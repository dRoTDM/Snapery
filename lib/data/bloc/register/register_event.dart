import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RegisterEvent extends Equatable {}

class SignUpButtonPressedEvent extends RegisterEvent {
  String email;
  String password;

  SignUpButtonPressedEvent({@required this.email, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
