import '../reflect/ObjectReader.dart';

/// Converts arbitrary values into map objects using extended conversion rules.
/// This class is similar to [[MapConverter]], but is recursively converts all values
/// stored in objects and arrays.
/// 
/// ### Example ###
/// 
///     var value1 = RecursiveMapConverted.toNullableMap('ABC'); // Result: null
///     var value2 = RecursiveMapConverted.toNullableMap({ 'key': 123 }); // Result: { 'key': 123 }
///     var value3 = RecursiveMapConverted.toNullableMap([1,[2,3]); // Result: { '0': 1, { '0': 2, '1': 3 } }
 
class RecursiveMapConverter {
  static _objectToMap(value) {
    if (value == null) return null;

    // Todo: Complete implementation...
    var result = new Map<String, dynamic>();
    var props = ObjectReader.getPropertyNames(value);

    for (var i = 0; i < props.length; i++) {
        var propValue = value[props[i]];
        propValue = RecursiveMapConverter._valueToMap(propValue);
        result[props[i]] = propValue;
    }

    //return result;
    return null;
  }

  static _isPrimitive(value) {
    if (value == null)
      return true;
    else if (value is num)
      return true;
    else if (value is DateTime)
      return true;
    else if (value is Duration)
      return true;
    else if (value is String)
      return true;
    else if (value is bool) return true;

    return false;
  }

  static _valueToMap(value) {
    if (value == null) return null;

    // Skip expected non-primitive values
    if (value is String) return value;

    // Skip primitive values
    if (_isPrimitive(value)) return value;

    if (value is Map) return _mapToMap(value);

    // Convert arrays
    if (value is List) return _arrayToMap(value);

    return _objectToMap(value);
  }

  static _mapToMap(Map value) {
    var result = new Map<String, dynamic>();
    for (var key in value.keys) {
      result[key.toString()] = _valueToMap(value[key]);
    }
    return result;
  }

  static _arrayToMap(List value) {
    var result = new Map<String, dynamic>();

    for (var i = 0; i < value.length; i++) {
      result[i.toString()] = _valueToMap(value[i]);
    }

    return result;
  }

  
    /// Converts value into map object or returns null when conversion is not possible.
    /// 
    /// - [value]     the value to convert.
    /// Returns         map object or null when conversion is not supported.
     
  static toNullableMap(value) {
    return _valueToMap(value);
  }

  
    /// Converts value into map object or returns empty map when conversion is not possible
    /// 
    /// - [value]     the value to convert.
    /// Returns         map object or empty map when conversion is not supported.
    /// 
    /// See [[toNullableMap]]
     
  static toMap(value) {
    var result = RecursiveMapConverter.toNullableMap(value);
    return result != null ? result : new Map<String, dynamic>();
  }

  
    /// Converts value into map object or returns default when conversion is not possible
    /// 
    /// - [value]         the value to convert.
    /// - defaultValue  the default value.
    /// Returns             map object or emptu map when conversion is not supported.
    /// 
    /// See [[toNullableMap]]
     
  static toMapWithDefault(value, Map<String, dynamic> defaultValue) {
    var result = RecursiveMapConverter.toNullableMap(value);
    return result != null ? result : defaultValue;
  }
}
