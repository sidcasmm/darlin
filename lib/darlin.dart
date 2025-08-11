/// A Dart package that provides Kotlin-like utilities and extensions.
///
/// This package includes:
/// - String null safety checks (isNullOrEmpty, isNullOrBlank, etc.)
/// - Scope functions (let, also, apply) for any object
/// - Object comparison and cloning utilities (deepEqual, copyWith, deepCopy)
/// - List manipulation and transformation utilities
/// - Boolean logic helpers
/// - Future manipulation utilities
/// - Nullable utilities and safe navigation
///
/// ## Import Options
///
/// ### Full Package Import
/// ```dart
/// import 'package:darlin/darlin.dart';
/// ```
///
/// ### Modular Imports
/// Import only the functionality you need:
/// ```dart
/// import 'package:darlin/core.dart';           // Most common utilities
/// import 'package:darlin/string_utils.dart';   // String utilities only
/// import 'package:darlin/scope_functions.dart'; // Scope functions only
/// import 'package:darlin/list_utils.dart';     // List utilities only
/// import 'package:darlin/collections.dart';    // List + Object utilities
/// import 'package:darlin/nullable_utils.dart'; // Nullable utilities only
/// import 'package:darlin/boolean_utils.dart';  // Boolean utilities only
/// import 'package:darlin/future_utils.dart';   // Future utilities only
/// import 'package:darlin/object_utils.dart';   // Object utilities only
/// ```
///
/// Example usage:
/// ```dart
/// import 'package:darlin/darlin.dart';
///
/// void main() {
///   String? nullableString = null;
///
///   // String checks
///   print(nullableString.isNullOrEmpty); // true
///   print(nullableString.isNullOrBlank); // true
///
///   // Scope functions
///   final result = nullableString?.let((it) => it.toUpperCase());
///   nullableString?.also((it) => print('Processing: $it'));
///
///   // Object utilities
///   final obj1 = {'name': 'John', 'age': 30};
///   final obj2 = {'name': 'John', 'age': 30};
///   print(obj1.deepEqual(obj2)); // true
///   final copy = obj1.deepCopy();
///   final updated = obj1.copyWith({'age': 31});
/// }
/// ```
library;

export 'src/string_extensions.dart';
export 'src/scope_functions.dart';
export 'src/list_extensions.dart';
export 'src/nullable_extensions.dart';
export 'src/boolean_extensions.dart';
export 'src/future_extensions.dart';
export 'src/object_extensions.dart';
