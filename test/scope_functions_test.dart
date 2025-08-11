import 'package:test/test.dart';
import 'package:darlin/darlin.dart';

void main() {
  group('ScopeFunctions extension', () {
    group('let', () {
      test('should return null when object is null', () {
        String? str;
        final result = str.let((it) => it.toUpperCase());
        expect(result, isNull);
      });

      test(
        'should apply function and return result when object is not null',
        () {
          String? str = 'hello';
          final result = str.let((it) => it.toUpperCase());
          expect(result, equals('HELLO'));
        },
      );

      test('should work with different types', () {
        int? number = 42;
        final result = number.let((it) => it * 2);
        expect(result, equals(84));
      });

      test('should work with custom objects', () {
        final person = Person('John', 30);
        Person? nullablePerson = person;
        final result = nullablePerson.let(
          (it) => '${it.name} is ${it.age} years old',
        );
        expect(result, equals('John is 30 years old'));
      });
    });

    group('also', () {
      test('should return null when object is null', () {
        String? str;
        final result = str.also((it) {});
        expect(result, isNull);
      });

      test('should execute side effect and return original object', () {
        String? str = 'hello';
        String? capturedValue;
        final result = str.also((it) => capturedValue = it);

        expect(result, equals('hello'));
        expect(capturedValue, equals('hello'));
      });

      test('should work with different types', () {
        int? number = 42;
        int? capturedValue;
        final result = number.also((it) => capturedValue = it);

        expect(result, equals(42));
        expect(capturedValue, equals(42));
      });

      test('should work with custom objects', () {
        final person = Person('John', 30);
        Person? nullablePerson = person;
        String? capturedName;
        final result = nullablePerson.also((it) => capturedName = it.name);

        expect(result, equals(person));
        expect(capturedName, equals('John'));
      });
    });

    group('apply', () {
      test('should return null when object is null', () {
        String? str;
        final result = str.apply((it) {});
        expect(result, isNull);
      });

      test('should execute function and return original object', () {
        final person = Person('John', 30);
        Person? nullablePerson = person;

        final result = nullablePerson.apply((it) {
          it.name = 'Jane';
          it.age = 25;
        });

        expect(result, equals(person));
        expect(person.name, equals('Jane'));
        expect(person.age, equals(25));
      });

      test('should work with mutable objects', () {
        final list = <int>[1, 2, 3];
        List<int>? nullableList = list;

        final result = nullableList.apply((it) {
          it.add(4);
          it.add(5);
        });

        expect(result, equals(list));
        expect(list, equals([1, 2, 3, 4, 5]));
      });

      test('should work with different types', () {
        final map = <String, int>{};
        Map<String, int>? nullableMap = map;

        final result = nullableMap.apply((it) {
          it['a'] = 1;
          it['b'] = 2;
        });

        expect(result, equals(map));
        expect(map, equals({'a': 1, 'b': 2}));
      });
    });
  });
}

/// Simple test class for scope function tests
class Person {
  String name;
  int age;

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
