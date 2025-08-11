/// Scope functions module for Dartlin package.
///
/// This module provides scope functions similar to Kotlin:
/// - let: executes a block and returns the result
/// - also: executes a block and returns the original object
/// - apply: executes a block on the object and returns the object
///
/// Example usage:
/// ```dart
/// import 'package:darlin/scope_functions.dart';
///
/// void main() {
///   final result = 'hello'.let((it) => it.toUpperCase());
///   'hello'.also((it) => print('Processing: $it'));
///   final map = <String, dynamic>{}.apply((it) {
///     it['name'] = 'John';
///     it['age'] = 30;
///   });
/// }
/// ```
library;
export 'src/scope_functions.dart'; 