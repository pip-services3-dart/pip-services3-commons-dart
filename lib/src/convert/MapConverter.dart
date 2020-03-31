/**
 * Converts arbitrary values into map objects using extended conversion rules:
 * - Objects: property names as keys, property values as values
 * - Arrays: element indexes as keys, elements as values
 * 
 * ### Example ###
 * 
 *     var value1 = MapConverted.toNullableMap("ABC"); // Result: null
 *     var value2 = MapConverted.toNullableMap({ "key": 123 }); // Result: { "key": 123 }
 *     var value3 = MapConverted.toNullableMap([1,2,3]); // Result: { "0": 1, "1": 2, "2": 3 }
 */
class MapConverter {
  /**
     * Converts value into map object or returns null when conversion is not possible.
     * 
     * - [value]     the value to convert.
     * Returns         map object or null when conversion is not supported.
     */
  static Map<String, dynamic> toNullableMap(value) {
    if (value == null)
      return null;
    else if (value is Map<String, dynamic>) return value;

    if (value is Map) {
      var result = new Map<String, dynamic>();
      for (var key in value.keys) {
        result[key.toString()] = value[key];
      }
      return result;
    }

    if (value is List) {
      var result = new Map<String, dynamic>();
      for (var i = 0; i < value.length; i++) result[i.toString()] = value[i];
      return result;
    }

    try {
      // Todo: Complete implementation...
      // return RecursiveMapConverter.ToNullableMap(value);
      return null;
    } catch (e) {
      return null;
    }
  }

  /**
     * Converts value into map object or returns empty map when conversion is not possible
     * 
     * - [value]     the value to convert.
     * Returns         map object or empty map when conversion is not supported.
     * 
     * See [[toNullableMap]]
     */
  static Map<String, dynamic> toMap(value) {
    var result = MapConverter.toNullableMap(value);
    return result != null ? result : new Map<String, dynamic>();
  }

  /**
     * Converts value into map object or returns default when conversion is not possible
     * 
     * - [value]         the value to convert.
     * - defaultValue  the default value.
     * Returns             map object or emptu map when conversion is not supported.
     * 
     * See [[toNullableMap]]
     */
  static Map<String, dynamic> toMapWithDefault(
      value, Map<String, dynamic> defaultValue) {
    var result = MapConverter.toNullableMap(value);
    return result != null ? result : defaultValue;
  }
}
