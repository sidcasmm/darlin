/// Extensions on Boolean to provide additional utility methods.
extension BooleanUtils on bool {
  /// Toggles the boolean value.
  ///
  /// Returns the opposite of the current boolean value.
  ///
  /// Example:
  /// ```dart
  /// bool flag = true;
  /// flag = flag.toggle(); // false
  /// flag = flag.toggle(); // true
  /// ```
  bool toggle() {
    return !this;
  }
}

/// Extensions on nullable Boolean to provide logical operations.
extension NullableBooleanUtils on bool? {
  /// Performs XOR operation with another nullable boolean.
  ///
  /// Returns null if either operand is null.
  /// Returns true if exactly one operand is true, false otherwise.
  ///
  /// Example:
  /// ```dart
  /// true.xor(false) // true
  /// true.xor(true) // false
  /// false.xor(false) // false
  /// true.xor(null) // null
  /// null.xor(true) // null
  /// ```
  bool? xor(bool? other) {
    if (this == null || other == null) return null;
    return this! != other;
  }

  /// Performs AND operation with another nullable boolean.
  ///
  /// Returns null if either operand is null.
  /// Returns true only if both operands are true.
  ///
  /// Example:
  /// ```dart
  /// true.and(true) // true
  /// true.and(false) // false
  /// false.and(false) // false
  /// true.and(null) // null
  /// null.and(true) // null
  /// ```
  bool? and(bool? other) {
    if (this == null || other == null) return null;
    return this! && other;
  }

  /// Performs OR operation with another nullable boolean.
  ///
  /// Returns null if either operand is null.
  /// Returns true if at least one operand is true.
  ///
  /// Example:
  /// ```dart
  /// true.or(true) // true
  /// true.or(false) // true
  /// false.or(false) // false
  /// true.or(null) // null
  /// null.or(true) // null
  /// ```
  bool? or(bool? other) {
    if (this == null || other == null) return null;
    return this! || other;
  }
}
