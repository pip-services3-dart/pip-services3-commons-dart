import '../../pip_services3_commons.dart';
import '../convert/TypeCode.dart';
import '../convert/TypeConverter.dart';
import '../convert/DateTimeConverter.dart';

/// Helper class matches value types for equality.
///
/// This class has symmetric implementation across all languages supported
/// by Pip.Services toolkit and used to support dynamic data processing.
///
/// See [TypeCode]

class TypeMatcher {
  /// Matches expected type to a type of a value.
  /// The expected type can be specified by a type, type name or [TypeCode].
  ///
  /// - [expectedType]      an expected type to match.
  /// - [actualValue]       a value to match its type to the expected one.
  /// Returns true if types are matching and false if they don't.
  ///
  /// See [matchType]
  /// See [matchValueTypeByName] (for matching by types' string names)

  static bool matchValueType(expectedType, actualValue) {
    if (expectedType == null) return true;
    if (actualValue == null) throw Exception('Actual value cannot be null');

    return matchType(expectedType, TypeConverter.toTypeCode(actualValue));
  }

  /// Matches expected type to an actual type.
  /// The types can be specified as types, type names or [TypeCode].
  ///
  /// - [expectedType]  an expected type to match.
  /// - [actualType]    an actual type to match.
  /// - [actualValue]   an optional value to match its type to the expected one.
  /// Returns true if types are matching and false if they don't.
  ///
  /// See [matchTypeByName]
  /// See [matchTypeByName] (for matching by types' string names)

  static bool matchType(expectedType, TypeCode actualType, [actualValue]) {
    if (expectedType == null) return true;
    // if (actualType == null) throw Exception('Actual type cannot be null');

    if (expectedType is TypeCode) {
      if (expectedType == actualType) return true;
      // Special provisions for dynamic data
      if (expectedType == TypeCode.Integer &&
          (actualType == TypeCode.Long ||
              actualType == TypeCode.Float ||
              actualType == TypeCode.Double)) return true;
      if (expectedType == TypeCode.Long &&
          (actualType == TypeCode.Integer ||
              actualType == TypeCode.Float ||
              actualType == TypeCode.Double)) return true;
      if (expectedType == TypeCode.Float &&
          (actualType == TypeCode.Integer ||
              actualType == TypeCode.Long ||
              actualType == TypeCode.Double)) return true;
      if (expectedType == TypeCode.Double &&
          (actualType == TypeCode.Integer ||
              actualType == TypeCode.Long ||
              actualType == TypeCode.Float)) return true;
      if (expectedType == TypeCode.DateTime &&
          (actualType == TypeCode.String &&
              DateTimeConverter.toNullableDateTime(actualValue) != null)) {
        return true;
      }
      return false;
    }

    if (expectedType is String) {
      return matchTypeByName(expectedType, actualType, actualValue);
    }

    return false;
  }

  /// Matches expected type to a type of a value.
  ///
  /// - [expectedType]  an expected type name to match.
  /// - [actualValue]       a value to match its type to the expected one.
  /// Returns true if types are matching and false if they don't.

  static bool matchValueTypeByName(String expectedType, actualValue) {
    // if (expectedType == null) return true;
    // if (actualValue == null) throw Exception('Actual value cannot be null');

    return matchTypeByName(expectedType, TypeConverter.toTypeCode(actualValue));
  }

  /// Matches expected type to an actual type.
  ///
  /// - [expectedType]  an expected type name to match.
  /// - [actualType]    an actual type to match defined by type code.
  /// - [actualValue]   an optional value to match its type to the expected one.
  /// Returns true if types are matching and false if they don't.

  static bool matchTypeByName(String? expectedType, TypeCode actualType,
      [actualValue]) {
    if (expectedType == null) return true;
    // if (actualType == null) throw Exception('Actual type cannot be null');

    expectedType = expectedType.toLowerCase();

    if (expectedType == 'object') {
      return true;
    } else if (expectedType == 'int' || expectedType == 'integer') {
      return actualType == TypeCode.Integer
          // Special provisions for dynamic data
          ||
          actualType == TypeCode.Long;
    } else if (expectedType == 'long') {
      return actualType == TypeCode.Long
          // Special provisions for dynamic data
          ||
          actualType == TypeCode.Integer;
    } else if (expectedType == 'float') {
      return actualType == TypeCode.Float
          // Special provisions for dynamic data
          ||
          actualType == TypeCode.Double ||
          actualType == TypeCode.Integer ||
          actualType == TypeCode.Long;
    } else if (expectedType == 'double') {
      return actualType == TypeCode.Double
          // Special provisions for dynamic data
          ||
          actualType == TypeCode.Float;
    } else if (expectedType == 'string') {
      return actualType == TypeCode.String;
    } else if (expectedType == 'bool' || expectedType == 'boolean') {
      return actualType == TypeCode.Boolean;
    } else if (expectedType == 'date' || expectedType == 'datetime') {
      return actualType == TypeCode.DateTime
          // Special provisions for dynamic data
          ||
          (actualType == TypeCode.String &&
              DateTimeConverter.toNullableDateTime(actualValue) != null);
    } else if (expectedType == 'timespan' || expectedType == 'duration') {
      return actualType == TypeCode.Duration
          // Special provisions for dynamic data
          ||
          actualType == TypeCode.Integer ||
          actualType == TypeCode.Long;
    } else if (expectedType == 'enum') {
      return actualType == TypeCode.Integer || actualType == TypeCode.String;
    } else if (expectedType == 'map' ||
        expectedType == 'dict' ||
        expectedType == 'dictionary') {
      return actualType == TypeCode.Map;
    } else if (expectedType == 'array' || expectedType == 'list') {
      return actualType == TypeCode.Array;
    } else if (expectedType.endsWith('[]')) {
      // Todo: Check subtype
      return actualType == TypeCode.Array;
    } else {
      return false;
    }
  }
}
