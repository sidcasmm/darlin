import 'package:test/test.dart';
import 'package:darlin/darlin.dart';

void main() {
  group('StringChecks extension', () {
    group('isNullOrEmpty', () {
      test('should return true for null string', () {
        String? str;
        expect(str.isNullOrEmpty, isTrue);
      });

      test('should return true for empty string', () {
        String? str = '';
        expect(str.isNullOrEmpty, isTrue);
      });

      test('should return false for non-empty string', () {
        String? str = 'hello';
        expect(str.isNullOrEmpty, isFalse);
      });

      test('should return false for string with whitespace', () {
        String? str = '   ';
        expect(str.isNullOrEmpty, isFalse);
      });
    });

    group('isNullOrBlank', () {
      test('should return true for null string', () {
        String? str;
        expect(str.isNullOrBlank, isTrue);
      });

      test('should return true for empty string', () {
        String? str = '';
        expect(str.isNullOrBlank, isTrue);
      });

      test('should return true for string with only whitespace', () {
        String? str = '   ';
        expect(str.isNullOrBlank, isTrue);
      });

      test('should return true for string with tabs and newlines', () {
        String? str = '\t\n\r';
        expect(str.isNullOrBlank, isTrue);
      });

      test('should return false for string with content', () {
        String? str = 'hello';
        expect(str.isNullOrBlank, isFalse);
      });

      test('should return false for string with content and whitespace', () {
        String? str = '  hello  ';
        expect(str.isNullOrBlank, isFalse);
      });
    });

    group('isNotNullOrEmpty', () {
      test('should return false for null string', () {
        String? str;
        expect(str.isNotNullOrEmpty, isFalse);
      });

      test('should return false for empty string', () {
        String? str = '';
        expect(str.isNotNullOrEmpty, isFalse);
      });

      test('should return true for non-empty string', () {
        String? str = 'hello';
        expect(str.isNotNullOrEmpty, isTrue);
      });

      test('should return true for string with whitespace', () {
        String? str = '   ';
        expect(str.isNotNullOrEmpty, isTrue);
      });
    });

    group('isNotNullOrBlank', () {
      test('should return false for null string', () {
        String? str;
        expect(str.isNotNullOrBlank, isFalse);
      });

      test('should return false for empty string', () {
        String? str = '';
        expect(str.isNotNullOrBlank, isFalse);
      });

      test('should return false for string with only whitespace', () {
        String? str = '   ';
        expect(str.isNotNullOrBlank, isFalse);
      });

      test('should return false for string with tabs and newlines', () {
        String? str = '\t\n\r';
        expect(str.isNotNullOrBlank, isFalse);
      });

      test('should return true for string with content', () {
        String? str = 'hello';
        expect(str.isNotNullOrBlank, isTrue);
      });

      test('should return true for string with content and whitespace', () {
        String? str = '  hello  ';
        expect(str.isNotNullOrBlank, isTrue);
      });
    });
  });

  group('StringUtils extension', () {
    group('reversed', () {
      test('should reverse a simple string', () {
        expect('hello'.reversed, equals('olleh'));
      });

      test('should reverse a string with spaces', () {
        expect('hello world'.reversed, equals('dlrow olleh'));
      });

      test('should handle empty string', () {
        expect(''.reversed, equals(''));
      });

      test('should handle single character', () {
        expect('a'.reversed, equals('a'));
      });

      test('should handle palindrome', () {
        expect('racecar'.reversed, equals('racecar'));
      });
    });

    group('capitalize', () {
      test('should capitalize first character', () {
        expect('hello'.capitalize(), equals('Hello'));
      });

      test('should handle string with spaces', () {
        expect('hello world'.capitalize(), equals('Hello world'));
      });

      test('should handle already capitalized string', () {
        expect('Hello'.capitalize(), equals('Hello'));
      });

      test('should handle empty string', () {
        expect(''.capitalize(), equals(''));
      });

      test('should handle single character', () {
        expect('a'.capitalize(), equals('A'));
      });

      test('should handle string starting with number', () {
        expect('123abc'.capitalize(), equals('123abc'));
      });
    });

    group('isNumeric', () {
      test('should return true for numeric string', () {
        expect('123'.isNumeric, isTrue);
        expect('0'.isNumeric, isTrue);
        expect('999999'.isNumeric, isTrue);
      });

      test('should return false for non-numeric string', () {
        expect('123abc'.isNumeric, isFalse);
        expect('abc123'.isNumeric, isFalse);
        expect('abc'.isNumeric, isFalse);
      });

      test('should return false for decimal numbers', () {
        expect('12.34'.isNumeric, isFalse);
        expect('123.'.isNumeric, isFalse);
        expect('.123'.isNumeric, isFalse);
      });

      test('should return false for negative numbers', () {
        expect('-123'.isNumeric, isFalse);
      });

      test('should return false for empty string', () {
        expect(''.isNumeric, isFalse);
      });

      test('should return false for string with spaces', () {
        expect(' 123 '.isNumeric, isFalse);
      });
    });

    group('isEmail', () {
      test('should return true for valid email addresses', () {
        expect('user@example.com'.isEmail, isTrue);
        expect('test.email@domain.co.uk'.isEmail, isTrue);
        expect('user+tag@example.org'.isEmail, isTrue);
        expect('user.name@domain.com'.isEmail, isTrue);
      });

      test('should return false for invalid email addresses', () {
        expect('invalid-email'.isEmail, isFalse);
        expect('user@'.isEmail, isFalse);
        expect('@domain.com'.isEmail, isFalse);
        expect('user@domain'.isEmail, isFalse);
        expect('user..name@domain.com'.isEmail, isFalse);
      });

      test('should return false for empty string', () {
        expect(''.isEmail, isFalse);
      });

      test('should return false for string with spaces', () {
        expect(' user@example.com '.isEmail, isFalse);
      });
    });

    group('removeWhitespaces', () {
      test('should remove all whitespace characters', () {
        expect('hello world'.removeWhitespaces(), equals('helloworld'));
        expect('  hello  world  '.removeWhitespaces(), equals('helloworld'));
      });

      test('should handle tabs and newlines', () {
        expect('hello\tworld\n'.removeWhitespaces(), equals('helloworld'));
      });

      test('should handle multiple spaces', () {
        expect('hello    world'.removeWhitespaces(), equals('helloworld'));
      });

      test('should handle empty string', () {
        expect(''.removeWhitespaces(), equals(''));
      });

      test('should handle string with only whitespace', () {
        expect('   \t\n  '.removeWhitespaces(), equals(''));
      });

      test('should handle string without whitespace', () {
        expect('helloworld'.removeWhitespaces(), equals('helloworld'));
      });
    });

    group('limit', () {
      test('should truncate string longer than maxLength', () {
        expect('hello world'.limit(5), equals('hello...'));
        expect('abcdefghijklmnop'.limit(10), equals('abcdefghij...'));
      });

      test('should return original string if shorter than maxLength', () {
        expect('hello'.limit(10), equals('hello'));
        expect('hi'.limit(5), equals('hi'));
      });

      test('should return original string if equal to maxLength', () {
        expect('hello'.limit(5), equals('hello'));
      });

      test('should handle empty string', () {
        expect(''.limit(5), equals(''));
      });

      test('should handle maxLength of 0', () {
        expect('hello world'.limit(0), equals('...'));
      });

      test('should handle maxLength of 1', () {
        expect('hello world'.limit(1), equals('h...'));
      });

      test('should handle maxLength of 2', () {
        expect('hello world'.limit(2), equals('he...'));
      });
    });
  });
}
