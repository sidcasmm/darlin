# Dart Utilities - Kotlin-like Extensions

A Dart package that provides Kotlin-like utilities and extensions, bringing familiar null safety checks and scope functions to Dart projects.

## Features

- **String Null Safety Checks**: `isNullOrEmpty`, `isNullOrBlank`, `isNotNullOrEmpty`, `isNotNullOrBlank`
- **String Utilities**: `reversed`, `capitalize()`, `isNumeric`, `isEmail`, `removeWhitespaces()`, `limit()`
- **List Null Safety Checks**: `isNullOrEmpty`, `isNotNullOrEmpty`
- **List Utilities**: `firstOrNull()`, `lastOrNull()`, `singleOrNull()`, `distinctBy()`, `takeIf()`, `takeUnless()`, `filterNotNull()`, `mapNotNull()`
- **Nullable Utilities**: `isNull`, `isNotNull`, `ifNull()`, `ifNotNull()`
- **Boolean Utilities**: `toggle()`, `xor()`, `and()`, `or()`
- **Object Utilities**: `deepCopy()`, `deepEqual()`, `copyWith()`, `copyOnly()`, `copyWithout()`, `transform()`, `merge()`
- **Scope Functions**: `let`, `also`, `apply` for any object type
- **Future/Async Utilities**: `thenIfNotNull`, `thenIf`, `onErrorReturn`, `finally`, `thenNullable`
- **Null-safe**: All functions are designed with Dart's null safety in mind
- **Type-safe**: Full type safety with generics support
- **Lightweight**: Minimal dependencies, focused functionality

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  darlin: ^1.0.0
```

### Import Options

#### Full Package Import
Import all functionality at once:

```dart
import 'package:darlin/darlin.dart';
```

#### Modular Imports
Import only the functionality you need for better performance and smaller bundle size:

```dart
// Most commonly used utilities
import 'package:darlin/core.dart';

// Specific utility modules
import 'package:darlin/string_utils.dart';   // String utilities only
import 'package:darlin/scope_functions.dart'; // Scope functions only
import 'package:darlin/list_utils.dart';     // List utilities only
import 'package:darlin/collections.dart';    // List + Object utilities
import 'package:darlin/nullable_utils.dart'; // Nullable utilities only
import 'package:darlin/boolean_utils.dart';  // Boolean utilities only
import 'package:darlin/future_utils.dart';   // Future utilities only
import 'package:darlin/object_utils.dart';   // Object utilities only
```

**Benefits of modular imports:**
- **Smaller bundle size**: Only include what you need
- **Better tree-shaking**: Dart analyzer can optimize unused code
- **Clearer dependencies**: Explicit about which utilities you're using
- **Faster compilation**: Less code to process

## Usage

### String Null Safety Checks

```dart
String? nullableString = null;
String? emptyString = '';
String? blankString = '   ';
String? normalString = 'Hello, World!';

// Check for null or empty
print(nullableString.isNullOrEmpty); // true
print(emptyString.isNullOrEmpty); // true
print(normalString.isNullOrEmpty); // false

// Check for null or blank (whitespace only)
print(nullableString.isNullOrBlank); // true
print(blankString.isNullOrBlank); // true
print(normalString.isNullOrBlank); // false

// Opposite checks
  print(normalString.isNotNullOrEmpty); // true
  print(normalString.isNotNullOrBlank); // true
  ```

### String Utilities

```dart
final testString = 'hello world';
final numericString = '12345';
final emailString = 'user@example.com';

// String manipulation
print(testString.reversed); // 'dlrow olleh'
print(testString.capitalize()); // 'Hello world'
print(testString.removeWhitespaces()); // 'helloworld'

// Validation
print(numericString.isNumeric); // true
print(emailString.isEmail); // true

// Truncation
final longString = 'This is a very long string';
  print(longString.limit(10)); // 'This is a...'
  ```

### List Null Safety Checks

```dart
List<int>? nullableList = null;
List<int>? emptyList = [];
List<int>? normalList = [1, 2, 3];

print(nullableList.isNullOrEmpty); // true
print(emptyList.isNullOrEmpty); // true
print(normalList.isNullOrEmpty); // false
print(normalList.isNotNullOrEmpty); // true
```

### List Utilities

```dart
final numbers = [1, 2, 3, 4, 5];
final mixedList = [1, null, 2, null, 3];
final stringNumbers = ['1', '2', 'abc', '3'];

// Safe element access
print(numbers.firstOrNull()); // 1
print(numbers.lastOrNull()); // 5
print([42].singleOrNull()); // 42

// Filtering and transformation
final evenNumbers = numbers.takeIf((n) => n % 2 == 0); // [2, 4]
final oddNumbers = numbers.takeUnless((n) => n % 2 == 0); // [1, 3, 5]
final nonNullElements = mixedList.filterNotNull(); // [1, 2, 3]
final parsedNumbers = stringNumbers.mapNotNull((s) => int.tryParse(s)); // [1, 2, 3]

