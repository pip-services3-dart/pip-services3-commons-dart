/**
 * Converts arbitrary values into strings using extended conversion rules:
 * - Numbers: are converted with '.' as decimal point
 * - DateTime: using ISO format
 * - Boolean: "true" for true and "false" for false
 * - Arrays: as comma-separated list
 * - Other objects: using <code>toString()</code> method
 * 
 * ### Example ###
 * 
 *     var value1 = StringConverter.ToString(123.456); // Result: "123.456"
 *     var value2 = StringConverter.ToString(true); // Result: "true"
 *     var value3 = StringConverter.ToString(new Date(2018,0,1)); // Result: "2018-01-01T00:00:00.00"
 *     var value4 = StringConverter.ToString([1,2,3]); // Result: "1,2,3"
 */
class StringConverter {
  /**
     * Converts value into string or returns null when value is null.
     * 
     * @param value     the value to convert.
     * @returns         string value or null when value is null.
     */
  static String toNullableString(value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is DateTime) return value.toIso8601String();
    return value.toString();
  }

  /**
     * Converts value into string or returns "" when value is null.
     * 
     * @param value     the value to convert.
     * @returns         string value or "" when value is null.
     * 
     * @see [[toStringWithDefault]]
     */
  static String toString2(value) {
    return StringConverter.toStringWithDefault(value, "");
  }

  /**
     * Converts value into string or returns default when value is null.
     * 
     * @param value         the value to convert.
     * @param defaultValue  the default value.
     * @returns             string value or default when value is null.
     * 
     * @see [[toNullableString]]
     */
  static toStringWithDefault(value, String defaultValue) {
    var result = StringConverter.toNullableString(value);
    return result != null ? result : defaultValue;
  }
}
