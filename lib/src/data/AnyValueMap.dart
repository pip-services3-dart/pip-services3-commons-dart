import 'dart:collection';

import '../convert/TypeCode.dart';
import '../convert/TypeConverter.dart';
import '../convert/StringConverter.dart';
import '../convert/BooleanConverter.dart';
import '../convert/IntegerConverter.dart';
import '../convert/LongConverter.dart';
import '../convert/FloatConverter.dart';
import '../convert/DoubleConverter.dart';
import '../convert/DateTimeConverter.dart';
import '../convert/DurationConverter.dart';
import '../convert/MapConverter.dart';
import '../reflect/IValueWrapper.dart';

import './ICloneable.dart';
import './AnyValue.dart';
import './AnyValueArray.dart';

/// Cross-language implementation of dynamic object map (dictionary) what can hold values of any type.
/// The stored values can be converted to different types using variety of accessor methods.
///
/// ### Example ###
///
///     var value1 =  AnyValueMap({ key1: 1, key2: '123.456', key3: '2018-01-01' });
///
///     value1.getAsBoolean('key1');   // Result: true
///     value1.getAsInteger('key2');   // Result: 123
///     value1.getAsFloat('key2');     // Result: 123.456
///     value1.getAsDateTime('key3');  // Result:  Date(2018,0,1)
///
/// See [StringConverter]
/// See [TypeConverter]
/// See [BooleanConverter]
/// See [IntegerConverter]
/// See [LongConverter]
/// See [DoubleConverter]
/// See [FloatConverter]
/// See [DateTimeConverter]
/// See [ICloneable]

