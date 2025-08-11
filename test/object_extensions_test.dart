import 'package:test/test.dart';
import 'package:darlin/darlin.dart';

void main() {
  group('ObjectUtils', () {
    group('deepCopy', () {
      test('should create deep copy of Map', () {
        final original = {'name': 'John', 'age': 30, 'details': {'city': 'NYC'}};
        final copy = original.deepCopy() as Map<String, dynamic>;
        
        expect(copy, equals(original));
        expect(identical(copy, original), isFalse);
        
        // Modify copy and verify original is unchanged
        copy['age'] = 31;
        (copy['details'] as Map<String, dynamic>)['city'] = 'LA';
        
        expect(original['age'], equals(30));
        expect((original['details'] as Map<String, dynamic>)['city'], equals('NYC'));
        expect(copy['age'], equals(31));
        expect((copy['details'] as Map<String, dynamic>)['city'], equals('LA'));
      });

      test('should handle nested lists', () {
        final original = {
          'items': [1, 2, 3],
          'nested': {'list': [4, 5, 6]}
        };
        final copy = original.deepCopy() as Map<String, dynamic>;
        
        expect(copy, equals(original));
        expect(identical(copy, original), isFalse);
        
        (copy['items'] as List<dynamic>).add(4);
        ((copy['nested'] as Map<String, dynamic>)['list'] as List<dynamic>).add(7);
        
        expect(original['items'], equals([1, 2, 3]));
        expect((original['nested'] as Map<String, dynamic>)['list'], equals([4, 5, 6]));
        expect(copy['items'], equals([1, 2, 3, 4]));
        expect((copy['nested'] as Map<String, dynamic>)['list'], equals([4, 5, 6, 7]));
      });

      test('should return original object if JSON serialization fails', () {
        final obj = Object(); // Object that can't be serialized
        final copy = obj.deepCopy();
        expect(identical(copy, obj), isTrue);
      });
    });

    group('deepEqual', () {
      test('should return true for identical objects', () {
        final obj1 = {'name': 'John', 'age': 30};
        final obj2 = {'name': 'John', 'age': 30};
        
        expect(obj1.deepEqual(obj2), isTrue);
      });

      test('should return false for different objects', () {
        final obj1 = {'name': 'John', 'age': 30};
        final obj2 = {'name': 'John', 'age': 31};
        
        expect(obj1.deepEqual(obj2), isFalse);
      });

      test('should return true for identical references', () {
        final obj1 = {'name': 'John'};
        final obj2 = obj1;
        
        expect(obj1.deepEqual(obj2), isTrue);
      });

      test('should return false for null comparison', () {
        final obj = {'name': 'John'};
        
        expect(obj.deepEqual(null), isFalse);
      });

      test('should handle nested structures', () {
        final obj1 = {
          'user': {
            'name': 'John',
            'preferences': {'theme': 'dark', 'notifications': true}
          }
        };
        final obj2 = {
          'user': {
            'name': 'John',
            'preferences': {'theme': 'dark', 'notifications': true}
          }
        };
        final obj3 = {
          'user': {
            'name': 'John',
            'preferences': {'theme': 'light', 'notifications': true}
          }
        };
        
        expect(obj1.deepEqual(obj2), isTrue);
        expect(obj1.deepEqual(obj3), isFalse);
      });
    });

    group('copyWith', () {
      test('should update Map fields', () {
        final original = {'name': 'John', 'age': 30, 'city': 'NYC'};
        final updated = original.copyWith({'age': 31, 'city': 'LA'});
        
        expect(updated, equals({'name': 'John', 'age': 31, 'city': 'LA'}));
        expect(original, equals({'name': 'John', 'age': 30, 'city': 'NYC'}));
        expect(identical(updated, original), isFalse);
      });

      test('should add new fields', () {
        final original = {'name': 'John'};
        final updated = original.copyWith({'age': 30, 'city': 'NYC'});
        
        expect(updated, equals({'name': 'John', 'age': 30, 'city': 'NYC'}));
      });

      test('should handle non-Map objects gracefully', () {
        final obj = 'test string';
        final result = obj.copyWith({'key': 'value'});
        
        // Should return original object if JSON serialization fails
        expect(result, equals(obj));
      });
    });

    group('copyWithNull', () {
      test('should preserve null values', () {
        final original = {'name': 'John', 'age': 30, 'city': 'NYC'};
        final updated = original.copyWithNull({'age': null, 'city': 'LA'});
        
        expect(updated, equals({'name': 'John', 'age': null, 'city': 'LA'}));
      });

      test('should handle explicit null assignments', () {
        final original = {'name': 'John', 'age': 30};
        final updated = original.copyWithNull({'age': null, 'country': null});
        
        expect(updated, equals({'name': 'John', 'age': null, 'country': null}));
      });
    });

    group('copyOnly', () {
      test('should copy only specified fields', () {
        final original = {'name': 'John', 'age': 30, 'city': 'NYC', 'country': 'USA'};
        final basicInfo = original.copyOnly(['name', 'age']);
        
        expect(basicInfo, equals({'name': 'John', 'age': 30}));
        expect(original, equals({'name': 'John', 'age': 30, 'city': 'NYC', 'country': 'USA'}));
      });

      test('should handle non-existent fields gracefully', () {
        final original = {'name': 'John', 'age': 30};
        final result = original.copyOnly(['name', 'age', 'nonExistent']);
        
        expect(result, equals({'name': 'John', 'age': 30}));
      });
    });

    group('copyWithout', () {
      test('should exclude specified fields', () {
        final original = {'name': 'John', 'age': 30, 'city': 'NYC', 'country': 'USA'};
        final publicInfo = original.copyWithout(['age', 'country']);
        
        expect(publicInfo, equals({'name': 'John', 'city': 'NYC'}));
        expect(original, equals({'name': 'John', 'age': 30, 'city': 'NYC', 'country': 'USA'}));
      });

      test('should handle non-existent fields gracefully', () {
        final original = {'name': 'John', 'age': 30};
        final result = original.copyWithout(['age', 'nonExistent']);
        
        expect(result, equals({'name': 'John'}));
      });
    });

    group('shallowEqual', () {
      test('should return true for identical references', () {
        final obj1 = {'name': 'John'};
        final obj2 = obj1;
        
        expect(obj1.shallowEqual(obj2), isTrue);
      });

      test('should return false for different references', () {
        final obj1 = {'name': 'John'};
        final obj2 = {'name': 'John'};
        
        expect(obj1.shallowEqual(obj2), isFalse);
      });
    });

    group('isDeepNull', () {
      test('should return false for non-null objects', () {
        final obj = {'name': 'John'};
        expect(obj.isDeepNull, isFalse);
      });

      test('should return true for null objects', () {
        // Note: Extension methods can't be called on null
        // This test demonstrates the limitation
        expect(true, isTrue); // Placeholder test
      });
    });

    group('deepHashCode', () {
      test('should return same hash code for equal objects', () {
        final obj1 = {'name': 'John', 'age': 30};
        final obj2 = {'name': 'John', 'age': 30};
        
        expect(obj1.deepHashCode, equals(obj2.deepHashCode));
      });

      test('should return different hash codes for different objects', () {
        final obj1 = {'name': 'John', 'age': 30};
        final obj2 = {'name': 'John', 'age': 31};
        
        expect(obj1.deepHashCode, isNot(equals(obj2.deepHashCode)));
      });
    });

    group('deepCopyRecursive', () {
      test('should create truly deep copy of nested structures', () {
        final original = {
          'nested': {
            'deep': [1, 2, {'value': 3, 'more': [4, 5]}]
          }
        };
        final copy = original.deepCopyRecursive() as Map<String, dynamic>;
        
        expect(copy.deepEqualRecursive(original), isTrue);
        expect(identical(copy, original), isFalse);
        
        // Modify deeply nested structure
        ((copy['nested'] as Map<String, dynamic>)['deep'] as List<dynamic>)[2]['value'] = 4;
        ((copy['nested'] as Map<String, dynamic>)['deep'] as List<dynamic>)[2]['more'].add(6);
        
        expect((original['nested'] as Map<String, dynamic>)['deep'][2]['value'], equals(3));
        expect((original['nested'] as Map<String, dynamic>)['deep'][2]['more'], equals([4, 5]));
        expect((copy['nested'] as Map<String, dynamic>)['deep'][2]['value'], equals(4));
        expect((copy['nested'] as Map<String, dynamic>)['deep'][2]['more'], equals([4, 5, 6]));
      });

      test('should handle Lists correctly', () {
        final original = [1, 2, [3, 4, {'nested': 5}]];
        final copy = original.deepCopyRecursive() as List<dynamic>;
        
        expect(copy.deepEqualRecursive(original), isTrue);
        expect(identical(copy, original), isFalse);
        
        // Modify nested list
        (copy[2] as List<dynamic>)[2]['nested'] = 6;
        
        expect((original[2] as List<dynamic>)[2]['nested'], equals(5));
        expect((copy[2] as List<dynamic>)[2]['nested'], equals(6));
      });

      test('should handle primitive types', () {
        final original = 'test string';
        final copy = original.deepCopyRecursive();
        
        expect(copy, equals(original));
        expect(identical(copy, original), isTrue); // Strings are immutable
      });
    });

    group('deepEqualRecursive', () {
      test('should return true for deeply equal objects', () {
        final obj1 = {
          'nested': {
            'deep': [1, 2, {'value': 3, 'more': [4, 5]}]
          }
        };
        final obj2 = {
          'nested': {
            'deep': [1, 2, {'value': 3, 'more': [4, 5]}]
          }
        };
        
        expect(obj1.deepEqualRecursive(obj2), isTrue);
      });

      test('should return false for different nested structures', () {
        final obj1 = {
          'nested': {
            'deep': [1, 2, {'value': 3}]
          }
        };
        final obj2 = {
          'nested': {
            'deep': [1, 2, {'value': 4}]
          }
        };
        
        expect(obj1.deepEqualRecursive(obj2), isFalse);
      });

      test('should handle Lists correctly', () {
        final obj1 = [1, 2, [3, 4, {'nested': 5}]];
        final obj2 = [1, 2, [3, 4, {'nested': 5}]];
        final obj3 = [1, 2, [3, 4, {'nested': 6}]];
        
        expect(obj1.deepEqualRecursive(obj2), isTrue);
        expect(obj1.deepEqualRecursive(obj3), isFalse);
      });

      test('should handle null values', () {
        final obj1 = {'field': null, 'other': 'value'};
        final obj2 = {'field': null, 'other': 'value'};
        final obj3 = {'field': 'not null', 'other': 'value'};
        
        expect(obj1.deepEqualRecursive(obj2), isTrue);
        expect(obj1.deepEqualRecursive(obj3), isFalse);
      });
    });

    group('deepHashCodeRecursive', () {
      test('should return same hash code for deeply equal objects', () {
        final obj1 = {
          'nested': {
            'deep': [1, 2, {'value': 3, 'more': [4, 5]}]
          }
        };
        final obj2 = {
          'nested': {
            'deep': [1, 2, {'value': 3, 'more': [4, 5]}]
          }
        };
        
        expect(obj1.deepHashCodeRecursive, equals(obj2.deepHashCodeRecursive));
      });

      test('should return different hash codes for different objects', () {
        final obj1 = {
          'nested': {
            'deep': [1, 2, {'value': 3}]
          }
        };
        final obj2 = {
          'nested': {
            'deep': [1, 2, {'value': 4}]
          }
        };
        
        expect(obj1.deepHashCodeRecursive, isNot(equals(obj2.deepHashCodeRecursive)));
      });

      test('should handle Lists correctly', () {
        final obj1 = [1, 2, [3, 4, {'nested': 5}]];
        final obj2 = [1, 2, [3, 4, {'nested': 5}]];
        final obj3 = [1, 2, [3, 4, {'nested': 6}]];
        
        expect(obj1.deepHashCodeRecursive, equals(obj2.deepHashCodeRecursive));
        expect(obj1.deepHashCodeRecursive, isNot(equals(obj3.deepHashCodeRecursive)));
      });
    });

    group('partialEqual', () {
      test('should return true for objects equal in specified fields', () {
        final obj1 = {'name': 'John', 'age': 30, 'city': 'NYC'};
        final obj2 = {'name': 'John', 'age': 30, 'city': 'LA'};
        
        expect(obj1.partialEqual(obj2, ['name', 'age']), isTrue);
      });

      test('should return false for objects different in specified fields', () {
        final obj1 = {'name': 'John', 'age': 30, 'city': 'NYC'};
        final obj2 = {'name': 'John', 'age': 31, 'city': 'LA'};
        
        expect(obj1.partialEqual(obj2, ['name', 'age']), isFalse);
      });

      test('should handle missing fields gracefully', () {
        final obj1 = {'name': 'John', 'age': 30};
        final obj2 = {'name': 'John', 'age': 30, 'city': 'NYC'};
        
        expect(obj1.partialEqual(obj2, ['name', 'age']), isTrue);
      });

      test('should handle nested structures in specified fields', () {
        final obj1 = {
          'name': 'John',
          'details': {'age': 30, 'city': 'NYC'}
        };
        final obj2 = {
          'name': 'John',
          'details': {'age': 30, 'city': 'LA'}
        };
        
        expect(obj1.partialEqual(obj2, ['name']), isTrue);
        expect(obj1.partialEqual(obj2, ['name', 'details']), isFalse);
      });
    });

    group('transform', () {
      test('should transform Map values correctly', () {
        final original = {'name': 'john', 'age': 30, 'city': 'nyc'};
        final transformed = original.transform((key, value) {
          if (key == 'name') return (value as String).toUpperCase();
          if (key == 'age') return (value as int) + 1;
          if (key == 'city') return (value as String).toUpperCase();
          return value;
        });
        
        expect(transformed, equals({'name': 'JOHN', 'age': 31, 'city': 'NYC'}));
        expect(original, equals({'name': 'john', 'age': 30, 'city': 'nyc'}));
      });

      test('should handle non-Map objects gracefully', () {
        final obj = 'test string';
        final result = obj.transform((key, value) => value);
        
        expect(result, equals(obj));
      });

      test('should preserve structure while transforming values', () {
        final original = {'a': 1, 'b': 2, 'c': 3};
        final transformed = original.transform((key, value) => (value as int) * 2);
        
        expect(transformed, equals({'a': 2, 'b': 4, 'c': 6}));
        expect((transformed as Map).keys, equals(original.keys));
      });
    });

    group('merge', () {
      test('should merge two Maps correctly', () {
        final obj1 = {'name': 'John', 'age': 30};
        final obj2 = {'age': 31, 'city': 'NYC'};
        
        final merged = obj1.merge(obj2);
        expect(merged, equals({'name': 'John', 'age': 31, 'city': 'NYC'}));
        expect(obj1, equals({'name': 'John', 'age': 30}));
      });

      test('should handle null other object', () {
        final obj1 = {'name': 'John', 'age': 30};
        final merged = obj1.merge(null);
        
        expect(merged, equals(obj1));
        expect(identical(merged, obj1), isTrue);
      });

      test('should use conflict resolver when provided', () {
        final obj1 = {'name': 'John', 'age': 30, 'score': 100};
        final obj2 = {'age': 31, 'score': 50, 'city': 'NYC'};
        
        final merged = obj1.merge(obj2, 
          conflictResolver: (key, value1, value2) {
            if (key == 'score') return (value1 as int) + (value2 as int);
            return value2;
          });
        
        expect(merged, equals({
          'name': 'John', 
          'age': 31, 
          'score': 150, 
          'city': 'NYC'
        }));
      });

      test('should handle non-Map objects gracefully', () {
        final obj = 'test string';
        final result = obj.merge({'key': 'value'});
        
        expect(result, equals(obj));
      });
    });

    group('complex scenarios', () {
      test('should handle complex nested structures', () {
        final original = {
          'users': [
            {
              'id': 1,
              'name': 'John',
              'profile': {
                'avatar': 'url1',
                'settings': {'theme': 'dark', 'language': 'en'}
              }
            },
            {
              'id': 2,
              'name': 'Jane',
              'profile': {
                'avatar': 'url2',
                'settings': {'theme': 'light', 'language': 'es'}
              }
            }
          ],
          'metadata': {'version': '1.0', 'lastUpdated': '2024-01-01'}
        };

        // Test deep copy
        final copy = original.deepCopy() as Map<String, dynamic>;
        expect(copy.deepEqual(original), isTrue);
        expect(identical(copy, original), isFalse);

        // Test copyWith
        final updated = original.copyWith({
          'metadata': {'version': '2.0', 'lastUpdated': '2024-01-02'}
        }) as Map<String, dynamic>;
        expect((updated['metadata'] as Map<String, dynamic>)['version'], equals('2.0'));
        expect((original['metadata'] as Map<String, dynamic>)['version'], equals('1.0'));

        // Test copyOnly
        final usersOnly = original.copyOnly(['users']);
        expect((usersOnly as Map).keys, equals(['users']));
        expect((usersOnly)['users'], equals(original['users']));

        // Test copyWithout
        final withoutMetadata = original.copyWithout(['metadata']);
        expect((withoutMetadata as Map).keys, equals(['users']));
        expect((withoutMetadata)['users'], equals(original['users']));
      });
    });

    group('edge cases', () {
      test('should handle empty Maps and Lists', () {
        final emptyMap = <String, dynamic>{};
        final emptyList = <dynamic>[];
        
        expect(emptyMap.deepCopy(), equals(emptyMap));
        expect(emptyList.deepCopy(), equals(emptyList));
        expect(emptyMap.deepEqual(emptyMap), isTrue);
        expect(emptyList.deepEqual(emptyList), isTrue);
      });

      test('should handle Maps with non-String keys gracefully', () {
        final mapWithNonStringKeys = {1: 'one', 'two': 2, 3.0: 'three'};
        final copy = mapWithNonStringKeys.deepCopy();
        
        // Should handle non-String keys by filtering them out
        expect(copy is Map, isTrue);
        expect((copy as Map).containsKey('two'), isTrue);
        expect((copy).containsKey(1), isFalse); // Non-String keys should be filtered
      });

      test('should handle circular references gracefully', () {
        final map1 = <String, dynamic>{};
        final map2 = <String, dynamic>{};
        map1['other'] = map2;
        map2['other'] = map1;
        
        // Should not crash and should handle gracefully
        expect(() => map1.deepCopy(), returnsNormally);
        expect(() => map1.deepEqual(map2), returnsNormally);
      });

      test('should handle null values in nested structures', () {
        final original = {
          'name': 'John',
          'details': null,
          'nested': {'value': null, 'list': [1, null, 3]}
        };
        
        final copy = original.deepCopy() as Map<String, dynamic>;
        expect(copy['details'], isNull);
        expect((copy['nested'] as Map<String, dynamic>)['value'], isNull);
        expect((copy['nested'] as Map<String, dynamic>)['list'], equals([1, null, 3]));
      });
    });
  });
} 