// Distinct by property
final people = [Person('John', 25), Person('Jane', 25), Person('Bob', 30)];
final distinctByAge = people.distinctBy((p) => p.age); // [John(25), Bob(30)]
```

### Nullable Utilities

```dart
String? nullableValue = null;
String? nonNullValue = 'hello';
int? nullableNumber = 42;

// Null checks
print(nullableValue.isNull); // true
print(nonNullValue.isNotNull); // true

// Default values
final result1 = nullableValue.ifNull('default'); // 'default'
final result2 = nonNullValue.ifNull('default'); // 'hello'

// Conditional execution
nullableValue.ifNotNull((value) => print('This won\'t print'));
nonNullValue.ifNotNull((value) => print('Value is: $value')); // Value is: hello
nullableNumber.ifNotNull((value) => print('Number is: $value')); // Number is: 42
```

### Boolean Utilities

```dart
// Toggle boolean value
bool flag = true;
flag = flag.toggle(); // false
flag = flag.toggle(); // true

// Nullable boolean operations
bool? a = true;
bool? b = false;
bool? c = null;

// XOR operations
print(a.xor(b)); // true
print(a.xor(a)); // false
print(a.xor(c)); // null

// AND operations
print(a.and(b)); // false
print(a.and(a)); // true
print(a.and(c)); // null

// OR operations
print(a.or(b)); // true
print(b.or(b)); // false
print(a.or(c)); // null

// Complex expressions
final result = a.and(b).or(a); // true
```

### Object Utilities

```dart
final person = {'name': 'John', 'age': 30, 'city': 'NYC'};
final person2 = {'name': 'John', 'age': 30, 'city': 'NYC'};

// Deep copying
final copy = person.deepCopy();
copy['age'] = 31;
print(person['age']); // 30 (unchanged)
print(copy['age']); // 31

// Deep equality comparison
print(person.deepEqual(person2)); // true
print(person.deepEqualRecursive(person2)); // true

// Object manipulation
final updated = person.copyWith({'age': 31, 'city': 'LA'});
// Result: {'name': 'John', 'age': 31, 'city': 'LA'}

final withoutAge = person.copyWithout(['age']);
// Result: {'name': 'John', 'city': 'NYC'}

final onlyBasic = person.copyOnly(['name', 'age']);
// Result: {'name': 'John', 'age': 30}

// Object transformation
final transformed = person.transform((key, value) {
  if (key == 'name') return (value as String).toUpperCase();
  if (key == 'age') return (value as int) + 1;
  return value;
});
// Result: {'name': 'JOHN', 'age': 31, 'city': 'NYC'}

// Object merging
final additional = {'country': 'USA', 'age': 31};
final merged = person.merge(additional);
// Result: {'name': 'John', 'age': 31, 'city': 'NYC', 'country': 'USA'}

// Partial equality
print(person.partialEqual(person2, ['name', 'age'])); // true
```

### Scope Functions

#### `let` - Transform and return result

```dart
String? nullableString = 'hello world';
final upperCaseResult = nullableString.let((it) => it.toUpperCase());
print(upperCaseResult); // "HELLO WORLD"

// Returns null if the object is null
String? nullString = null;
final result = nullString.let((it) => it.toUpperCase());
print(result); // null
```

#### `also` - Side effects, return original object

```dart
final numbers = <int>[1, 2, 3];
final result = numbers.also((it) {
  print('Processing list with ${it.length} items');
  it.add(4);
});
print(result); // [1, 2, 3, 4]
```

#### `apply` - Configure object, return original object

```dart
class Person {
  String name;
  int age;
  Person(this.name, this.age);
}

final person = Person('John', 25);
final configuredPerson = person.apply((it) {
  it.name = 'Jane';
  it.age = 30;
});
print('${configuredPerson.name}, ${configuredPerson.age}'); // "Jane, 30"
```

### Future/Async Utilities

```dart
// Conditional execution based on future results
Future<bool> isUserLoggedIn() async => true;
Future<String?> fetchUserProfile() async => 'John Doe';

await isUserLoggedIn()
  .thenIf((isLoggedIn) => isLoggedIn, 
          (value) => fetchUserProfile())
  .thenIfNotNull((profile) => print('Hello $profile'));

// Error handling with default values
Future<String> fetchData() async => throw Exception('Network error');
final result = await fetchData().onErrorReturn('default data');
// result will be 'default data' instead of throwing

// Cleanup operations
await fetchData()
  .onFinally(() => print('Operation completed'));
```

### Real-world Example

```dart
// Process user input with null safety
String? userInput = '  user@example.com  ';

final processedEmail = userInput
    .let((it) => it.trim())
    ?.also((it) => print('Processing email: $it'))
    ?.let((it) => it.toLowerCase())
    ?.apply((it) => print('Final email: $it'));

