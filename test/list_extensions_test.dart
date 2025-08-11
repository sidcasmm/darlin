import 'package:test/test.dart';
import 'package:darlin/darlin.dart';

void main() {
  group('ListChecks extension', () {
    group('isNullOrEmpty', () {
      test('should return true for null list', () {
        List<int>? list;
        expect(list.isNullOrEmpty, isTrue);
      });

      test('should return true for empty list', () {
        List<int>? list = [];
        expect(list.isNullOrEmpty, isTrue);
      });

      test('should return false for non-empty list', () {
        List<int>? list = [1, 2, 3];
        expect(list.isNullOrEmpty, isFalse);
      });
    });

    group('isNotNullOrEmpty', () {
      test('should return false for null list', () {
        List<int>? list;
        expect(list.isNotNullOrEmpty, isFalse);
      });

      test('should return false for empty list', () {
        List<int>? list = [];
        expect(list.isNotNullOrEmpty, isFalse);
      });

      test('should return true for non-empty list', () {
        List<int>? list = [1, 2, 3];
        expect(list.isNotNullOrEmpty, isTrue);
      });
    });
  });

  group('ListUtils extension', () {
    group('firstOrNull', () {
      test('should return first element for non-empty list', () {
        final list = [1, 2, 3];
        expect(list.firstOrNull(), equals(1));
      });

      test('should return null for empty list', () {
        final list = <int>[];
        expect(list.firstOrNull(), isNull);
      });

      test('should return element for single element list', () {
        final list = [42];
        expect(list.firstOrNull(), equals(42));
      });
    });

    group('lastOrNull', () {
      test('should return last element for non-empty list', () {
        final list = [1, 2, 3];
        expect(list.lastOrNull(), equals(3));
      });

      test('should return null for empty list', () {
        final list = <int>[];
        expect(list.lastOrNull(), isNull);
      });

      test('should return element for single element list', () {
        final list = [42];
        expect(list.lastOrNull(), equals(42));
      });
    });

    group('singleOrNull', () {
      test('should return element for single element list', () {
        final list = [42];
        expect(list.singleOrNull(), equals(42));
      });

      test('should return null for empty list', () {
        final list = <int>[];
        expect(list.singleOrNull(), isNull);
      });

      test('should return null for list with multiple elements', () {
        final list = [1, 2, 3];
        expect(list.singleOrNull(), isNull);
      });
    });

    group('distinctBy', () {
      test('should return distinct elements based on selector', () {
        final people = [
          Person('John', 25),
          Person('Jane', 25),
          Person('Bob', 30),
          Person('Alice', 25),
        ];

        final distinctByAge = people.distinctBy((p) => p.age);
        expect(distinctByAge.length, equals(2));
        expect(distinctByAge.map((p) => p.age).toSet(), equals({25, 30}));
      });

      test('should return original list if all elements are distinct', () {
        final list = [1, 2, 3, 4, 5];
        final distinct = list.distinctBy((n) => n);
        expect(distinct, equals(list));
      });

      test('should handle empty list', () {
        final list = <int>[];
        final distinct = list.distinctBy((n) => n);
        expect(distinct, equals([]));
      });

      test('should handle single element list', () {
        final list = [42];
        final distinct = list.distinctBy((n) => n);
        expect(distinct, equals([42]));
      });
    });

    group('takeIf', () {
      test('should return elements that satisfy predicate', () {
        final list = [1, 2, 3, 4, 5];
        final result = list.takeIf((n) => n > 2);
        expect(result, equals([3, 4, 5]));
      });

      test('should return empty list if no elements satisfy predicate', () {
        final list = [1, 2, 3];
        final result = list.takeIf((n) => n > 10);
        expect(result, equals([]));
      });

      test('should return all elements if all satisfy predicate', () {
        final list = [1, 2, 3];
        final result = list.takeIf((n) => n > 0);
        expect(result, equals([1, 2, 3]));
      });

      test('should handle empty list', () {
        final list = <int>[];
        final result = list.takeIf((n) => n > 0);
        expect(result, equals([]));
      });
    });

    group('takeUnless', () {
      test('should return elements that do not satisfy predicate', () {
        final list = [1, 2, 3, 4, 5];
        final result = list.takeUnless((n) => n > 2);
        expect(result, equals([1, 2]));
      });

      test('should return empty list if all elements satisfy predicate', () {
        final list = [1, 2, 3];
        final result = list.takeUnless((n) => n > 0);
        expect(result, equals([]));
      });

      test('should return all elements if none satisfy predicate', () {
        final list = [1, 2, 3];
        final result = list.takeUnless((n) => n > 10);
        expect(result, equals([1, 2, 3]));
      });

      test('should handle empty list', () {
        final list = <int>[];
        final result = list.takeUnless((n) => n > 0);
        expect(result, equals([]));
      });
    });

    group('filterNotNull', () {
      test('should return non-null elements', () {
        final list = [1, null, 2, null, 3];
        final result = list.filterNotNull();
        expect(result, equals([1, 2, 3]));
      });

      test('should return empty list if all elements are null', () {
        final list = [null, null, null];
        final result = list.filterNotNull();
        expect(result, equals([]));
      });

      test('should return original list if no null elements', () {
        final list = [1, 2, 3];
        final result = list.filterNotNull();
        expect(result, equals([1, 2, 3]));
      });

      test('should handle empty list', () {
        final list = <int?>[];
        final result = list.filterNotNull();
        expect(result, equals([]));
      });
    });

    group('mapNotNull', () {
      test('should return non-null transformed elements', () {
        final list = ['1', '2', 'abc', '3'];
        final result = list.mapNotNull((s) => int.tryParse(s));
        expect(result, equals([1, 2, 3]));
      });

      test('should return empty list if all transformations return null', () {
        final list = ['abc', 'def', 'ghi'];
        final result = list.mapNotNull((s) => int.tryParse(s));
        expect(result, equals([]));
      });

      test('should return all transformed elements if none return null', () {
        final list = ['1', '2', '3'];
        final result = list.mapNotNull((s) => int.tryParse(s));
        expect(result, equals([1, 2, 3]));
      });

      test('should handle empty list', () {
        final list = <String>[];
        final result = list.mapNotNull((s) => int.tryParse(s));
        expect(result, equals([]));
      });

      test('should work with different types', () {
        final list = [1, 2, 3, 4, 5];
        final result = list.mapNotNull((n) => n % 2 == 0 ? 'even' : null);
        expect(result, equals(['even', 'even']));
      });
    });
  });
}

/// Simple Person class for list extension tests
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
