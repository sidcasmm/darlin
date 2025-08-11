import 'dart:convert';

/// Extensions on objects to provide comparison and cloning utilities.
extension ObjectUtils on Object {
  /// Creates a deep copy of the object using JSON serialization.
  /// 
  /// This method works for objects that can be serialized to JSON.
  /// Note: This is a simple deep copy implementation and may not work
  /// for all object types (e.g., objects with functions, circular references).
  ///
  /// Example:
  /// ```dart
  /// final original = {'name': 'John', 'age': 30};
  /// final copy = original.deepCopy();
  /// copy['age'] = 31;
  /// print(original['age']); // 30 (unchanged)
  /// print(copy['age']); // 31
  /// ```
  Object deepCopy() {
    try {
              // Handle Lists specifically for better performance
        if (this is List) {
          final List<dynamic> originalList = this as List<dynamic>;
          final List<dynamic> copy = originalList.map((item) {
            if (item is Map || item is List) {
              return item.deepCopyRecursive();
            }
            return item;
          }).toList();
          return copy;
        }
        
        // Handle Maps specifically for better performance
        if (this is Map) {
          final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
          final Map<String, dynamic> copy = <String, dynamic>{};
          originalMap.forEach((key, value) {
            if (key is String) {
              if (value is Map) {
                copy[key] = (value).deepCopy();
              } else if (value is List) {
                copy[key] = (value).deepCopy();
              } else {
                copy[key] = value;
              }
            }
          });
          return copy;
        }
      
      // For other types, use JSON serialization
      final jsonString = jsonEncode(this);
      final jsonMap = jsonDecode(jsonString);
      
              // Ensure we're actually creating a copy, not returning the same object
        if (jsonMap == this) {
          // If JSON round-trip returns the same object, create a manual copy
          if (this is Map) {
            final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
            final Map<String, dynamic> copy = <String, dynamic>{};
            originalMap.forEach((key, value) {
              if (key is String) {
                copy[key] = value;
              }
            });
            return copy;
          }
        }
        return jsonMap;
    } catch (e) {
      // If JSON serialization fails, try manual copy for Maps
      if (this is Map) {
        final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
        final Map<String, dynamic> copy = <String, dynamic>{};
        originalMap.forEach((key, value) {
          if (key is String) {
            copy[key] = value;
          }
        });
        return copy;
      }
      
      // For non-Map objects, return the original
      return this;
    }
  }

  /// Creates a truly deep copy by recursively copying nested structures.
  /// 
  /// This method provides more reliable deep copying than the basic deepCopy method.
  /// It handles nested Maps, Lists, and primitive types more effectively.
  ///
  /// Example:
  /// ```dart
  /// final original = {
  ///   'nested': {'deep': [1, 2, {'value': 3}]}
  /// };
  /// final copy = original.deepCopyRecursive();
  /// (copy['nested']['deep'][2] as Map)['value'] = 4;
  /// print(original['nested']['deep'][2]['value']); // 3 (unchanged)
  /// print(copy['nested']['deep'][2]['value']); // 4
  /// ```
  Object deepCopyRecursive() {
    if (this is Map) {
      final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
      final Map<String, dynamic> copy = <String, dynamic>{};
      
      originalMap.forEach((key, value) {
        if (key is String) {
          copy[key] = _deepCopyValue(value);
        }
      });
      
      return copy;
    }
    
    if (this is List) {
      final List<dynamic> originalList = this as List<dynamic>;
      final List<dynamic> copy = originalList.map(_deepCopyValue).toList();
      return copy;
    }
    
    // For primitive types and other objects, return as is
    return this;
  }

  /// Helper method for deep copying individual values.
  dynamic _deepCopyValue(dynamic value) {
    if (value == null) return null;
    if (value is Map) {
      final Map<dynamic, dynamic> map = value;
      final Map<String, dynamic> copy = <String, dynamic>{};
      map.forEach((key, val) {
        if (key is String) {
          copy[key] = _deepCopyValue(val);
        }
      });
      return copy;
    }
    if (value is List) {
      return value.map(_deepCopyValue).toList();
    }
    return value;
  }

