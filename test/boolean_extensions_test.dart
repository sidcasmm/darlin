import 'package:test/test.dart';
import 'package:darlin/darlin.dart';

void main() {
  group('BooleanUtils extension', () {
    group('toggle', () {
      test('should toggle true to false', () {
        bool flag = true;
        final result = flag.toggle();
        expect(result, isFalse);
      });

      test('should toggle false to true', () {
        bool flag = false;
        final result = flag.toggle();
        expect(result, isTrue);
      });

      test('should work with multiple toggles', () {
        bool flag = true;
        flag = flag.toggle(); // false
        flag = flag.toggle(); // true
        flag = flag.toggle(); // false
        expect(flag, isFalse);
      });

      test('should not modify original value', () {
        bool flag = true;
        flag.toggle();
        expect(flag, isTrue); // Original value unchanged
      });
    });
  });

  group('NullableBooleanUtils extension', () {
    group('xor', () {
      test('should return true for true xor false', () {
        bool? a = true;
        bool? b = false;
        expect(a.xor(b), isTrue);
      });

      test('should return true for false xor true', () {
        bool? a = false;
        bool? b = true;
        expect(a.xor(b), isTrue);
      });

      test('should return false for true xor true', () {
        bool? a = true;
        bool? b = true;
        expect(a.xor(b), isFalse);
      });

      test('should return false for false xor false', () {
        bool? a = false;
        bool? b = false;
        expect(a.xor(b), isFalse);
      });

      test('should return null when first operand is null', () {
        bool? a;
        bool? b = true;
        expect(a.xor(b), isNull);
      });

      test('should return null when second operand is null', () {
        bool? a = true;
        bool? b;
        expect(a.xor(b), isNull);
      });

      test('should return null when both operands are null', () {
        bool? a;
        bool? b;
        expect(a.xor(b), isNull);
      });
    });

    group('and', () {
      test('should return true for true and true', () {
        bool? a = true;
        bool? b = true;
        expect(a.and(b), isTrue);
      });

      test('should return false for true and false', () {
        bool? a = true;
        bool? b = false;
        expect(a.and(b), isFalse);
      });

      test('should return false for false and true', () {
        bool? a = false;
        bool? b = true;
        expect(a.and(b), isFalse);
      });

      test('should return false for false and false', () {
        bool? a = false;
        bool? b = false;
        expect(a.and(b), isFalse);
      });

      test('should return null when first operand is null', () {
        bool? a;
        bool? b = true;
        expect(a.and(b), isNull);
      });

      test('should return null when second operand is null', () {
        bool? a = true;
        bool? b;
        expect(a.and(b), isNull);
      });

      test('should return null when both operands are null', () {
        bool? a;
        bool? b;
        expect(a.and(b), isNull);
      });
    });

    group('or', () {
      test('should return true for true or true', () {
        bool? a = true;
        bool? b = true;
        expect(a.or(b), isTrue);
      });

      test('should return true for true or false', () {
        bool? a = true;
        bool? b = false;
        expect(a.or(b), isTrue);
      });

      test('should return true for false or true', () {
        bool? a = false;
        bool? b = true;
        expect(a.or(b), isTrue);
      });

      test('should return false for false or false', () {
        bool? a = false;
        bool? b = false;
        expect(a.or(b), isFalse);
      });

      test('should return null when first operand is null', () {
        bool? a;
        bool? b = true;
        expect(a.or(b), isNull);
      });

      test('should return null when second operand is null', () {
        bool? a = true;
        bool? b;
        expect(a.or(b), isNull);
      });

      test('should return null when both operands are null', () {
        bool? a;
        bool? b;
        expect(a.or(b), isNull);
      });
    });

    group('complex boolean operations', () {
      test('should handle chained operations', () {
        bool? a = true;
        bool? b = false;
        bool? c = true;

        final result = a.and(b).or(c);
        expect(result, isTrue);
      });

      test('should handle null propagation in chains', () {
        bool? a = true;
        bool? b;
        bool? c = false;

        final result = a.and(b).or(c);
        expect(result, isNull);
      });

      test('should work with toggle in expressions', () {
        bool flag = true;
        bool? nullableFlag = false;

        final result = flag.toggle().and(nullableFlag);
        expect(result, isFalse);
      });
    });
  });
}
