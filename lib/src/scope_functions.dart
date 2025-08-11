/// Extensions on any nullable object to provide Kotlin-like scope functions.
extension ScopeFunctions<T> on T? {
  /// Executes the given function if the object is not null and returns the result.
  ///
  /// Equivalent to Kotlin's `let()` function.
  ///
  /// Example:
  /// ```dart
  /// final result = nullableString?.let((it) => it.toUpperCase());
  /// ```
  R? let<R>(R Function(T it) block) {
    if (this == null) return null;
    return block(this as T);
  }

  /// Executes the given function if the object is not null and returns the original object.
  ///
  /// Equivalent to Kotlin's `also()` function. Useful for side effects.
  ///
  /// Example:
  /// ```dart
  /// final result = someObject?.also((it) => print('Processing: $it'));
  /// ```
  T? also(void Function(T it) block) {
    if (this == null) return null;
    block(this as T);
    return this;
  }

  /// Executes the given function if the object is not null and returns the original object.
  ///
  /// Equivalent to Kotlin's `apply()` function. Useful for configuring objects.
  ///
  /// Example:
  /// ```dart
  /// final person = Person()?.apply((it) {
  ///   it.name = 'John';
  ///   it.age = 30;
  /// });
  /// ```
  T? apply(void Function(T it) block) {
    if (this == null) return null;
    block(this as T);
    return this;
  }
}
