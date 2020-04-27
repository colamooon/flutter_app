import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutterapp/authentication_bloc/authentication_bloc.dart';
import 'package:flutterapp/common/validators.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationBloc _authenticationBloc;

  SignupBloc({@required AuthenticationBloc authenticationBloc})
      : assert(authenticationBloc != null),
        _authenticationBloc = authenticationBloc;

  @override
  SignupState get initialState => SignupState.empty();

  @override
  Stream<Transition<SignupEvent, SignupState>> transformEvents(
    Stream<SignupEvent> events,
    TransitionFunction<SignupEvent, SignupState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! ConfirmPasswordChanged &&
          event is! YearChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is ConfirmPasswordChanged ||
          event is YearChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is ConfirmPasswordChanged) {
      yield* _mapConfirmPasswordChangedToState(
          event.confirmPassword, event.password);
    } else if (event is YearChanged) {
      yield* _mapYearChangedToState(event.year);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.email,
        event.password,
        event.confirmPassword,
        event.birthyear,
        event.gender,
        event.agreeService,
        event.agreeSecurity,
        event.agreeMarketing,
      );
    }
  }

  Stream<SignupState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignupState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignupState> _mapConfirmPasswordChangedToState(
      String confirmPassword, String password) async* {
    yield state.update(
      isConfirmPasswordValid: confirmPassword == password,
    );
  }

  Stream<SignupState> _mapYearChangedToState(String year) async* {
    yield state.update(
      isYearValid: Validators.isValidYear(year),
    );
  }

  Stream<SignupState> _mapFormSubmittedToState(
    String email,
    String password,
    String confirmPassword,
    String birthyear,
    String gender,
    bool agreeService,
    bool agreeSecurity,
    bool agreeMarketing,
  ) async* {
    yield SignupState.loading();
    try {
      String body = json.encode({
        "username": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "birthyear": birthyear,
        "gender": gender,
        "agreeService": agreeService,
        "agreeSecurity": agreeSecurity,
        "agreeMarketing": agreeMarketing,
      });
      final response =
          await _authenticationBloc.postWithoutAuth('/auth/v1/signup', body);
      yield SignupState.success();
    } catch (error) {
      yield SignupState.failure(error.message);
    }
  }
}
