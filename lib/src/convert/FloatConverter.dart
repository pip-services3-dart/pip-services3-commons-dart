import 'DoubleConverter.dart';

/// Converts arbitrary values into float using extended conversion rules:
/// - Strings are converted to float values
/// - DateTime: total number of milliseconds since unix epoсh
/// - Boolean: 1 for true and 0 for false
///
/// ### Example ###
///
///     var value1 = FloatConverter.toNullableFloat('ABC'); // Result: null
///     var value2 = FloatConverter.toNullableFloat('123.456'); // Result: 123.456
///     var value3 = FloatConverter.toNullableFloat(true); // Result: 1
///     var value4 = FloatConverter.toNullableFloat( Date()); // Result: current milliseconds

class FloatConverter {
  /// Converts value into float or returns null when conversion is not possible.
  ///
  /// - [value]     the value to convert.
  /// Returns         float value or null when conversion is not supported.
  ///
  /// See [DoubleConverter.toNullableDouble]

  static double toNullableFloat(value) {
    return DoubleConverter.toNullableDouble(value);
  }

  /// Converts value into float or returns 0 when conversion is not possible.
  ///
  /// - [value]     the value to convert.
  /// Returns         float value or 0 when conversion is not supported.
  ///
  /// See [DoubleConverter.toDouble]
  /// See [DoubleConverter.toDoubleWithDefault]

  static double toFloat(value) {
    return DoubleConverter.toDouble(value);
  }

  /// Converts value into float or returns default when conversion is not possible.
  ///
  /// - [value]         the value to convert.
  /// - defaultValue  the default value.
  /// Returns             float value or default value when conversion is not supported.
  ///
  /// See [DoubleConverter.toDoubleWithDefault]
  /// See [DoubleConverter.toNullableDouble]

  static double toFloatWithDefault(value, double defaultValue) {
    return DoubleConverter.toDoubleWithDefault(value, defaultValue);
  }
}
