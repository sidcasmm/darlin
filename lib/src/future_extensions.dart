import 'dart:async';

/// Extensions on Future to provide convenient asynchronous handling utilities.
extension FutureUtils<T> on Future<T> {
  /// Executes the given function only if the result is not null.
  ///
  /// This is useful when you want to chain operations but only proceed
  /// when the previous result has a meaningful value.
  ///
  /// Example:
  /// ```dart
  /// Future<String?> fetchUser() async => 'John';
  /// 
  /// await fetchUser()
  ///   .thenIfNotNull((name) => print('Hello $name'))
  ///   .thenIfNotNull((_) => print('User greeted successfully'));
  /// ```
  Future<R?> thenIfNotNull<R>(FutureOr<R> Function(T value) onValue) {
    return then((value) {
      if (value != null) {
        return onValue(value);
      }
      return null;
    });
  }

  /// Executes the given function only if the condition is true.
  ///
  /// This allows conditional execution of asynchronous operations
  /// based on the result of the previous operation.
  ///
  /// Example:
  /// ```dart
  /// Future<bool> isUserLoggedIn() async => true;
  /// 
  /// await isUserLoggedIn()
  ///   .thenIf((isLoggedIn) => isLoggedIn, 
  ///           (value) => fetchUserProfile())
  ///   .thenIf((profile) => profile != null,
  ///           (profile) => updateLastSeen(profile.id));
  /// ```
  Future<R?> thenIf<R>(
    bool Function(T value) condition,
    FutureOr<R> Function(T value) onConditionMet,
  ) {
    return then((value) {
      if (condition(value)) {
        return onConditionMet(value);
      }
      return null;
    });
  }

  /// Returns a default value if the future fails with an error.
  ///
  /// This provides a clean way to handle errors by specifying fallback values
  /// instead of throwing exceptions.
  ///
  /// Example:
  /// ```dart
  /// Future<String> fetchData() async => throw Exception('Network error');
  /// 
  /// final result = await fetchData()
  ///   .onErrorReturn('default data');
  /// // result will be 'default data' instead of throwing an exception
  /// ```
  Future<T> onErrorReturn(T defaultValue) {
    return catchError((error, stackTrace) => defaultValue);
  }

  /// Returns a default value if the future fails with an error, with custom error handling.
  ///
  /// This allows you to both handle the error and return a default value.
  ///
  /// Example:
  /// ```dart
  /// Future<String> fetchData() async => throw Exception('Network error');
  /// 
  /// final result = await fetchData()
  ///   .onErrorReturnWith('default data', (error, stackTrace) {
  ///     print('Error occurred: $error');
  ///     // Log error, send analytics, etc.
  ///   });
  /// ```
  Future<T> onErrorReturnWith(
    T defaultValue,
    void Function(Object error, StackTrace? stackTrace) onError,
  ) {
    return catchError((error, stackTrace) {
      onError(error, stackTrace);
      return defaultValue;
    });
  }

  /// Executes a function when the future completes, regardless of success or failure.
  ///
  /// This is useful for cleanup operations or logging that should happen
  /// regardless of the outcome.
  ///
  /// Example:
  /// ```dart
  /// Future<String> fetchData() async => 'data';
  /// 
  /// await fetchData()
  ///   .onFinally(() => print('Operation completed'));
  /// ```
  Future<T> onFinally(FutureOr<void> Function() action) async {
    try {
      final result = await this;
      await action();
      return result;
    } catch (error, _) {
      await action();
      rethrow;
    }
  }

  /// Transforms the result of a future using a nullable transformation function.
  ///
  /// If the transformation returns null, the result will be null.
  /// This is useful for optional transformations that might not always produce a value.
  ///
  /// Example:
  /// ```dart
  /// Future<String> fetchUser() async => 'John Doe';
  /// 
  /// final firstName = await fetchUser()
  ///   .thenNullable((fullName) => fullName.split(' ').firstOrNull);
  /// ```
  Future<R?> thenNullable<R>(R? Function(T value) transform) {
    return then((value) => transform(value));
  }
} 