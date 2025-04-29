extension RegexExtensions on String {
  // Check if the string matches a regex pattern
  bool matches(Pattern pattern, {bool caseSensitive = true}) {
    return RegExp(
      pattern is String ? pattern : (pattern as RegExp).pattern,
      caseSensitive: caseSensitive,
    ).hasMatch(this);
  }

  // Common validations as getters
  bool get isValidEmail => matches(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );

  /// check if the password contains a lowercase letter
  bool get hasLowerCase => contains(RegExp(r'[a-z]'));

  /// check if the password contains an uppercase letter
  bool get hasUpperCase => contains(RegExp(r'[A-Z]'));

  /// check if the password contains a number
  bool get hasDigit => contains(RegExp(r'[0-9]'));

  /// check if the password contains a special character
  bool get hasSpecialCharacter => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  /// check if the password is at least 8 characters long
  bool get hasMinLength => length >= 8;

  bool get isValidPassword =>
      hasLowerCase &&
      hasUpperCase &&
      hasDigit &&
      hasSpecialCharacter &&
      hasMinLength;
}