  /// Performs a deep equality comparison with another object.
  /// 
  /// This method compares the JSON representation of objects,
  /// providing deep equality checking for nested structures.
  ///
  /// Example:
  /// ```dart
  /// final obj1 = {'name': 'John', 'details': {'age': 30}};
  /// final obj2 = {'name': 'John', 'details': {'age': 30}};
  /// final obj3 = {'name': 'John', 'details': {'age': 31}};
  ///
  /// print(obj1.deepEqual(obj2)); // true
  /// print(obj1.deepEqual(obj3)); // false
  /// ```
  bool deepEqual(Object? other) {
    if (identical(this, other)) return true;
    if (other == null) return false;
    
    try {
      final thisJson = jsonEncode(this);
      final otherJson = jsonEncode(other);
      return thisJson == otherJson;
    } catch (e) {
      // If JSON serialization fails, fall back to regular equality
      return this == other;
    }
  }

  /// Performs a recursive deep equality comparison.
  /// 
  /// This method provides more reliable deep equality checking than the basic deepEqual method.
  /// It handles nested structures more effectively without relying on JSON serialization.
  ///
  /// Example:
  /// ```dart
  /// final obj1 = {'nested': {'deep': [1, 2, {'value': 3}]}};
  /// final obj2 = {'nested': {'deep': [1, 2, {'value': 3}]}};
  /// final obj3 = {'nested': {'deep': [1, 2, {'value': 4}]}};
  ///
  /// print(obj1.deepEqualRecursive(obj2)); // true
  /// print(obj1.deepEqualRecursive(obj3)); // false
  /// ```
  bool deepEqualRecursive(Object? other) {
    if (identical(this, other)) return true;
    if (other == null) return false;
    
    if (this is Map && other is Map) {
      final Map<dynamic, dynamic> thisMap = this as Map<dynamic, dynamic>;
      final Map<dynamic, dynamic> otherMap = other;
      
      if (thisMap.length != otherMap.length) return false;
      
      for (final key in thisMap.keys) {
        if (!otherMap.containsKey(key)) return false;
        if (!_deepEqualValues(thisMap[key], otherMap[key])) return false;
      }
      
      return true;
    }
    
    if (this is List && other is List) {
      final List<dynamic> thisList = this as List<dynamic>;
      final List<dynamic> otherList = other;
      
      if (thisList.length != otherList.length) return false;
      
      for (int i = 0; i < thisList.length; i++) {
        if (!_deepEqualValues(thisList[i], otherList[i])) return false;
      }
      
      return true;
    }
    
    return this == other;
  }

  /// Helper method for recursive deep equality comparison.
  bool _deepEqualValues(dynamic value1, dynamic value2) {
    if (identical(value1, value2)) return true;
    if (value1 == null || value2 == null) return value1 == value2;
    
    if (value1 is Map && value2 is Map) {
      final Map<dynamic, dynamic> map1 = value1;
      final Map<dynamic, dynamic> map2 = value2;
      
      if (map1.length != map2.length) return false;
      
      for (final key in map1.keys) {
        if (!map2.containsKey(key)) return false;
        if (!_deepEqualValues(map1[key], map2[key])) return false;
      }
      
      return true;
    }
    
    if (value1 is List && value2 is List) {
      final List<dynamic> list1 = value1;
      final List<dynamic> list2 = value2;
      
      if (list1.length != list2.length) return false;
      
      for (int i = 0; i < list1.length; i++) {
        if (!_deepEqualValues(list1[i], list2[i])) return false;
      }
      
      return true;
    }
    
    return value1 == value2;
  }

