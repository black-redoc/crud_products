class UserValidator {
  static final RegExp _emailValidator = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
  );

  static final RegExp _passwordValidator = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'
  );

  static bool isEmailValid({ String? email }) {
    return _emailValidator.hasMatch(email!);
  }

  static bool isPasswordValid({ String? password }) {
    return _passwordValidator.hasMatch(password!);
  }
}