print(processedEmail); // "user@example.com"
```

## API Reference

### StringChecks Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `isNullOrEmpty` | Returns true if string is null or empty | `bool` |
| `isNullOrBlank` | Returns true if string is null or contains only whitespace | `bool` |
| `isNotNullOrEmpty` | Returns true if string is not null and not empty | `bool` |
| `isNotNullOrBlank` | Returns true if string is not null and contains non-whitespace characters | `bool` |

### StringUtils Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `reversed` | Returns the reversed string | `String` |
| `capitalize()` | Capitalizes the first character of the string | `String` |
| `isNumeric` | Returns true if string contains only numeric characters | `bool` |
| `isEmail` | Returns true if string is a valid email address | `bool` |
| `removeWhitespaces()` | Removes all whitespace characters from the string | `String` |
| `limit(int maxLength)` | Safely truncates string to specified length with '...' | `String` |

### ListChecks Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `isNullOrEmpty` | Returns true if list is null or empty | `bool` |
| `isNotNullOrEmpty` | Returns true if list is not null and not empty | `bool` |

### ListUtils Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `firstOrNull()` | Returns the first element or null if list is empty | `T?` |
| `lastOrNull()` | Returns the last element or null if list is empty | `T?` |
| `singleOrNull()` | Returns the single element or null if list is empty or has multiple elements | `T?` |
| `distinctBy<K>(K Function(T) selector)` | Returns list with distinct elements based on selector function | `List<T>` |
| `takeIf(bool Function(T) predicate)` | Returns elements that satisfy the predicate | `List<T>` |
| `takeUnless(bool Function(T) predicate)` | Returns elements that do not satisfy the predicate | `List<T>` |
| `filterNotNull()` | Returns list containing all non-null elements | `List<T>` |
| `mapNotNull<R>(R? Function(T) transform)` | Returns list containing only non-null transformed elements | `List<R>` |

### NullableUtils Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `isNull` | Returns true if the object is null | `bool` |
| `isNotNull` | Returns true if the object is not null | `bool` |
| `ifNull(T fallback)` | Returns the object if not null, otherwise returns fallback | `T` |
| `ifNotNull(void Function(T) action)` | Executes the function if the object is not null | `void` |

### BooleanUtils Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `toggle()` | Returns the opposite of the current boolean value | `bool` |

### NullableBooleanUtils Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `xor(bool? other)` | Performs XOR operation, returns null if either operand is null | `bool?` |
| `and(bool? other)` | Performs AND operation, returns null if either operand is null | `bool?` |
| `or(bool? other)` | Performs OR operation, returns null if either operand is null | `bool?` |

### ObjectUtils Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `deepCopy()` | Creates a deep copy using JSON serialization | `Object` |
| `deepCopyRecursive()` | Creates a truly deep copy by recursively copying nested structures | `Object` |
| `deepEqual(Object? other)` | Performs deep equality comparison using JSON representation | `bool` |
| `deepEqualRecursive(Object? other)` | Performs recursive deep equality comparison | `bool` |
| `copyWith(Map<String, dynamic> updates)` | Creates a copy with specified fields updated | `Object` |
| `copyWithNull(Map<String, dynamic?> updates)` | Creates a copy with specified fields updated, preserving null values | `Object` |
| `copyOnly(List<String> fields)` | Creates a copy containing only specified fields | `Object` |
| `copyWithout(List<String> fields)` | Creates a copy excluding specified fields | `Object` |
| `shallowEqual(Object? other)` | Performs shallow equality comparison | `bool` |
| `isDeepNull` | Checks if object is deeply equal to null | `bool` |
| `deepHashCode` | Returns hash code based on JSON representation | `int` |
| `deepHashCodeRecursive` | Returns hash code based on recursive deep comparison | `int` |
| `partialEqual(Object? other, List<String> fields)` | Compares only specified fields | `bool` |
| `transform(dynamic Function(String, dynamic) transformer)` | Transforms object by applying function to each field | `Object` |
| `merge(Object? other, {Function? conflictResolver})` | Merges with another object, with optional conflict resolution | `Object` |

### ScopeFunctions Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `let<R>(R Function(T it) block)` | Executes function if not null, returns result | `R?` |
| `also(void Function(T it) block)` | Executes function if not null, returns original object | `T?` |
| `apply(void Function(T it) block)` | Executes function if not null, returns original object | `T?` |

### FutureUtils Extension

| Method | Description | Returns |
|--------|-------------|---------|
| `thenIfNotNull<R>(FutureOr<R> Function(T) onValue)` | Executes function only if result is not null | `Future<R?>` |
| `thenIf<R>(bool Function(T) condition, FutureOr<R> Function(T) onConditionMet)` | Executes function only if condition is true | `Future<R?>` |
| `onErrorReturn(T defaultValue)` | Returns default value on error | `Future<T>` |
| `onErrorReturnWith(T defaultValue, void Function(Object, StackTrace?) onError)` | Returns default value and executes error handler | `Future<T>` |
| `onFinally(FutureOr<void> Function() action)` | Executes action regardless of success/failure | `Future<T>` |
| `thenNullable<R>(R? Function(T) transform)` | Transforms result with nullable function | `Future<R?>` |

## Testing

Run the tests to verify functionality:

```bash
dart test
```

## Example

See the complete example in `example/kotlin_like_utils_example.dart`:

```bash
dart run example/kotlin_like_utils_example.dart
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
