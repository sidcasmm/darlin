import 'package:darlin/darlin.dart';

/// Main example demonstrating Object utilities from Dartlin package
/// 
/// This example showcases all the powerful object manipulation features including:
/// - Deep copying and cloning
/// - Deep equality comparison
/// - Object transformation and manipulation
/// - Merging and combining objects
/// - Partial object operations
void main() {
  print('=== Object Utilities Example ===\n');

  // 1. Deep Copying Examples
  print('1. Deep Copying Examples:');
  print('--------------------------');

  // Simple Map deep copy
  final originalPerson = {
    'name': 'John Doe',
    'age': 30,
    'address': {
      'street': '123 Main St',
      'city': 'New York',
      'zip': '10001'
    },
    'hobbies': ['reading', 'swimming', 'coding']
  };

  final copiedPerson = originalPerson.deepCopy();
  final recursiveCopiedPerson = originalPerson.deepCopyRecursive();

  print('Original person: $originalPerson');
  print('Deep copied person: $copiedPerson');
  print('Recursive copied person: $recursiveCopiedPerson');

  // Modify the copy to show independence
  (copiedPerson as Map)['age'] = 31;
  (copiedPerson)['address']['city'] = 'Los Angeles';
  (copiedPerson)['hobbies'].add('gaming');

  print('\nAfter modifying copy:');
  print('Original person age: ${originalPerson['age']}'); // Still 30
  print('Copied person age: ${copiedPerson['age']}'); // Now 31
  print('Original hobbies: ${originalPerson['hobbies']}'); // Still 4 items
  print('Copied hobbies: ${copiedPerson['hobbies']}'); // Now 5 items

  // 2. Deep Equality Comparison
  print('\n2. Deep Equality Comparison:');
  print('-----------------------------');

  final person1 = {
    'name': 'Jane Smith',
    'age': 25,
    'details': {
      'height': 165,
      'weight': 60
    }
  };

  final person2 = {
    'name': 'Jane Smith',
    'age': 25,
    'details': {
      'height': 165,
      'weight': 60
    }
  };

  final person3 = {
    'name': 'Jane Smith',
    'age': 25,
    'details': {
      'height': 165,
      'weight': 65  // Different weight
    }
  };

  print('person1.deepEqual(person2): ${person1.deepEqual(person2)}'); // true
  print('person1.deepEqual(person3): ${person1.deepEqual(person3)}'); // false
  print('person1.deepEqualRecursive(person2): ${person1.deepEqualRecursive(person2)}'); // true
  print('person1.deepEqualRecursive(person3): ${person1.deepEqualRecursive(person3)}'); // false

  // Shallow equality (reference comparison)
  print('person1.shallowEqual(person2): ${person1.shallowEqual(person2)}'); // false
  final person1Ref = person1;
  print('person1.shallowEqual(person1Ref): ${person1.shallowEqual(person1Ref)}'); // true

  // 3. Object Transformation and Manipulation
  print('\n3. Object Transformation and Manipulation:');
  print('------------------------------------------');

  // copyWith - update specific fields
  final updatedPerson = originalPerson.copyWith({
    'age': 32,
    'email': 'john.doe@example.com'
  });
  print('Updated person with copyWith: $updatedPerson');

  // copyWithNull - allow null values
  final personWithNull = originalPerson.copyWithNull({
    'age': null,
    'phone': null
  });
  print('Person with null values: $personWithNull');

  // copyOnly - keep only specific fields
  final basicInfo = originalPerson.copyOnly(['name', 'age']);
  print('Basic info only: $basicInfo');

  // copyWithout - exclude specific fields
  final publicInfo = originalPerson.copyWithout(['age', 'address']);
  print('Public info (without age/address): $publicInfo');

  // transform - apply transformations to values
  final transformedPerson = originalPerson.transform((key, value) {
    if (key == 'name') return (value as String).toUpperCase();
    if (key == 'age') return (value as int) + 1;
    if (key == 'hobbies' && value is List) {
      return (value).map((hobby) => (hobby as String).toUpperCase()).toList();
    }
    return value;
  });
  print('Transformed person: $transformedPerson');

  // 4. Object Merging
  print('\n4. Object Merging:');
  print('------------------');

  final baseConfig = {
    'app_name': 'MyApp',
    'version': '1.0.0',
    'debug': false,
    'max_users': 100
  };

  final userConfig = {
    'debug': true,
    'max_users': 200,
    'theme': 'dark',
    'language': 'en'
  };

  final productionConfig = {
    'debug': false,
    'max_users': 1000,
    'environment': 'production'
  };

  // Simple merge (later values override earlier ones)
  final mergedConfig = baseConfig.merge(userConfig);
  print('Merged config: $mergedConfig');

  // Merge with conflict resolution
  final finalConfig = mergedConfig.merge(productionConfig, 
    conflictResolver: (key, value1, value2) {
      if (key == 'max_users') {
        return (value1 as int) + (value2 as int); // Sum the values
      }
      if (key == 'debug') {
        return value1 && value2; // Both must be true
      }
      return value2; // Default: later value wins
    }
  );
  print('Final config with conflict resolution: $finalConfig');

  // 5. Partial Object Operations
  print('\n5. Partial Object Operations:');
  print('-------------------------------');

  final user1 = {
    'id': 1,
    'name': 'Alice',
    'email': 'alice@example.com',
    'age': 28,
    'role': 'user'
  };

  final user2 = {
    'id': 2,
    'name': 'Alice',
    'email': 'alice.smith@example.com',
    'age': 28,
    'role': 'admin'
  };

  // Partial equality - compare only specific fields
  final namesEqual = user1.partialEqual(user2, ['name']);
  final namesAndAgeEqual = user1.partialEqual(user2, ['name', 'age']);
  final allFieldsEqual = user1.partialEqual(user2, ['id', 'name', 'email', 'age', 'role']);

  print('Names equal: $namesEqual'); // true
  print('Names and age equal: $namesAndAgeEqual'); // true
  print('All fields equal: $allFieldsEqual'); // false

  // 6. Hash Code and Deep Operations
  print('\n6. Hash Code and Deep Operations:');
  print('----------------------------------');

  final obj1 = {'a': 1, 'b': {'c': 2, 'd': [3, 4]}};
  final obj2 = {'a': 1, 'b': {'c': 2, 'd': [3, 4]}};
  final obj3 = {'a': 1, 'b': {'c': 2, 'd': [3, 5]}};

  print('obj1.deepHashCode: ${obj1.deepHashCode}');
  print('obj2.deepHashCode: ${obj2.deepHashCode}');
  print('obj3.deepHashCode: ${obj3.deepHashCode}');
  print('obj1.deepHashCode == obj2.deepHashCode: ${obj1.deepHashCode == obj2.deepHashCode}'); // true
  print('obj1.deepHashCode == obj3.deepHashCode: ${obj1.deepHashCode == obj3.deepHashCode}'); // false

  print('obj1.deepHashCodeRecursive: ${obj1.deepHashCodeRecursive}');
  print('obj2.deepHashCodeRecursive: ${obj2.deepHashCodeRecursive}');
  print('obj1.deepHashCodeRecursive == obj2.deepHashCodeRecursive: ${obj1.deepHashCodeRecursive == obj2.deepHashCodeRecursive}'); // true

  // 7. Real-world Complex Example
  print('\n7. Real-world Complex Example:');
  print('--------------------------------');

  // Simulate a complex data structure (e.g., API response)
  final apiResponse = {
    'status': 'success',
    'data': {
      'users': [
        {
          'id': 1,
          'name': 'John',
          'profile': {
            'avatar': 'https://example.com/avatar1.jpg',
            'bio': 'Software Developer'
          }
        },
        {
          'id': 2,
          'name': 'Jane',
          'profile': {
            'avatar': 'https://example.com/avatar2.jpg',
            'bio': 'Product Manager'
          }
        }
      ],
      'pagination': {
        'page': 1,
        'limit': 10,
        'total': 2
      }
    },
    'timestamp': DateTime.now().toIso8601String()
  };

  // Deep copy the response for processing
  final processedResponse = apiResponse.deepCopyRecursive();
  
  // Transform user names to uppercase
  final transformedResponse = processedResponse.transform((key, value) {
    if (key == 'data' && value is Map) {
      final data = value;
      if (data.containsKey('users') && data['users'] is List) {
        final users = (data['users'] as List).map((user) {
          if (user is Map && user.containsKey('name')) {
            final userMap = Map<String, dynamic>.from(user);
            userMap['name'] = (userMap['name'] as String).toUpperCase();
            return userMap;
          }
          return user;
        }).toList();
        return {...data, 'users': users};
      }
    }
    return value;
  });

  // 8. Performance and Edge Cases
  print('\n8. Performance and Edge Cases:');
  print('-------------------------------');

  // Test with large nested structures
  final largeObject = _createLargeNestedObject(3, 5);
  final startTime = DateTime.now();
  final largeCopy = largeObject.deepCopyRecursive();
  final endTime = DateTime.now();
  
  print('Large object copy time: ${endTime.difference(startTime).inMilliseconds}ms');
  print('Large object deep equality: ${largeObject.deepEqualRecursive(largeCopy)}'); // true

  // Test with circular references (should handle gracefully)
  final circularObject = <String, dynamic>{'name': 'circular'};
  circularObject['self'] = circularObject;
  
  try {
    final circularCopy = circularObject.deepCopy();
    print('Circular object copy successful: $circularCopy');
  } catch (e) {
    print('Circular object copy failed: $e');
  }

  print('\n=== Object Utilities Example Complete ===');
}

/// Helper function to create a large nested object for performance testing
Map<String, dynamic> _createLargeNestedObject(int depth, int breadth) {
  if (depth == 0) {
    return {'value': 'leaf'};
  }
  
  final result = <String, dynamic>{};
  for (int i = 0; i < breadth; i++) {
    result['key_$i'] = _createLargeNestedObject(depth - 1, breadth);
  }
  return result;
} 