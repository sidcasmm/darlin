import 'package:darlin/darlin.dart';

/// Main example demonstrating Kotlin-like utilities
/// 
/// For Future/Async utilities examples, see: future_utilities_example.dart
void main() {
  print('=== Kotlin-like Utils Example ===\n');

  // String null safety checks
  print('1. String Null Safety Checks:');
  print('-----------------------------');

  String? nullString;
  String? emptyString = '';
  String? blankString = '   ';
  String? normalString = 'Hello, World!';
  String? stringWithSpaces = '  Hello  ';

  print('nullString.isNullOrEmpty: ${nullString.isNullOrEmpty}'); // true
  print('nullString.isNullOrBlank: ${nullString.isNullOrBlank}'); // true
  print('emptyString.isNullOrEmpty: ${emptyString.isNullOrEmpty}'); // true
  print('emptyString.isNullOrBlank: ${emptyString.isNullOrBlank}'); // true
  print('blankString.isNullOrEmpty: ${blankString.isNullOrEmpty}'); // false
  print('blankString.isNullOrBlank: ${blankString.isNullOrBlank}'); // true
  print('normalString.isNullOrEmpty: ${normalString.isNullOrEmpty}'); // false
  print('normalString.isNullOrBlank: ${normalString.isNullOrBlank}'); // false
  print(
    'stringWithSpaces.isNullOrEmpty: ${stringWithSpaces.isNullOrEmpty}',
  ); // false
  print(
    'stringWithSpaces.isNullOrBlank: ${stringWithSpaces.isNullOrBlank}',
  ); // false

  print('\nOpposite checks:');
  print('nullString.isNotNullOrEmpty: ${nullString.isNotNullOrEmpty}'); // false
  print('nullString.isNotNullOrBlank: ${nullString.isNotNullOrBlank}'); // false
  print(
    'normalString.isNotNullOrEmpty: ${normalString.isNotNullOrEmpty}',
  ); // true
  print(
    'normalString.isNotNullOrBlank: ${normalString.isNotNullOrBlank}',
  ); // true

  // Additional String Utilities
  print('\n2. Additional String Utilities:');
  print('--------------------------------');

  final testString = 'hello world';
  final numericString = '12345';
  final emailString = 'user@example.com';
  final longString = 'This is a very long string that needs to be truncated';

  print('Original string: $testString');
  print('Reversed: ${testString.reversed}'); // dlrow olleh
  print('Capitalized: ${testString.capitalize()}'); // Hello world
  print('Is numeric: ${numericString.isNumeric}'); // true
  print('Is email: ${emailString.isEmail}'); // true
  print('Without whitespaces: ${testString.removeWhitespaces()}'); // helloworld
  print('Limited to 10 chars: ${longString.limit(10)}'); // This is a...

  // Test edge cases
  print('\nEdge cases:');
  print('Empty string reversed: ${''.reversed}'); // ''
  print('Empty string capitalized: ${''.capitalize()}'); // ''
  print('Empty string is numeric: ${''.isNumeric}'); // false
  print('Empty string is email: ${''.isEmail}'); // false
  print('Empty string remove whitespaces: ${''.removeWhitespaces()}'); // ''
  print('Empty string limit: ${''.limit(5)}'); // ''

  // Scope functions
  print('\n3. Scope Functions:');
  print('------------------');

  // let function
  print('\nlet() function:');
  String? nullableString = 'hello world';
  final upperCaseResult = nullableString.let((it) => it.toUpperCase());
  print('Original: $nullableString');
  print('After let(): $upperCaseResult');

  String? nullString2;
  final nullResult = nullString2.let((it) => it.toUpperCase());
  print('Null string let() result: $nullResult');

  // also function
  print('\nalso() function:');
  final numbers = <int>[1, 2, 3];
  final result = numbers.also((it) {
    print('Processing list with ${it.length} items');
    it.add(4);
  });
  print('Original list: $numbers');
  print('Result from also(): $result');

  // apply function
  print('\napply() function:');
  final person = Person('John', 25);
  final configuredPerson = person.apply((it) {
    it.name = 'Jane';
    it.age = 30;
    print('Configuring person: ${it.name}');
  });
  print(
    'Configured person: ${configuredPerson?.name}, ${configuredPerson?.age}',
  );

  // Real-world example
  print('\n4. Real-world Example:');
  print('----------------------');

  final userInput = '  user@example.com  ';

  // Using string checks and scope functions together
  final processedEmail = userInput
      .let((it) => it.trim())
      ?.also((it) => print('Processing email: $it'))
      ?.let((it) => it.toLowerCase())
      ?.apply((it) => print('Final email: $it'));

  print('Final result: $processedEmail');

  // Null-safe processing
  String? nullableEmail;
  final safeResult = nullableEmail
      ?.let((it) => it.trim())
      ?.also((it) => print('This won\'t print for null email'))
      ?.let((it) => it.toLowerCase());

  print('Safe result for null email: $safeResult');

  // List Extensions
  print('\n5. List Extensions:');
  print('-------------------');

  // List null safety checks
  List<int>? nullList;
  List<int>? emptyList = [];
  List<int>? normalList = [1, 2, 3, 4, 5];

  print('nullList.isNullOrEmpty: ${nullList.isNullOrEmpty}'); // true
  print('emptyList.isNullOrEmpty: ${emptyList.isNullOrEmpty}'); // true
  print('normalList.isNullOrEmpty: ${normalList.isNullOrEmpty}'); // false
  print('normalList.isNotNullOrEmpty: ${normalList.isNotNullOrEmpty}'); // true

  // List utilities
  final numberList = [1, 2, 3, 4, 5];
  final mixedList = [1, null, 2, null, 3];
  final stringNumbers = ['1', '2', 'abc', '3'];
  final people = [
    Person('John', 25),
    Person('Jane', 25),
    Person('Bob', 30),
    Person('Alice', 25),
  ];

  print('\nList utilities:');
  print('First element: ${numberList.firstOrNull()}'); // 1
  print('Last element: ${numberList.lastOrNull()}'); // 5
  print('Single element (if exists): ${[42].singleOrNull()}'); // 42
  print('Single element (multiple): ${numberList.singleOrNull()}'); // null

  // Filtering and transformation
  final evenNumbers = numberList.takeIf((n) => n % 2 == 0);
  final oddNumbers = numberList.takeUnless((n) => n % 2 == 0);
  final nonNullElements = mixedList.filterNotNull();
  final parsedNumbers = stringNumbers.mapNotNull((s) => int.tryParse(s));
  final distinctByAge = people.distinctBy((p) => p.age);

  print('Even numbers: $evenNumbers'); // [2, 4]
  print('Odd numbers: $oddNumbers'); // [1, 3, 5]
  print('Non-null elements: $nonNullElements'); // [1, 2, 3]
  print('Parsed numbers: $parsedNumbers'); // [1, 2, 3]
  print(
    'Distinct by age: ${distinctByAge.map((p) => '${p.name}(${p.age})')}',
  ); // [John(25), Bob(30)]

  // Nullable Extensions
  print('\n6. Nullable Extensions:');
  print('----------------------');

  // Nullable checks
  String? nullableValue;
  String? nonNullValue = 'hello';
  int? nullableNumber = 42;
  List<int>? nullableList = [1, 2, 3];


  print('nullableValue.isNull: ${nullableValue.isNull}'); // true
  print('nullableValue.isNotNull: ${nullableValue.isNotNull}'); // false
  print('nonNullValue.isNull: ${nonNullValue.isNull}'); // false
  print('nonNullValue.isNotNull: ${nonNullValue.isNotNull}'); // true

  // ifNull examples
  final result1 = nullableValue.ifNull('default value');
  final result2 = nonNullValue.ifNull('default value');
  final result3 = nullableNumber.ifNull(0);

  print('ifNull with null: $result1'); // 'default value'
  print('ifNull with non-null: $result2'); // 'hello'
  print('ifNull with int: $result3'); // 42

  // ifNotNull examples
  print('\nifNotNull examples:');
  nullableValue.ifNotNull((value) => print('This won\'t print'));
  nonNullValue.ifNotNull(
    (value) => print('Value is: $value'),
  ); // Value is: hello
  nullableNumber.ifNotNull(
    (value) => print('Number is: $value'),
  ); // Number is: 42
  nullableList.ifNotNull(
    (list) => print('List has ${list.length} items'),
  ); // List has 3 items

  // Real-world nullable example
  print('\nReal-world nullable example:');
  final nullableUserInput =
      getUserInput(); // Simulated function that might return null
  final processedInput = nullableUserInput.ifNull('default').toUpperCase();
  print('Processed input: $processedInput'); // Processed input: DEFAULT

  nullableUserInput.ifNotNull((input) {
    print('Processing user input: $input');
    // Additional processing logic here
  });

  // Boolean Extensions
  print('\n7. Boolean Extensions:');
  print('----------------------');

  // Boolean toggle
  bool flag = true;
  print('Original flag: $flag');
  flag = flag.toggle();
  print('After toggle: $flag'); // false
  flag = flag.toggle();
  print('After second toggle: $flag'); // true

  // Nullable boolean operations
  bool? a = true;
  bool? b = false;
  bool? c;

  print('\nBoolean operations:');
  print('a = $a, b = $b, c = $c');

  // XOR operations
  print('a.xor(b): ${a.xor(b)}'); // true
  print('a.xor(a): ${a.xor(a)}'); // false
  print('b.xor(b): ${b.xor(b)}'); // false
  print('a.xor(c): ${a.xor(c)}'); // null
  print('c.xor(a): ${c.xor(a)}'); // null

  // AND operations
  print('\nAND operations:');
  print('a.and(b): ${a.and(b)}'); // false
  print('a.and(a): ${a.and(a)}'); // true
  print('b.and(b): ${b.and(b)}'); // false
  print('a.and(c): ${a.and(c)}'); // null
  print('c.and(a): ${c.and(a)}'); // null

  // OR operations
  print('\nOR operations:');
  print('a.or(b): ${a.or(b)}'); // true
  print('a.or(a): ${a.or(a)}'); // true
  print('b.or(b): ${b.or(b)}'); // false
  print('a.or(c): ${a.or(c)}'); // null
  print('c.or(a): ${c.or(a)}'); // null

  // Complex boolean expressions
  print('\nComplex boolean expressions:');
  final complexResult = a.and(b).or(a);
  print('a.and(b).or(a): $complexResult'); // true

  final chainedResult = flag.toggle().and(a);
  print('flag.toggle().and(a): $chainedResult'); // false

  // Real-world boolean example
  print('\nReal-world boolean example:');
  bool? isUserLoggedIn = true;
  bool? hasPermission = false;
  bool? isAdmin;

  final canAccess = isUserLoggedIn.and(hasPermission.or(isAdmin));
  print('User logged in: $isUserLoggedIn');
  print('Has permission: $hasPermission');
  print('Is admin: $isAdmin');
  print('Can access: $canAccess'); // null (because isAdmin is null)
}

/// Simulated function that might return null
String? getUserInput() {
  // Simulate some condition where input might be null
  return null;
}

/// Simple Person class for demonstration
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  @override
  String toString() => 'Person(name: $name, age: $age)';
}
