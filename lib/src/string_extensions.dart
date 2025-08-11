/// Extensions on nullable String to provide Kotlin-like null safety checks.
extension StringChecks on String? {
  /// Returns true if the string is null or empty.
  ///
  /// Equivalent to Kotlin's `isNullOrEmpty()`.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if the string is null or contains only whitespace characters.
  ///
  /// Equivalent to Kotlin's `isNullOrBlank()`.
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  /// Returns true if the string is not null and not empty.
  ///
  /// Opposite of `isNullOrEmpty`.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Returns true if the string is not null and contains non-whitespace characters.
  ///
  /// Opposite of `isNullOrBlank`.
  bool get isNotNullOrBlank => this != null && this!.trim().isNotEmpty;
}

/// Extensions on String to provide additional utility methods.
extension StringUtils on String {
  /// Returns the reversed string.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.reversed // 'olleh'
  /// ```
  String get reversed => split('').reversed.join('');

  /// Capitalizes the first character of the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalize() // 'Hello world'
  /// ```
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns true if the string contains only numeric characters.
  ///
  /// Example:
  /// ```dart
  /// '123'.isNumeric // true
  /// '123abc'.isNumeric // false
  /// '12.34'.isNumeric // false (contains decimal point)
  /// ```
  bool get isNumeric {
    if (isEmpty) return false;
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// Returns true if the string is a valid email address.
  ///
  /// Example:
  /// ```dart
  /// 'user@example.com'.isEmail // true
  /// 'invalid-email'.isEmail // false
  /// ```
  bool get isEmail {
    if (isEmpty) return false;
    return RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        ).hasMatch(this) &&
        !contains('..');
  }

  /// Removes all whitespace characters from the string.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.removeWhitespaces() // 'helloworld'
  /// '  hello  world  '.removeWhitespaces() // 'helloworld'
  /// ```
  String removeWhitespaces() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Safely truncates the string to the specified maximum length.
  ///
  /// If the string is shorter than maxLength, it returns the original string.
  /// If longer, it truncates and adds '...' at the end.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.limit(5) // 'hello...'
  /// 'hi'.limit(10) // 'hi'
  /// ```
  String limit(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}
