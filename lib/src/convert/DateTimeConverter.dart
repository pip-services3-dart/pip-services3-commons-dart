/**
 * Converts arbitrary values into Date values using extended conversion rules:
 * - Strings: converted using ISO time format
 * - Numbers: converted using milliseconds since unix epoch
 * 
 * ### Example ###
 * 
 *     var value1 = DateTimeConverter.toNullableDateTime("ABC"); // Result: null
 *     var value2 = DateTimeConverter.toNullableDateTime("2018-01-01T11:30:00.0"); // Result: Date(2018,0,1,11,30)
 *     var value3 = DateTimeConverter.toNullableDateTime(123); // Result: Date(123)
 */
class DateTimeConverter {

    /**
     * Converts value into Date or returns null when conversion is not possible.
     * 
     * @param value     the value to convert.
     * @returns         Date value or null when conversion is not supported.
     */
    static DateTime toNullableDateTime(value) {
        if (value == null) return null;
        if (value is DateTime) return value;
        if (value is Duration) value = value.millisecondsSinceEpoch;
        if (value is num) return new DateTime.fromMillisecondsSinceEpoch(value);

        var result = DateTime.tryParse(value.toString());
        return result;
    }

    /**
     * Converts value into Date or returns current date when conversion is not possible.
     * 
     * @param value     the value to convert.
     * @returns         Date value or current date when conversion is not supported.
     * 
     * @see [[toDateTimeWithDefault]]
     */
    static DateTime toDateTime(value) {
        return DateTimeConverter.toDateTimeWithDefault(value, DateTime.now());
    }

    /**
     * Converts value into Date or returns default when conversion is not possible.
     * 
     * @param value         the value to convert.
     * @param defaultValue  the default value.
     * @returns             Date value or default when conversion is not supported.
     * 
     * @see [[toNullableDateTime]]
     */
    static DateTime toDateTimeWithDefault(value, DateTime defaultValue) {
        var result = DateTimeConverter.toNullableDateTime(value);
        return result != null ? result : defaultValue;
    }

}