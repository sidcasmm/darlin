/// Object utilities module for Dartlin package.
///
/// This module provides object extensions and utilities including:
/// - Object comparison and cloning utilities (deepEqual, copyWith, deepCopy)
/// - Object manipulation helpers
///
/// Example usage:
/// ```dart
/// import 'package:darlin/object_utils.dart';
///
/// void main() {
///   final obj1 = {'name': 'John', 'age': 30};
///   final obj2 = {'name': 'John', 'age': 30};
///   print(obj1.deepEqual(obj2)); // true
///   final copy = obj1.deepCopy();
///   final updated = obj1.copyWith({'age': 31});
/// }
/// ```
library;
export 'src/object_extensions.dart'; 