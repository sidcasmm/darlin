/// Extensions on nullable List to provide Kotlin-like null safety checks.
extension ListChecks<T> on List<T>? {
  /// Returns true if the list is null or empty.
  ///
  /// Equivalent to Kotlin's `isNullOrEmpty()`.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if the list is not null and not empty.
  ///
  /// Opposite of `isNullOrEmpty`.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}

/// Extensions on List to provide additional utility methods.
extension ListUtils<T> on List<T> {
  /// Returns the first element or null if the list is empty.
  ///
  /// Equivalent to Kotlin's `firstOrNull()`.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].firstOrNull() // 1
  /// <int>[].firstOrNull() // null
  /// ```
  T? firstOrNull() {
    return isEmpty ? null : first;
  }

  /// Returns the last element or null if the list is empty.
  ///
  /// Equivalent to Kotlin's `lastOrNull()`.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].lastOrNull() // 3
  /// <int>[].lastOrNull() // null
  /// ```
  T? lastOrNull() {
    return isEmpty ? null : last;
  }

  /// Returns the single element or null if the list is empty or has more than one element.
  ///
  /// Equivalent to Kotlin's `singleOrNull()`.
  ///
  /// Example:
  /// ```dart
  /// [1].singleOrNull() // 1
  /// [1, 2].singleOrNull() // null
  /// <int>[].singleOrNull() // null
  /// ```
  T? singleOrNull() {
    return length == 1 ? first : null;
  }

  /// Returns a list containing only elements that have distinct keys extracted by the given selector function.
  ///
  /// Equivalent to Kotlin's `distinctBy()`.
  ///
  /// Example:
  /// ```dart
  /// final people = [Person('John', 25), Person('Jane', 25), Person('Bob', 30)];
  /// final distinctByAge = people.distinctBy((p) => p.age);
  /// // Result: [Person('John', 25), Person('Bob', 30)]
  /// ```
  List<T> distinctBy<K>(K Function(T) selector) {
    final seen = <K>{};
    final result = <T>[];

    for (final element in this) {
      final key = selector(element);
      if (!seen.contains(key)) {
        seen.add(key);
        result.add(element);
      }
    }

    return result;
  }

  /// Returns a list containing only elements that satisfy the given predicate.
  ///
  /// Equivalent to Kotlin's `takeIf()`.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].takeIf((n) => n > 2) // [3, 4, 5]
  /// ```
  List<T> takeIf(bool Function(T) predicate) {
    return where(predicate).toList();
  }

  /// Returns a list containing only elements that do not satisfy the given predicate.
  ///
  /// Equivalent to Kotlin's `takeUnless()`.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].takeUnless((n) => n > 2) // [1, 2]
  /// ```
  List<T> takeUnless(bool Function(T) predicate) {
    return where((element) => !predicate(element)).toList();
  }

  /// Returns a list containing all non-null elements.
  ///
  /// Equivalent to Kotlin's `filterNotNull()`.
  ///
  /// Example:
  /// ```dart
  /// [1, null, 2, null, 3].filterNotNull() // [1, 2, 3]
  /// ```
  List<T> filterNotNull() {
    return where((element) => element != null).toList();
  }

  /// Returns a list containing only the non-null results of applying the given transform function.
  ///
  /// Equivalent to Kotlin's `mapNotNull()`.
  ///
  /// Example:
  /// ```dart
  /// ['1', '2', 'abc', '3'].mapNotNull((s) => int.tryParse(s)) // [1, 2, 3]
  /// ```
  List<R> mapNotNull<R>(R? Function(T) transform) {
    final result = <R>[];

    for (final element in this) {
      final transformed = transform(element);
      if (transformed != null) {
        result.add(transformed);
      }
    }

    return result;
  }
}
