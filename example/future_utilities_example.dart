import 'package:darlin/darlin.dart';

/// Example demonstrating the Future/Async utilities
Future<void> main() async {
  print('=== Future/Async Utilities Example ===\n');

  // Example 1: thenIfNotNull - only execute when result is not null
  print('1. thenIfNotNull example:');
  await demonstrateThenIfNotNull();

  // Example 2: thenIf - conditional execution
  print('\n2. thenIf example:');
  await demonstrateThenIf();

  // Example 3: onErrorReturn - error handling with default values
  print('\n3. onErrorReturn example:');
  await demonstrateOnErrorReturn();

  // Example 4: onFinally - cleanup operations
  print('\n4. onFinally example:');
  await demonstrateOnFinally();

  // Example 5: Chaining multiple operations
  print('\n5. Chaining example:');
  await demonstrateChaining();
}

/// Demonstrates thenIfNotNull functionality
Future<void> demonstrateThenIfNotNull() async {
  // Simulate fetching user data that might be null
  Future<String?> fetchUser() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 100));
    // Randomly return null or a user name
    return DateTime.now().millisecond % 2 == 0 ? 'John Doe' : null;
  }

  final result = await fetchUser()
      .thenIfNotNull((user) => 'Hello, $user!')
      .thenIfNotNull((greeting) => greeting?.toUpperCase());

  if (result != null) {
    print('  Success: $result');
  } else {
    print('  No user found, greeting not generated');
  }
}

/// Demonstrates thenIf functionality
Future<void> demonstrateThenIf() async {
  // Simulate checking if user is logged in
  Future<bool> checkLoginStatus() async {
    await Future.delayed(Duration(milliseconds: 50));
    return DateTime.now().millisecond % 3 != 0; // 2/3 chance of being logged in
  }

  // Simulate fetching user profile
  Future<String> fetchProfile() async {
    await Future.delayed(Duration(milliseconds: 100));
    return 'User Profile Data';
  }

  final result = await checkLoginStatus()
      .thenIf((isLoggedIn) => isLoggedIn, (value) => fetchProfile());

  if (result != null) {
    print('  User is logged in, profile: $result');
  } else {
    print('  User is not logged in, no profile fetched');
  }
}

/// Demonstrates onErrorReturn functionality
Future<void> demonstrateOnErrorReturn() async {
  // Simulate a network request that might fail
  Future<String> fetchData() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (DateTime.now().millisecond % 2 == 0) {
      throw Exception('Network error occurred');
    }
    return 'Data from server';
  }

  try {
    final result = await fetchData().onErrorReturn('Default fallback data');
    print('  Result: $result');
  } catch (e) {
    print('  Unexpected error: $e');
  }
}

/// Demonstrates onFinally functionality
Future<void> demonstrateOnFinally() async {
  // Simulate a database operation
  Future<String> performDatabaseOperation() async {
    await Future.delayed(Duration(milliseconds: 150));
    if (DateTime.now().millisecond % 4 == 0) {
      throw Exception('Database connection failed');
    }
    return 'Database operation completed successfully';
  }

  try {
    final result = await performDatabaseOperation()
        .onFinally(() => print('  Cleanup: Closing database connections'));
    print('  Operation result: $result');
  } catch (e) {
    print('  Operation failed: $e');
  }
}

/// Demonstrates chaining multiple operations
Future<void> demonstrateChaining() async {
  // Simulate a multi-step process
  Future<int> getInitialValue() async {
    await Future.delayed(Duration(milliseconds: 50));
    return DateTime.now().millisecond % 100;
  }

  final result = await getInitialValue()
      .thenIf((value) => value > 50, (value) => value * 2)
      .thenIfNotNull((value) => value.toString())
      .thenNullable((value) => value != null && value.length > 1 ? value : null);

  if (result != null) {
    print('  Chained operation result: $result');
  } else {
    print('  Chained operation returned null');
  }
} 