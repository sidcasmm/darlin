/// Core utilities module for Dartlin package.
///
/// This module provides the most commonly used utilities:
/// - String utilities (null safety checks, manipulation)
/// - Nullable utilities (safe navigation, null-aware operations)
/// - Scope functions (let, also, apply)
///
/// Example usage:
/// ```dart
/// import 'package:darlin/core.dart';
///
/// void main() {
///   String? nullableString = null;
///   print(nullableString.isNullOrEmpty); // true
///   
///   final result = nullableString?.let((it) => it.toUpperCase());
///   nullableString?.also((it) => print('Processing: $it'));
/// }
/// ```
library;
export 'src/string_extensions.dart';
export 'src/nullable_extensions.dart';
export 'src/scope_functions.dart'; 