  /// Creates a copy of the object with specified fields updated.
  /// 
  /// This is a generic copyWith implementation that works with Map objects.
  /// For custom classes, consider implementing a specific copyWith method.
  ///
  /// Example:
  /// ```dart
  /// final person = {'name': 'John', 'age': 30, 'city': 'NYC'};
  /// final updatedPerson = person.copyWith({'age': 31, 'city': 'LA'});
  /// // Result: {'name': 'John', 'age': 31, 'city': 'LA'}
  /// ```
  Object copyWith(Map<String, dynamic> updates) {
    if (this is Map) {
      final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
      final Map<String, dynamic> map = <String, dynamic>{};
      originalMap.forEach((key, value) {
        if (key is String) {
          map[key] = value;
        }
      });
      map.addAll(updates);
      return map;
    }
    
    // For non-Map objects, try to use JSON serialization
    try {
      final jsonString = jsonEncode(this);
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      jsonMap.addAll(updates);
      return jsonMap;
    } catch (e) {
      // If all else fails, return the original object
      return this;
    }
  }

  /// Creates a copy of the object with specified fields updated, preserving null values.
  /// 
  /// Unlike copyWith, this method allows explicit null values to be set.
  ///
  /// Example:
  /// ```dart
  /// final person = {'name': 'John', 'age': 30, 'city': 'NYC'};
  /// final updatedPerson = person.copyWithNull({'age': null, 'city': 'LA'});
  /// // Result: {'name': 'John', 'age': null, 'city': 'LA'}
  /// ```
  Object copyWithNull(Map<String, dynamic> updates) {
    if (this is Map) {
      final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
      final Map<String, dynamic> map = <String, dynamic>{};
      originalMap.forEach((key, value) {
        if (key is String) {
          map[key] = value;
        }
      });
      map.addAll(updates);
      return map;
    }
    
    // For non-Map objects, try to use JSON serialization
    try {
      final jsonString = jsonEncode(this);
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      jsonMap.addAll(updates);
      return jsonMap;
    } catch (e) {
      // If all else fails, return the original object
      return this;
    }
  }

  /// Creates a copy of the object with only specified fields.
  /// 
  /// This method creates a new object containing only the specified fields.
  ///
  /// Example:
  /// ```dart
  /// final person = {'name': 'John', 'age': 30, 'city': 'NYC', 'country': 'USA'};
  /// final basicInfo = person.copyOnly(['name', 'age']);
  /// // Result: {'name': 'John', 'age': 30}
  /// ```
  Object copyOnly(List<String> fields) {
    if (this is Map) {
      final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
      final Map<String, dynamic> result = <String, dynamic>{};
      
      for (final field in fields) {
        if (originalMap.containsKey(field)) {
          result[field] = originalMap[field];
        }
      }
      
      return result;
    }
    
    // For non-Map objects, try to use JSON serialization
    try {
      final jsonString = jsonEncode(this);
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final Map<String, dynamic> result = {};
      
      for (final field in fields) {
        if (jsonMap.containsKey(field)) {
          result[field] = jsonMap[field];
        }
      }
      
      return result;
    } catch (e) {
      // If all else fails, return the original object
      return this;
    }
  }

  /// Creates a copy of the object excluding specified fields.
  /// 
  /// This method creates a new object without the specified fields.
  ///
  /// Example:
  /// ```dart
  /// final person = {'name': 'John', 'age': 30, 'city': 'NYC', 'country': 'USA'};
  /// final publicInfo = person.copyWithout(['age', 'country']);
  /// // Result: {'name': 'John', 'city': 'NYC'}
  /// ```
  Object copyWithout(List<String> fields) {
    if (this is Map) {
      final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
      final Map<String, dynamic> result = <String, dynamic>{};
      originalMap.forEach((key, value) {
        if (key is String) {
          result[key] = value;
        }
      });
      
      for (final field in fields) {
        result.remove(field);
      }
      
      return result;
    }
    
    // For non-Map objects, try to use JSON serialization
    try {
      final jsonString = jsonEncode(this);
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final Map<String, dynamic> result = Map<String, dynamic>.from(jsonMap);
      
      for (final field in fields) {
        result.remove(field);
      }
      
      return result;
    } catch (e) {
      // If all else fails, return the original object
      return this;
    }
  }

