class Validator {
  static bool validatePass(String value) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(value);
  }

  static bool validateEmail(String value) {
    final RegExp emailRegex = RegExp(
      r'^[A-Za-z0-9+]+([\.][A-Za-z0-9+]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$',
    );
    return emailRegex.hasMatch(value);
  }
}
