import 'package:meta/meta.dart';

@immutable
class SigninState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  SigninState({
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory SigninState.empty() {
    return SigninState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SigninState.loading() {
    return SigninState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SigninState.failure() {
    return SigninState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory SigninState.success() {
    return SigninState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SigninState copyWith({
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SigninState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SigninState {
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
