/// Extensions on nullable objects to provide Kotlin-like null safety utilities.
extension NullableUtils<T> on T? {
  /// Returns true if the object is null.
  ///
  /// Example:
  /// ```dart
  /// String? nullableString = null;
  /// print(nullableString.isNull); // true
  /// ```
  bool get isNull => this == null;

  /// Returns true if the object is not null.
  ///
  /// Example:
  /// ```dart
  /// String? nullableString = 'hello';
  /// print(nullableString.isNotNull); // true
  /// ```
  bool get isNotNull => this != null;

  /// Returns the object if it's not null, otherwise returns the fallback value.
  ///
  /// Equivalent to Kotlin's `?:` operator.
  ///
  /// Example:
  /// ```dart
  /// String? nullableString = null;
  /// final result = nullableString.ifNull('default'); // 'default'
  ///
  /// String? nonNullString = 'hello';
  /// final result2 = nonNullString.ifNull('default'); // 'hello'
  /// ```
  T ifNull(T fallback) {
    return this ?? fallback;
  }

  /// Executes the given function if the object is not null.
  ///
  /// Equivalent to Kotlin's `?.let {}` without returning a value.
  ///
  /// Example:
  /// ```dart
  /// String? nullableString = 'hello';
  /// nullableString.ifNotNull((value) => print('Value is: $value'));
  /// // Prints: Value is: hello
  ///
  /// String? nullString = null;
  /// nullString.ifNotNull((value) => print('This won\'t print'));
  /// // Nothing is printed
  /// ```
  void ifNotNull(void Function(T value) action) {
    if (this != null) {
      action(this as T);
    }
  }
}
