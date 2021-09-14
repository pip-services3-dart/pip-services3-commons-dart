/// Converts arbitrary values into Date values using extended conversion rules:
/// - Strings: converted using ISO time format
/// - Numbers: converted using milliseconds since unix epoch
///
/// ### Example ###
///
///     var value1 = DurationConverter.toNullableDuration('ABC'); // Result: null
///     var value2 = DurationConverter.toNullableDuration('123'); // Result: Duration(milliseconds: 123)
///     var value3 = DurationConverter.toNullableDuration(123); // Result: Duration(milliseconds: 123)

class DurationConverter {
  /// Converts value into Date or returns null when conversion is not possible.
  ///
  /// - [value]     the value to convert.
  /// Returns         Date value or null when conversion is not supported.

  static Duration? toNullableDuration(value) {
    if (value == null) return null;
    if (value is Duration) return value;
    if (value is Duration) value = value.inMilliseconds;
    if (value is num) return Duration(milliseconds: value.toInt());

    var parsed = double.tryParse(value.toString());
    var result = parsed != null ? parsed.truncate() : parsed;

    return result != null ? Duration(milliseconds: result.toInt()) : null;
  }

  /// Converts value into Date or returns current date when conversion is not possible.
  ///
  /// - [value]     the value to convert.
  /// Returns         Date value or current date when conversion is not supported.
  ///
  /// See [toDurationWithDefault]

  static Duration toDuration(value) {
    return DurationConverter.toDurationWithDefault(value, Duration());
  }

  /// Converts value into Date or returns default when conversion is not possible.
  ///
  /// - [value]         the value to convert.
  /// - defaultValue  the default value.
  /// Returns             Date value or default when conversion is not supported.
  ///
  /// See [toNullableDuration]

  static Duration toDurationWithDefault(value, Duration defaultValue) {
    var result = DurationConverter.toNullableDuration(value);
    return result ?? defaultValue;
  }
}
