import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';
import 'package:flutterapp/common/validators.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

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
  Stream<Transition<SigninEvent, SigninState>> transformEvents(
    Stream<SigninEvent> events,
    TransitionFunction<SigninEvent, SigninState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SigninWithCredentialsPressed) {
      yield* _mapSigninWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<SigninState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SigninState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
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
//      yield SigninState.success();
      yield SigninState.failure(error.message);
    }
  }
}
