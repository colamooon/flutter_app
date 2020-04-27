import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends SigninEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends SigninEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends SigninEvent {
  final String email;
  final String password;

  const Submitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
class SigninWithCredentialsPressed extends SigninEvent {
  final String email;
  final String password;

  const SigninWithCredentialsPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'SigninWithCredentialsPressed { email: $email, password: $password }';
  }
}
