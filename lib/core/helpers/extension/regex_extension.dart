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

  bool get hasLowerCase => matches(r'(?=.*[a-z])');
  bool get hasUpperCase => matches(r'(?=.*[A-Z])');
  bool get hasDigit => matches(r'(?=.*\d)');
  bool get hasSpecialCharacter => matches(r'(?=.*\W)');
  bool get hasMinLength => length >= 8;

  bool get isValidPassword =>
      hasLowerCase &&
      hasUpperCase &&
      hasDigit &&
      hasSpecialCharacter &&
      hasMinLength;
}
