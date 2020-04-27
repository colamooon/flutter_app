import 'package:meta/meta.dart';

@immutable
class SignupState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isYearValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String failureMessage;

  bool get isFormValid =>
      isEmailValid && isPasswordValid && isConfirmPasswordValid && isYearValid;

  SignupState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isConfirmPasswordValid,
    @required this.isYearValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.failureMessage,
  });

  factory SignupState.empty() {
    return SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isYearValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      failureMessage: null,
    );
  }

  factory SignupState.loading() {
    return SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isYearValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      failureMessage: null,
    );
  }

  factory SignupState.failure(failureMessage) {
    return SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isYearValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      failureMessage: failureMessage,
    );
  }

  factory SignupState.success() {
    return SignupState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isYearValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      failureMessage: null,
    );
  }

  SignupState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isYearValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isYearValid: isYearValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignupState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isYearValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String failureMessage,
  }) {
    return SignupState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
          isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isYearValid: isYearValid ?? this.isYearValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  String toString() {
    return '''SignupState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isConfirmPasswordValid: $isConfirmPasswordValid,      
      isYearValid: $isYearValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      failureMessage: $failureMessage,
    }''';
  }
}
