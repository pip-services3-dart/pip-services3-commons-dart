import "dart:convert";

import "./TypeCode.dart";
import "./TypeConverter.dart";
import "./MapConverter.dart";

/**
 * Converts arbitrary values from and to JSON (JavaScript Object Notation) strings.
 * 
 * ### Example ###
 * 
 *     var value1 = JsonConverter.fromJson("{\"key\":123}"); // Result: { "key": 123 }
 *     var value2 = JsonConverter.toMap({ key: 123 }); // Result: "{ "key": 123 }"
 * 
 * @see [[TypeCode]]
 */
class JsonConverter {

	/**
	 * Converts JSON string into a value of type specified by a TypeCode.
	 * 
	 * @param type 		the TypeCode for the data type into which 'value' is to be converted.
	 * @param value 	the JSON string to convert.
	 * @returns			converted object value or null when value is null.
	 */
	static T fromJson<T>(TypeCode type, String value) {
		if (value == null) return null;
    try {
      var temp = jsonDecode(value);
      return TypeConverter.toType<T>(type, temp);
    } catch (e) {
      return null;
    }
	}

  static Object _toEncodable(Object value) {
      if (value is DateTime)
          return value.toIso8601String();
      if (value is Duration)
          return value.inMilliseconds;

      return null;
  }

	/**
	 * Converts value into JSON string.
	 * 
	 * @param value 	the value to convert.
	 * @returns			JSON string or null when value is null.
	 */
	static String toJson(value) {
		if (value == null) return null;
		return jsonEncode(value, toEncodable: _toEncodable);
	}

	/**
	 * Converts JSON string into map object or returns null when conversion is not possible.
	 * 
	 * @param value 	the JSON string to convert.
	 * @returns			Map object value or null when conversion is not supported.
	 * 
	 * @see [[MapConverter.toNullableMap]]
	 */
	static Map<String, dynamic> toNullableMap(String value) {
		if (value == null) return null;

		try {
			var map = jsonDecode(value);
			return MapConverter.toNullableMap(map);
		} catch (e) {
			return null;
		}
	}

	/**
	 * Converts JSON string into map object or returns empty map when conversion is not possible.
	 * 
	 * @param value 	the JSON string to convert.
	 * @returns 		Map object value or empty object when conversion is not supported.
	 * 
	 * @see [[toNullableMap]]
	 */
	static Map<String, dynamic> toMap(String value) {
		var result = JsonConverter.toNullableMap(value);
		return result != null ? result : new Map<String, dynamic>();
	}

	/**
     * Converts JSON string into map object or returns default value when conversion is not possible.
     * 
     * @param value         the JSON string to convert.
     * @param defaultValue  the default value.
	 * @returns				Map object value or default when conversion is not supported.
     * 
     * @see [[toNullableMap]]
     */
	static Map<String, dynamic> toMapWithDefault(String value, Map<String, dynamic> defaultValue) {
		var result = JsonConverter.toNullableMap(value);
		return result != null ? result : defaultValue;
	}

}
