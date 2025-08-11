/// Collections utilities module for Dartlin package.
///
/// This module provides collection-related utilities:
/// - List extensions and manipulation utilities
/// - Object utilities for collections (deepEqual, copyWith, deepCopy)
///
/// Example usage:
/// ```dart
/// import 'package:darlin/collections.dart';
///
/// void main() {
///   final list = [1, 2, 3, 4, 5];
///   // Use list extensions here
///   
///   final obj1 = {'name': 'John', 'age': 30};
///   final obj2 = {'name': 'John', 'age': 30};
///   print(obj1.deepEqual(obj2)); // true
/// }
/// ```
library;
export 'src/list_extensions.dart';
export 'src/object_extensions.dart'; 