/**
 * Converts arbitrary values into double using extended conversion rules:
 * - Strings are converted to double values
 * - DateTime: total number of milliseconds since unix epoсh
 * - Boolean: 1 for true and 0 for false
 * 
 * ### Example ###
 * 
 *     var value1 = DoubleConverter.toNullableDouble("ABC"); // Result: null
 *     var value2 = DoubleConverter.toNullableDouble("123.456"); // Result: 123.456
 *     var value3 = DoubleConverter.toNullableDouble(true); // Result: 1
 *     var value4 = DoubleConverter.toNullableDouble(new Date()); // Result: current milliseconds
 */
class DoubleConverter {
  /**
     * Converts value into doubles or returns null when conversion is not possible.
     * 
     * - [value]     the value to convert.
     * Returns         double value or null when conversion is not supported.
     */
  static double toNullableDouble(value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is DateTime) return value.millisecondsSinceEpoch.toDouble();
    if (value is Duration) return value.inMilliseconds.toDouble();
    if (value is bool) return value ? 1 : 0;

    var result = double.tryParse(value.toString());
    return result;
  }

  /**
     * Converts value into doubles or returns 0 when conversion is not possible.
     * 
     * - [value]     the value to convert.
     * Returns         double value or 0 when conversion is not supported.
     * 
     * See [[toDoubleWithDefault]]
     */
  static double toDouble(value) {
    return DoubleConverter.toDoubleWithDefault(value, 0);
  }

  /**
     * Converts value into integer or returns default value when conversion is not possible.
     * 
     * - [value]         the value to convert.
     * - defaultValue  the default value.
     * Returns             double value or default when conversion is not supported.
     * 
     * See [[toNullableDouble]]
     */
  static double toDoubleWithDefault(value, double defaultValue) {
    var result = DoubleConverter.toNullableDouble(value);
    return result != null ? result : defaultValue;
  }
}