class AnyValueMap extends MapBase<dynamic, dynamic>
    implements ICloneable, IValueWrapper {
  Map<dynamic, dynamic> _values;

  /// Creates a new instance of the map and assigns its value.
  ///
  /// - value     (optional) values to initialize this map.

  AnyValueMap([values]) : _values = values ?? <dynamic, dynamic>{} {
    append(values);
  }

  /// Creates a new instance of the map from JSON.
  ///
  /// - [json]     values to initialize this map.

  factory AnyValueMap.fromJson(Map<String, dynamic> json) {
    return AnyValueMap(json);
  }

  /// Returned inner values in Map object
  @override
  dynamic innerValue() {
    return _values;
  }

  /// Returned JSON Map object from values of this object
  Map<dynamic, dynamic> toJson() {
    return _values;
  }

  /// Initialize this object from JSON Map object

  void fromJson(Map<String, dynamic> json) {
    _values = <String, dynamic>{};
    append(json);
  }

  /// Gets an map with values.
  ///
  /// Returns     the value of the map elements.

  Map<dynamic, dynamic> getValue() {
    return _values;
  }

  /// Gets a map element specified by its key.
  ///
  /// - [key]     a key of the element to get.
  /// Returns       the value of the map element.

  dynamic get(String key) {
    return _values[key];
  }

  /// Gets keys of all elements stored in this map.
  ///
  /// Returns a list with all map keys.

  List<String> getKeys() {
    var keys = <String>[];

    for (var key in _values.keys) {
      keys.add(key);
    }

    return keys;
  }

  /// Puts a new value into map element specified by its key.
  ///
  /// - [key]       a key of the element to put.
  /// - [value]     a new value for map element.

  void put(String key, dynamic value) {
    _values[key] = value;
  }

  /// Removes a map element specified by its key
  ///
  /// - [key]     a key of the element to remove.

  @override
  void remove(dynamic key) {
    _values.remove(key);
  }

  /// Appends new elements to this map.
  ///
  /// - [map]  a map with elements to be added.

  void append(map) {
    if (map == null) return;

    if (map is IValueWrapper) map = map.innerValue();

    if (map is Map) {
      var map_vals = <dynamic, dynamic>{};
      for (var key in map.keys) {
        var value = map[key];
        var objKey = StringConverter.toNullableString(key);
        if (objKey != null) map_vals[objKey] = value;
      }
      addAll(map_vals);
    }
  }

  /// Clears this map by removing all its elements.
  @override
  void clear() {
    _values.clear();
  }

  /// Gets the value stored in map element without any conversions.
  /// When element key is not defined it returns the entire map value.
  ///
  /// - key       (optional) a key of the element to get
  /// Returns the element value or value of the map when index is not defined.

  dynamic getAsObject([String? key]) {
    if (key == null) {
      var result = <String, dynamic>{};
      for (var key in _values.keys) {
        var value = _values[key];
        result[key] = value;
      }
      return result;
    } else {
      return _values[key];
    }
  }

  /// Sets a new value to map element specified by its index.
  /// When the index is not defined, it resets the entire map value.
  /// This method has double purpose because method overrides are not supported in JavaScript.
  ///
  /// - key       (optional) a key of the element to set
  /// - value     a new element or map value.
  ///
  /// See [MapConverter.toMap]

  void setAsObject(key, [value]) {
    if (value == null) {
      clear();
      var values = MapConverter.toMap(key);
      append(values);
    } else {
      _values[key] = value;
    }
  }

  /// Converts map element into a String or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns String value of the element or null if conversion is not supported.
  ///
  /// See [StringConverter.toNullableString]

  String? getAsNullableString(String key) {
    var value = get(key);
    return StringConverter.toNullableString(value);
  }

  /// Converts map element into a String or returns '' if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns String value of the element or '' if conversion is not supported.
  ///
  /// See [getAsStringWithDefault]

  String getAsString(String key) {
    return getAsStringWithDefault(key, '');
  }

  /// Converts map element into a String or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns String value of the element or default value if conversion is not supported.
  ///
  /// See [StringConverter.toStringWithDefault]

  String getAsStringWithDefault(String key, String defaultValue) {
    var value = get(key);
    return StringConverter.toStringWithDefault(value, defaultValue);
  }

  /// Converts map element into a boolean or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns boolean value of the element or null if conversion is not supported.
  ///
  /// See [BooleanConverter.toNullableBoolean]

  bool? getAsNullableBoolean(String key) {
    var value = get(key);
    return BooleanConverter.toNullableBoolean(value);
  }

  /// Converts map element into a boolean or returns false if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns boolean value of the element or false if conversion is not supported.
  ///
  /// See [getAsBooleanWithDefault]

  bool getAsBoolean(String key) {
    return getAsBooleanWithDefault(key, false);
  }

  /// Converts map element into a boolean or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns boolean value of the element or default value if conversion is not supported.
  ///
  /// See [BooleanConverter.toBooleanWithDefault]

  bool getAsBooleanWithDefault(String key, bool defaultValue) {
    var value = get(key);
    return BooleanConverter.toBooleanWithDefault(value, defaultValue);
  }

  /// Converts map element into an integer or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns integer value of the element or null if conversion is not supported.
  ///
  /// See [IntegerConverter.toNullableInteger]

  int? getAsNullableInteger(String key) {
    var value = get(key);
    return IntegerConverter.toNullableInteger(value);
  }

  /// Converts map element into an integer or returns 0 if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns integer value of the element or 0 if conversion is not supported.
  ///
  /// See [getAsIntegerWithDefault]

  int getAsInteger(String key) {
    return getAsIntegerWithDefault(key, 0);
  }

  /// Converts map element into an integer or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns integer value of the element or default value if conversion is not supported.
  ///
  /// See [IntegerConverter.toIntegerWithDefault]

  int getAsIntegerWithDefault(String key, int defaultValue) {
    var value = get(key);
    return IntegerConverter.toIntegerWithDefault(value, defaultValue);
  }

  /// Converts map element into a long or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns long value of the element or null if conversion is not supported.
  ///
  /// See [LongConverter.toNullableLong]

  int? getAsNullableLong(String key) {
    var value = get(key);
    return LongConverter.toNullableLong(value);
  }

  /// Converts map element into a long or returns 0 if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns long value of the element or 0 if conversion is not supported.
  ///
  /// See [getAsLongWithDefault]

  int getAsLong(String key) {
    return getAsLongWithDefault(key, 0);
  }

  /// Converts map element into a long or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns long value of the element or default value if conversion is not supported.
  ///
  /// See [LongConverter.toLongWithDefault]

  int getAsLongWithDefault(String key, int defaultValue) {
    var value = get(key);
    return LongConverter.toLongWithDefault(value, defaultValue);
  }

  /// Converts map element into a float or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns float value of the element or null if conversion is not supported.
  ///
  /// See [FloatConverter.toNullableFloat]

  double? getAsNullableFloat(String key) {
    var value = get(key);
    return FloatConverter.toNullableFloat(value);
  }

  /// Converts map element into a float or returns 0 if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns float value of the element or 0 if conversion is not supported.
  ///
  /// See [getAsFloatWithDefault]

  double getAsFloat(String key) {
    return getAsFloatWithDefault(key, 0);
  }

  /// Converts map element into a flot or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns flot value of the element or default value if conversion is not supported.
  ///
  /// See [FloatConverter.toFloatWithDefault]

  double getAsFloatWithDefault(String key, double defaultValue) {
    var value = get(key);
    return FloatConverter.toFloatWithDefault(value, defaultValue);
  }

  /// Converts map element into a double or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns double value of the element or null if conversion is not supported.
  ///
  /// See [DoubleConverter.toNullableDouble]

  double? getAsNullableDouble(String key) {
    var value = get(key);
    return DoubleConverter.toNullableDouble(value);
  }

  /// Converts map element into a double or returns 0 if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns double value of the element or 0 if conversion is not supported.
  ///
  /// See [getAsDoubleWithDefault]

  double getAsDouble(String key) {
    return getAsDoubleWithDefault(key, 0);
  }

  /// Converts map element into a double or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns double value of the element or default value if conversion is not supported.
  ///
  /// See [DoubleConverter.toDoubleWithDefault]

  double getAsDoubleWithDefault(String key, double defaultValue) {
    var value = get(key);
    return DoubleConverter.toDoubleWithDefault(value, defaultValue);
  }

  /// Converts map element into a DateTime or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns DateTime value of the element or null if conversion is not supported.
  ///
  /// See [DateTimeConverter.toNullableDateTime]

  DateTime? getAsNullableDateTime(String key) {
    var value = get(key);
    return DateTimeConverter.toNullableDateTime(value);
  }

  /// Converts map element into a DateTime or returns the current date if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns DateTime value of the element or the current date if conversion is not supported.
  ///
  /// See [getAsDateTimeWithDefault]

  DateTime getAsDateTime(String key) {
    return getAsDateTimeWithDefault(key, DateTime.now());
  }

  /// Converts map element into a DateTime or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns DateTime value of the element or default value if conversion is not supported.
  ///
  /// See [DateTimeConverter.toDateTimeWithDefault]

  DateTime getAsDateTimeWithDefault(String key, DateTime defaultValue) {
    var value = get(key);
    return DateTimeConverter.toDateTimeWithDefault(value, defaultValue);
  }

  /// Converts map element into a Duration or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns Duration value of the element or null if conversion is not supported.
  ///
  /// See [DurationConverter.toNullableDuration]

  Duration? getAsNullableDuration(String key) {
    var value = get(key);
    return DurationConverter.toNullableDuration(value);
  }

  /// Converts map element into a Duration or returns the current date if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns Duration value of the element or the current date if conversion is not supported.
  ///
  /// See [getAsDurationWithDefault]

  Duration getAsDuration(String key) {
    return getAsDurationWithDefault(key, Duration.zero);
  }

  /// Converts map element into a Duration or returns default value if conversion is not possible.
  ///
  /// - [key]           a key of element to get.
  /// - defaultValue  the default value
  /// Returns Duration value of the element or default value if conversion is not supported.
  ///
  /// See [DurationConverter.toDurationWithDefault]

  Duration getAsDurationWithDefault(String key, Duration defaultValue) {
    var value = get(key);
    return DurationConverter.toDurationWithDefault(value, defaultValue);
  }

  /// Converts map element into a value defined by specied typecode.
  /// If conversion is not possible it returns null.
  ///
  /// - type      the TypeCode that defined the type of the result
  /// - [key]       a key of element to get.
  /// Returns element value defined by the typecode or null if conversion is not supported.
  ///
  /// See [TypeConverter.toNullabvarype]

  T? getAsNullableType<T>(TypeCode type, String key) {
    var value = get(key);
    return TypeConverter.toNullableType<T>(type, value);
  }

  /// Converts map element into a value defined by specied typecode.
  /// If conversion is not possible it returns default value for the specified type.
  ///
  /// - type      the TypeCode that defined the type of the result
  /// - [key]       a key of element to get.
  /// Returns element value defined by the typecode or default if conversion is not supported.
  ///
  /// See [getAsTypeWithDefault]

  T? getAsType<T>(TypeCode type, String key) {
    var defaultValue = T as T;
    return getAsTypeWithDefault<T>(type, key, defaultValue);
  }

  /// Converts map element into a value defined by specied typecode.
  /// If conversion is not possible it returns default value.
  ///
  /// - type          the TypeCode that defined the type of the result
  /// - [key]       a key of element to get.
  /// - defaultValue  the default value
  /// Returns element value defined by the typecode or default value if conversion is not supported.
  ///
  /// See [TypeConverter.toTypeWithDefault]

  T getAsTypeWithDefault<T>(TypeCode type, String key, T defaultValue) {
    var value = get(key);
    return TypeConverter.toTypeWithDefault(type, value, defaultValue);
  }

  /// Converts map element into an AnyValue or returns an empty AnyValue if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns AnyValue value of the element or empty AnyValue if conversion is not supported.
  ///
  /// See [AnyValue]
  /// See [AnyValue.constructor]

  AnyValue getAsValue(String key) {
    var value = get(key);
    return AnyValue(value);
  }

  /// Converts map element into an AnyValueArray or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns AnyValueArray value of the element or null if conversion is not supported.
  ///
  /// See [AnyValueArray]
  /// See [AnyValueArray.fromValue]

  AnyValueArray? getAsNullableArray(String key) {
    var value = get(key);
    return value != null ? AnyValueArray.fromValue(value) : null;
  }

  /// Converts map element into an AnyValueArray or returns empty AnyValueArray if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns AnyValueArray value of the element or empty AnyValueArray if conversion is not supported.
  ///
  /// See [AnyValueArray]
  /// See [AnyValueArray.fromValue]

  AnyValueArray getAsArray(String key) {
    var value = get(key);
    return AnyValueArray.fromValue(value);
  }

  /// Converts map element into an AnyValueArray or returns default value if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// - defaultValue  the default value
  /// Returns AnyValueArray value of the element or default value if conversion is not supported.
  ///
  /// See [AnyValueArray]
  /// See [getAsNullableArray]

  AnyValueArray getAsArrayWithDefault(String key, AnyValueArray defaultValue) {
    var result = getAsNullableArray(key);
    return result ?? defaultValue;
  }

  /// Converts map element into an AnyValueMap or returns null if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns AnyValueMap value of the element or null if conversion is not supported.
  ///
  /// See [fromValue]

  AnyValueMap? getAsNullableMap(String key) {
    var value = get(key);
    return value != null ? AnyValueMap.fromValue(value) : null;
  }

  /// Converts map element into an AnyValueMap or returns empty AnyValueMap if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// Returns AnyValueMap value of the element or empty AnyValueMap if conversion is not supported.
  ///
  /// See [fromValue]

  AnyValueMap getAsMap(String key) {
    var value = get(key);
    return AnyValueMap.fromValue(value);
  }

  /// Converts map element into an AnyValueMap or returns default value if conversion is not possible.
  ///
  /// - [key]       a key of element to get.
  /// - defaultValue  the default value
  /// Returns AnyValueMap value of the element or default value if conversion is not supported.
  ///
  /// See [getAsNullableMap]

  AnyValueMap getAsMapWithDefault(String key, AnyValueMap defaultValue) {
    var result = getAsNullableMap(key);
    return result ?? defaultValue;
  }

  /// Gets a String representation of the object.
  /// The result is a semicolon-separated list of key-value pairs as
  /// 'key1=value1;key2=value2;key=value3'
  ///
  /// Returns a String representation of the object.

  @override
  String toString() {
    var builder = '';

    // Todo: User encoder
    for (var key in _values.keys) {
      var value = _values[key];

      if (builder.isNotEmpty) builder += ';';

      if (value != null) {
        builder += key + '=' + value.toString();
      } else {
        builder += key;
      }
    }

    return builder;
  }

  /// Creates a binary clone of this object.
  ///
  /// Returns a clone of this object.

  @override
  dynamic clone() {
    return AnyValueMap(_values);
  }

  /// Converts specified value into AnyValueMap.
  ///
  /// - [value]     value to be converted
  /// Returns         a newly created AnyValueMap.
  ///
  /// See [setAsObject]

  static AnyValueMap fromValue(dynamic value) {
    var result = AnyValueMap();
    result.setAsObject(value);
    return result;
  }

  /// Creates a new AnyValueMap from a list of key-value pairs called tuples.
  ///
  /// - [tuples]    a list of values where odd elements are keys and the following even elements are values
  /// Returns         a newly created AnyValueArray.
  ///
  /// See [fromTuplesArray]

  static AnyValueMap fromTuples(List tuples) {
    return AnyValueMap.fromTuplesArray(tuples);
  }

  /// Creates a new AnyValueMap from a list of key-value pairs called tuples.
  /// The method is similar to [fromTuples] but tuples are passed as array instead of parameters.
  ///
  /// - [tuples]    a list of values where odd elements are keys and the following even elements are values
  /// Returns         a newly created AnyValueArray.

  static AnyValueMap fromTuplesArray(List? tuples) {
    var result = AnyValueMap();
    if (tuples == null || tuples.isEmpty) return result;

    for (var index = 0; index < tuples.length; index += 2) {
      if (index + 1 >= tuples.length) break;

      var name = StringConverter.toNullableString(tuples[index]);
      var value = tuples[index + 1];

      result.setAsObject(name, value);
    }

    return result;
  }

  /// Creates a new AnyValueMap by merging two or more maps.
  /// Maps defined later in the list override values from previously defined maps.
  ///
  /// - [maps]  an array of maps to be merged
  /// Returns     a newly created AnyValueMap.

  static AnyValueMap fromMaps(List? maps) {
    var result = AnyValueMap();
    if (maps != null && maps.isNotEmpty) {
      for (var index = 0; index < maps.length; index++) {
        result.append(maps[index]);
      }
    }
    return result;
  }

  @override
  dynamic operator [](dynamic key) {
    return _values[key];
  }

  @override
  void operator []=(dynamic key, dynamic value) {
    _values[key] = value;
  }

  @override
  Iterable<dynamic> get keys => _values.keys;

  @override
  Iterable<dynamic> get values => _values.values;
}