  /// Performs a shallow equality comparison with another object.
  /// 
  /// This method compares object references and basic equality.
  ///
  /// Example:
  /// ```dart
  /// final obj1 = {'name': 'John'};
  /// final obj2 = {'name': 'John'};
  /// final obj3 = obj1;
  ///
  /// print(obj1.shallowEqual(obj2)); // false (different references)
  /// print(obj1.shallowEqual(obj3)); // true (same reference)
  /// ```
  bool shallowEqual(Object? other) {
    return identical(this, other);
  }

  /// Checks if the object is deeply equal to null.
  /// 
  /// This method provides a safe way to check for deep null equality.
  ///
  /// Example:
  /// ```dart
  /// final obj = {'name': 'John'};
  /// print(obj.isDeepNull); // false
  /// 
  /// final nullObj = null;
  /// print(nullObj.isDeepNull); // true
  /// ```
  bool get isDeepNull {
    try {
      final jsonString = jsonEncode(this);
      return jsonString == 'null';
    } catch (e) {
      return false;
    }
  }

  /// Returns a hash code based on the object's JSON representation.
  /// 
  /// This provides a consistent hash code for objects with the same content.
  ///
  /// Example:
  /// ```dart
  /// final obj1 = {'name': 'John', 'age': 30};
  /// final obj2 = {'name': 'John', 'age': 30};
  /// 
  /// print(obj1.deepHashCode == obj2.deepHashCode); // true
  /// ```
  int get deepHashCode {
    try {
      final jsonString = jsonEncode(this);
      return jsonString.hashCode;
    } catch (e) {
      return hashCode;
    }
  }

  /// Returns a hash code based on recursive deep comparison.
  /// 
  /// This provides a more reliable hash code than deepHashCode for complex nested structures.
  ///
  /// Example:
  /// ```dart
  /// final obj1 = {'nested': {'deep': [1, 2, {'value': 3}]}};
  /// final obj2 = {'nested': {'deep': [1, 2, {'value': 3}]}};
  /// 
  /// print(obj1.deepHashCodeRecursive == obj2.deepHashCodeRecursive); // true
  /// ```
  int get deepHashCodeRecursive {
    if (this is Map) {
      final Map<dynamic, dynamic> map = this as Map<dynamic, dynamic>;
      int hash = 0;
      map.forEach((key, value) {
        if (key is String) {
          hash = Object.hash(hash, key.hashCode, _deepHashValue(value));
        }
      });
      return hash;
    }
    
    if (this is List) {
      final List<dynamic> list = this as List<dynamic>;
      int hash = 0;
      for (final value in list) {
        hash = Object.hash(hash, _deepHashValue(value));
      }
      return hash;
    }
    
    return hashCode;
  }

  /// Helper method for recursive hash code calculation.
  int _deepHashValue(dynamic value) {
    if (value == null) return 0;
    if (value is Map) {
      final Map<dynamic, dynamic> map = value;
      int hash = 0;
      map.forEach((key, val) {
        if (key is String) {
          hash = Object.hash(hash, key.hashCode, _deepHashValue(val));
        }
      });
      return hash;
    }
    if (value is List) {
      final List<dynamic> list = value;
      int hash = 0;
      for (final val in list) {
        hash = Object.hash(hash, _deepHashValue(val));
      }
      return hash;
    }
    return value.hashCode;
  }

