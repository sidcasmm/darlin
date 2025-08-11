import 'package:test/test.dart';
import 'package:darlin/darlin.dart';

void main() {
  group('NullableUtils extension', () {
    group('isNull', () {
      test('should return true for null values', () {
        String? nullableString;
        int? nullableInt;
        List<int>? nullableList;

        expect(nullableString.isNull, isTrue);
        expect(nullableInt.isNull, isTrue);
        expect(nullableList.isNull, isTrue);
      });

      test('should return false for non-null values', () {
        String? nullableString = 'hello';
        int? nullableInt = 42;
        List<int>? nullableList = [1, 2, 3];

        expect(nullableString.isNull, isFalse);
        expect(nullableInt.isNull, isFalse);
        expect(nullableList.isNull, isFalse);
      });

      test('should work with custom objects', () {
        Person? nullablePerson;
        expect(nullablePerson.isNull, isTrue);

        nullablePerson = Person('John', 30);
        expect(nullablePerson.isNull, isFalse);
      });
    });

    group('isNotNull', () {
      test('should return false for null values', () {
        String? nullableString;
        int? nullableInt;
        List<int>? nullableList;

        expect(nullableString.isNotNull, isFalse);
        expect(nullableInt.isNotNull, isFalse);
        expect(nullableList.isNotNull, isFalse);
      });

      test('should return true for non-null values', () {
        String? nullableString = 'hello';
        int? nullableInt = 42;
        List<int>? nullableList = [1, 2, 3];

        expect(nullableString.isNotNull, isTrue);
        expect(nullableInt.isNotNull, isTrue);
        expect(nullableList.isNotNull, isTrue);
      });

      test('should work with custom objects', () {
        Person? nullablePerson;
        expect(nullablePerson.isNotNull, isFalse);

        nullablePerson = Person('John', 30);
        expect(nullablePerson.isNotNull, isTrue);
      });
    });

    group('ifNull', () {
      test('should return fallback value when object is null', () {
        String? nullableString;
        final result = nullableString.ifNull('default');
        expect(result, equals('default'));
      });

      test('should return original value when object is not null', () {
        String? nullableString = 'hello';
        final result = nullableString.ifNull('default');
        expect(result, equals('hello'));
      });

      test('should work with different types', () {
        int? nullableInt;
        final result = nullableInt.ifNull(42);
        expect(result, equals(42));

        nullableInt = 100;
        final result2 = nullableInt.ifNull(42);
        expect(result2, equals(100));
      });

      test('should work with custom objects', () {
        Person? nullablePerson;
        final fallbackPerson = Person('Default', 0);
        final result = nullablePerson.ifNull(fallbackPerson);
        expect(result, equals(fallbackPerson));

        nullablePerson = Person('John', 30);
        final result2 = nullablePerson.ifNull(fallbackPerson);
        expect(result2, equals(nullablePerson));
      });

      test('should work with empty string', () {
        String? nullableString = '';
        final result = nullableString.ifNull('default');
        expect(result, equals('')); // Empty string is not null
      });

      test('should work with zero values', () {
        int? nullableInt = 0;
        final result = nullableInt.ifNull(42);
        expect(result, equals(0)); // Zero is not null
      });
    });

    group('ifNotNull', () {
      test('should execute action when object is not null', () {
        String? nullableString = 'hello';
        String? capturedValue;

        nullableString.ifNotNull((value) => capturedValue = value);

        expect(capturedValue, equals('hello'));
      });

      test('should not execute action when object is null', () {
        String? nullableString;
        bool actionExecuted = false;

        nullableString.ifNotNull((value) => actionExecuted = true);

        expect(actionExecuted, isFalse);
      });

      test('should work with different types', () {
        int? nullableInt = 42;
        int? capturedValue;

        nullableInt.ifNotNull((value) => capturedValue = value);

        expect(capturedValue, equals(42));
      });

      test('should work with custom objects', () {
        Person? nullablePerson = Person('John', 30);
        String? capturedName;

        nullablePerson.ifNotNull((person) => capturedName = person.name);

        expect(capturedName, equals('John'));
      });

      test('should work with lists', () {
        List<int>? nullableList = [1, 2, 3];
        int? capturedLength;

        nullableList.ifNotNull((list) => capturedLength = list.length);

        expect(capturedLength, equals(3));
      });

      test('should handle multiple actions', () {
        String? nullableString = 'hello';
        String? capturedValue1;
        String? capturedValue2;

        nullableString.ifNotNull((value) {
          capturedValue1 = value;
          capturedValue2 = value.toUpperCase();
        });

        expect(capturedValue1, equals('hello'));
        expect(capturedValue2, equals('HELLO'));
      });

      test('should not execute action for null with complex logic', () {
        String? nullableString;
        bool actionExecuted = false;

        nullableString.ifNotNull((value) {
          actionExecuted = true;
          print('This should not print');
        });

        expect(actionExecuted, isFalse);
      });
    });
  });
}

/// Simple Person class for nullable extension tests
class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age;

  @override
  int get hashCode => name.hashCode ^ age.hashCode;

  @override
  String toString() => 'Person(name: $name, age: $age)';
}
