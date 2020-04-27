import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SignupEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends SignupEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class ConfirmPasswordChanged extends SignupEvent {
  final String confirmPassword;
  final String password;

  const ConfirmPasswordChanged({
    @required this.confirmPassword,
    @required this.password,
  });

  @override
  List<Object> get props => [confirmPassword];

  @override
  String toString() =>
      'ConfirmPasswordChanged { confirmPassword: $confirmPassword }';
}

class YearChanged extends SignupEvent {
  final String year;

  const YearChanged({@required this.year});

  @override
  List<Object> get props => [year];

  @override
  String toString() => 'YearChanged { year: $year }';
}

class Submitted extends SignupEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String birthyear;
  final String gender;
  final bool agreeService;
  final bool agreeSecurity;
  final bool agreeMarketing;

  const Submitted({
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
    @required this.birthyear,
    @required this.gender,
    @required this.agreeService,
    @required this.agreeSecurity,
    @required this.agreeMarketing,
  });

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        birthyear,
        gender,
        agreeService,
        agreeSecurity,
        agreeMarketing,
      ];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