  /// Checks if the object is partially equal to another object based on specified fields.
  /// 
  /// This method compares only the specified fields, ignoring others.
  /// Useful for partial object comparison scenarios.
  ///
  /// Example:
  /// ```dart
  /// final obj1 = {'name': 'John', 'age': 30, 'city': 'NYC'};
  /// final obj2 = {'name': 'John', 'age': 30, 'city': 'LA'};
  /// 
  /// print(obj1.partialEqual(obj2, ['name', 'age'])); // true
  /// print(obj1.partialEqual(obj2, ['name', 'city'])); // false
  /// ```
  bool partialEqual(Object? other, List<String> fields) {
    if (other == null) return false;
    
    if (this is Map && other is Map) {
      final Map<dynamic, dynamic> thisMap = this as Map<dynamic, dynamic>;
      final Map<dynamic, dynamic> otherMap = other;
      
      for (final field in fields) {
        if (!thisMap.containsKey(field) || !otherMap.containsKey(field)) {
          if (thisMap[field] != otherMap[field]) return false;
        } else {
          if (!_deepEqualValues(thisMap[field], otherMap[field])) return false;
        }
      }
      return true;
    }
    
    // For non-Map objects, try JSON serialization
    try {
      final thisJson = jsonEncode(this);
      final otherJson = jsonEncode(other);
      final thisMap = jsonDecode(thisJson) as Map<String, dynamic>;
      final otherMap = jsonDecode(otherJson) as Map<String, dynamic>;
      
      for (final field in fields) {
        if (!thisMap.containsKey(field) || !otherMap.containsKey(field)) {
          if (thisMap[field] != otherMap[field]) return false;
        } else {
          if (thisMap[field] != otherMap[field]) return false;
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Transforms the object by applying a function to each field value.
  /// 
  /// This method creates a new object with transformed values while preserving the structure.
  /// Only works with Map objects.
  ///
  /// Example:
  /// ```dart
  /// final original = {'name': 'john', 'age': 30};
  /// final transformed = original.transform((key, value) {
  ///   if (key == 'name') return (value as String).toUpperCase();
  ///   if (key == 'age') return (value as int) + 1;
  ///   return value;
  /// });
  /// // Result: {'name': 'JOHN', 'age': 31}
  /// ```
  Object transform(dynamic Function(String key, dynamic value) transformer) {
    if (this is Map) {
      final Map<dynamic, dynamic> originalMap = this as Map<dynamic, dynamic>;
      final Map<String, dynamic> result = <String, dynamic>{};
      
      originalMap.forEach((key, value) {
        if (key is String) {
          result[key] = transformer(key, value);
        }
      });
      
      return result;
    }
    
    // For non-Map objects, return the original
    return this;
  }

  /// Merges this object with another object, with optional conflict resolution.
  /// 
  /// This method combines two objects, with the other object's values taking precedence
  /// unless a conflict resolver is provided.
  ///
  /// Example:
  /// ```dart
  /// final obj1 = {'name': 'John', 'age': 30};
  /// final obj2 = {'age': 31, 'city': 'NYC'};
  /// 
  /// final merged = obj1.merge(obj2);
  /// // Result: {'name': 'John', 'age': 31, 'city': 'NYC'}
  /// 
  /// final mergedWithResolver = obj1.merge(obj2, 
  ///   conflictResolver: (key, value1, value2) => value1 + value2);
  /// // Result: {'name': 'John', 'age': 61, 'city': 'NYC'}
  /// ```
  Object merge(Object? other, {dynamic Function(String key, dynamic value1, dynamic value2)? conflictResolver}) {
    if (other == null) return this;
    
    if (this is Map && other is Map) {
      final Map<dynamic, dynamic> thisMap = this as Map<dynamic, dynamic>;
      final Map<dynamic, dynamic> otherMap = other;
      final Map<String, dynamic> result = <String, dynamic>{};
      
      // Add all fields from this object
      thisMap.forEach((key, value) {
        if (key is String) {
          result[key] = value;
        }
      });
      
      // Add or merge fields from other object
      otherMap.forEach((key, value) {
        if (key is String) {
          if (result.containsKey(key) && conflictResolver != null) {
            result[key] = conflictResolver(key, result[key], value);
          } else {
            result[key] = value;
          }
        }
      });
      
      return result;
    }
    
    // For non-Map objects, return this object
    return this;
  }
} 