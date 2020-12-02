/// Converts arbitrary values into longs using extended conversion rules:
/// - Strings are converted to floats, then to longs
/// - DateTime: total number of milliseconds since unix epoсh
/// - Boolean: 1 for true and 0 for false
///
/// ### Example ###
///
///     var value1 = LongConverter.toNullableLong('ABC'); // Result: null
///     var value2 = LongConverter.toNullableLong('123.456'); // Result: 123
///     var value3 = LongConverter.toNullableLong(true); // Result: 1
///     var value4 = LongConverter.toNullableLong(new Date()); // Result: current milliseconds

class LongConverter {
  /// Converts value into long or returns null when conversion is not possible.
  ///
  /// - [value]     the value to convert.
  /// Returns         long value or null when conversion is not supported.

  static int toNullableLong(value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.ceil();
    if (value is DateTime) return value.millisecondsSinceEpoch;
    if (value is Duration) return value.inMilliseconds;
    if (value is bool) return value ? 1 : 0;

    var result = double.tryParse(value.toString());
    return result == null ? null : result.truncate();
  }

  /// Converts value into long or returns 0 when conversion is not possible.
  ///
  /// - [value]     the value to convert.
  /// Returns         long value or 0 when conversion is not supported.
  ///
  /// See [toLongWithDefault]

  static int toLong(value) {
    return LongConverter.toLongWithDefault(value, 0);
  }

  /// Converts value into integer or returns default when conversion is not possible.
  ///
  /// - [value]         the value to convert.
  /// - defaultValue  the default value.
  /// Returns             long value or default when conversion is not supported
  ///
  /// See [toNullableLong]

  static int toLongWithDefault(value, int defaultValue) {
    var result = LongConverter.toNullableLong(value);
    return result ?? defaultValue;
  }
}
