import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
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
