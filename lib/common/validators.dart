class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
//    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,25}$',
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9!@#$%^()]{8,25}',
  );

  static final RegExp _yearRegExp = RegExp(
    r'^(19|[2][0-9])\d{2}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidYear(String year) {
    return _yearRegExp.hasMatch(year);
  }
}
