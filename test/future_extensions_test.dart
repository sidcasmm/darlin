import 'package:test/test.dart';
import 'package:darlin/darlin.dart';

void main() {
  group('FutureUtils', () {
    group('thenIfNotNull', () {
      test('should execute function when result is not null', () async {
        final future = Future<String?>.value('test');
        final result = await future.thenIfNotNull((value) => value?.toUpperCase());
        expect(result, equals('TEST'));
      });

      test('should return null when result is null', () async {
        final future = Future<String?>.value(null);
        final result = await future.thenIfNotNull((value) => value?.toUpperCase());
        expect(result, isNull);
      });

      test('should handle async functions', () async {
        final future = Future<String?>.value('test');
        final result = await future.thenIfNotNull((value) async => value?.toUpperCase());
        expect(result, equals('TEST'));
      });
    });

    group('thenIf', () {
      test('should execute function when condition is true', () async {
        final future = Future.value(5);
        final result = await future.thenIf(
          (value) => value > 3,
          (value) => value * 2,
        );
        expect(result, equals(10));
      });

      test('should return null when condition is false', () async {
        final future = Future.value(2);
        final result = await future.thenIf(
          (value) => value > 3,
          (value) => value * 2,
        );
        expect(result, isNull);
      });

      test('should handle async functions', () async {
        final future = Future.value(5);
        final result = await future.thenIf(
          (value) => value > 3,
          (value) async => value * 2,
        );
        expect(result, equals(10));
      });
    });

    group('onErrorReturn', () {
      test('should return default value on error', () async {
        final future = Future<String>.error('Network error');
        final result = await future.onErrorReturn('default data');
        expect(result, equals('default data'));
      });

      test('should return original result on success', () async {
        final future = Future.value('success data');
        final result = await future.onErrorReturn('default data');
        expect(result, equals('success data'));
      });

      test('should handle different error types', () async {
        final future = Future<int>.error(Exception('Test exception'));
        final result = await future.onErrorReturn(42);
        expect(result, equals(42));
      });
    });

    group('onErrorReturnWith', () {
      test('should return default value and execute error handler on error', () async {
        var errorHandled = false;
        final future = Future<String>.error('Network error');
        
        final result = await future.onErrorReturnWith(
          'default data',
          (error, stackTrace) {
            errorHandled = true;
            expect(error, equals('Network error'));
          },
        );
        
        expect(result, equals('default data'));
        expect(errorHandled, isTrue);
      });

      test('should return original result and not execute error handler on success', () async {
        var errorHandled = false;
        final future = Future.value('success data');
        
        final result = await future.onErrorReturnWith(
          'default data',
          (error, stackTrace) {
            errorHandled = true;
          },
        );
        
        expect(result, equals('success data'));
        expect(errorHandled, isFalse);
      });
    });

    group('onFinally', () {
      test('should execute action on success', () async {
        var actionExecuted = false;
        final future = Future.value('success');
        
        final result = await future.onFinally(() {
          actionExecuted = true;
        });
        
        expect(result, equals('success'));
        expect(actionExecuted, isTrue);
      });

      test('should execute action on error and rethrow', () async {
        var actionExecuted = false;
        final future = Future<String>.error('Test error');
        
        try {
          await future.onFinally(() {
            actionExecuted = true;
          });
        } catch (e) {
          // Expected to throw
        }
        
        expect(actionExecuted, isTrue);
      });

      test('should handle async actions', () async {
        var actionExecuted = false;
        final future = Future.value('success');
        
        final result = await future.onFinally(() async {
          await Future.delayed(Duration(milliseconds: 10));
          actionExecuted = true;
        });
        
        expect(result, equals('success'));
        expect(actionExecuted, isTrue);
      });
    });

    group('thenNullable', () {
      test('should transform result when transformation returns non-null', () async {
        final future = Future.value('John Doe');
        final result = await future.thenNullable((fullName) => fullName.split(' ').first);
        expect(result, equals('John'));
      });

      test('should return null when transformation returns null', () async {
        final future = Future.value('John Doe');
        final result = await future.thenNullable((fullName) => null);
        expect(result, isNull);
      });

      test('should handle empty string transformation', () async {
        final future = Future.value('John Doe');
        final result = await future.thenNullable((fullName) => fullName.isEmpty ? 'empty' : null);
        expect(result, isNull);
      });
    });

    group('chaining', () {
      test('should chain multiple operations correctly', () async {
        final future = Future.value(10);
        
        final result = await future
            .thenIf((value) => value > 5, (value) => value * 2)
            .thenIfNotNull((value) => value.toString())
            .thenNullable((value) => value != null && value.length > 1 ? value : null);
        
        expect(result, equals('20'));
      });

      test('should handle null chain gracefully', () async {
        final future = Future.value(2);
        
        final result = await future
            .thenIf((value) => value > 5, (value) => value * 2)
            .thenIfNotNull((value) => value.toString());
        
        expect(result, isNull);
      });
    });
  });
} 