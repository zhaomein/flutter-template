import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
  const RegisterEvent();
}

class RegisterProcess extends RegisterEvent {
  final String callingCode;
  final String phone;
  final String email;
  final String firebaseToken;
  final String firstName;
  final String lastName;
  final String password;
  final String birthday;
  final String gender;
  final String country;
  final String city;

  const RegisterProcess({
    this.callingCode, this.phone, this.firebaseToken, this.firstName, this.country,
    this.lastName, this.password, this.email, this.birthday, this.gender, this.city
  });

  @override
  List<Object> get props => [
    callingCode, phone, firebaseToken, this.country, this.city,
    firstName, lastName, firstName, password, birthday
  ];
}