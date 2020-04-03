import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthenticationBloc _authenticationBloc;

  SigninBloc({
    @required AuthenticationBloc authenticationBloc,
  })  : assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc;

  @override
  SigninState get initialState => SigninState.empty();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SigninWithCredentialsPressed) {
      yield* _mapSigninWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SigninState> _mapSigninWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield SigninState.loading();
    try {
      final basicToken =
          'Basic ' + base64.encode(utf8.encode('$email:$password'));
      final response =
          await _authenticationBloc.basicAuth('/auth/v1/signin', basicToken);
      yield SigninState.success();
    } catch (error) {
      yield SigninState.failure();
    }
  }
}
