/// Converts arbitrary values into array objects.
///
/// ### Example ###
///
///     var value1 = ArrayConverter.toArray([1, 2]);		 // Result: [1, 2]
///     var value2 = ArrayConverter.toArray(1);			  // Result: [1]
///     var value2 = ArrayConverter.listToArray('1,2,3');	// Result: ['1', '2', '3']

class ArrayConverter {
  /// Converts value into array object.
  /// Single values are converted into arrays with a single element.
  ///
  /// - [value]     the value to convert.
  /// Returns         array object or null when value is null.

  static List toNullableArray(value) {
    // Return null when nothing found
    if (value == null) return null;

    // Convert list
    if (value is List) {
      return value;
    } else if (value is Map) {
      var result = [];
      for (var item in value.values) {
        result.add(item);
      }
      return result;
    } else if (value is Iterable) {
      var result = [];
      for (var item in value) {
        result.add(item);
      }
      return result;
    }
    // Convert single values
    else {
      return [value];
    }
  }

  /// Converts value into array object with empty array as default.
  /// Single values are converted into arrays with single element.
  ///
  /// - [value]     the value to convert.
  /// Returns			array object or empty array when value is null.
  ///
  /// See [[toNullableArray]]

  static List toArray(value) {
    var result = ArrayConverter.toNullableArray(value);
    return result ?? [];
  }

  /// Converts value into array object with specified default.
  /// Single values are converted into arrays with single element.
  ///
  /// - [value]         the value to convert.
  /// - [defaultValue]  default array object.
  /// Returns				array object or default array when value is null.
  ///
  /// See [[toNullableArray]]

  static List toArrayWithDefault(value, List defaultValue) {
    var result = ArrayConverter.toNullableArray(value);
    return result ?? defaultValue;
  }

  /// Converts value into array object with empty array as default.
  /// Strings with comma-delimited values are split into array of strings.
  ///
  /// - [value] 	the list to convert.
  /// Returns			array object or empty array when value is null
  ///
  /// See [[toArray]]

  static List listToArray(value) {
    if (value == null) return [];
    if (value is String) value = value.split(',');
    return ArrayConverter.toArray(value);
  }
}
