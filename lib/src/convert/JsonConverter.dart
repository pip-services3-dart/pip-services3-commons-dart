import 'dart:convert';

import './TypeCode.dart';
import './TypeConverter.dart';
import './MapConverter.dart';

/// Converts arbitrary values from and to JSON (JavaScript Object Notation) strings.
///
/// ### Example ###
///
///     var value1 = JsonConverter.fromJson('{\'key\':123}'); // Result: { 'key': 123 }
///     var value2 = JsonConverter.toMap({ 'key': 123 }); // Result: '{ 'key': 123 }'
///
/// See [TypeCode]

class JsonConverter {
  /// Converts JSON string into a value of type specified by a TypeCode.
  ///
  /// - [type] 		the TypeCode for the data type into which 'value' is to be converted.
  /// - value 	the JSON string to convert.
  /// Returns			converted object value or null when value is null.

  static T? fromJson<T>(TypeCode? type, String value) {
    try {
      var temp = jsonDecode(value);
      return TypeConverter.toType<T>(type, temp);
    } catch (e) {
      return null;
    }
  }

  static Object? _toEncodable(Object? value) {
    if (value is DateTime) return value.toIso8601String();
    if (value is Duration) return value.inMilliseconds;

    try {
      return (value as dynamic).toJson();
    } on NoSuchMethodError {
      return null;
    }
  }

  /// Converts value into JSON string.
  ///
  /// - [value] 	the value to convert.
  /// Returns			JSON string or null when value is null.

  static String? toJson(value) {
    if (value == null) return null;
    return jsonEncode(value, toEncodable: _toEncodable);
  }

  /// Converts JSON string into map object or returns null when conversion is not possible.
  ///
  /// - [value] 	the JSON string to convert.
  /// Returns			Map object value or null when conversion is not supported.
  ///
  /// See [MapConverter.toNullableMap]

  static Map<String, dynamic>? toNullableMap(String? value) {
    if (value == null) return null;

    try {
      var map = jsonDecode(value);
      return MapConverter.toNullableMap(map);
    } catch (e) {
      return null;
    }
  }

  /// Converts JSON string into map object or returns empty map when conversion is not possible.
  ///
  /// - [value] 	the JSON string to convert.
  /// Returns 		Map object value or empty object when conversion is not supported.
  ///
  /// See [toNullableMap]

  static Map<String, dynamic> toMap(String value) {
    var result = JsonConverter.toNullableMap(value);
    return result ?? <String, dynamic>{};
  }

  /// Converts JSON string into map object or returns default value when conversion is not possible.
  ///
  /// - [value]         the JSON string to convert.
  /// - defaultValue  the default value.
  /// Returns				Map object value or default when conversion is not supported.
  ///
  /// See [toNullableMap]

  static Map<String, dynamic> toMapWithDefault(
      String value, Map<String, dynamic> defaultValue) {
    var result = JsonConverter.toNullableMap(value);
    return result ?? defaultValue;
  }
}
