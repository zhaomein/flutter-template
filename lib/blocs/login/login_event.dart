import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  List<Object> get props => [];
}

class LoginStart extends LoginEvent {
  final String phone;
  final String callingCode;
  final String password;

  LoginStart({this.phone, this.callingCode, this.password});

  @override
  List<Object> get props => [phone, callingCode, password];
}

class LoginSuccess extends LoginEvent {}

class LoginFail extends LoginEvent {}