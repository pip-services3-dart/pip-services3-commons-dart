/**
 * Converts arbitrary values into array objects.
 * 
 * ### Example ###
 * 
 *     var value1 = ArrayConverter.toArray([1, 2]);		 // Result: [1, 2]
 *     var value2 = ArrayConverter.toArray(1);			  // Result: [1]
 *     var value2 = ArrayConverter.listToArray("1,2,3");	// Result: ["1", "2", "3"]
 */
class ArrayConverter {

	/**
     * Converts value into array object.
	 * Single values are converted into arrays with a single element.
	 * 
	 * @param value     the value to convert.
     * @returns         array object or null when value is null.
     */
	static List toNullableArray(value) {
		// Return null when nothing found
		if (value == null) return null;

		// Convert list
		if (value is List) return value;
		// Convert map
    else if (value is Map) {
			var result = [];
			for (var item in value.values)
				result.add(item);
			return result;
    }
		else if (value is Iterable) {
			var result = [];
			for (var item in value)
				result.add(item);
			return result;
		}
		// Convert single values
		else
			return [value];
	}

	/**
     * Converts value into array object with empty array as default.
	 * Single values are converted into arrays with single element.
     * 
     * @param value     the value to convert.
	 * @returns			array object or empty array when value is null.
     * 
     * @see [[toNullableArray]]
     */
	static List toArray(value) {
		var result = ArrayConverter.toNullableArray(value);
		return result != null ? result : [];
	}

	/**
     * Converts value into array object with specified default.
	 * Single values are converted into arrays with single element.
     * 
     * @param value         the value to convert.
     * @param defaultValue  default array object.
	 * @returns				array object or default array when value is null.
     * 
     * @see [[toNullableArray]]
     */
	static List toArrayWithDefault(value, List defaultValue) {
		var result = ArrayConverter.toNullableArray(value);
		return result != null ? result : defaultValue;
	}

	/**
	 * Converts value into array object with empty array as default.
	 * Strings with comma-delimited values are split into array of strings.
	 * 
	 * @param value 	the list to convert.
	 * @returns			array object or empty array when value is null
	 * 
	 * @see [[toArray]]
	 */
	static List listToArray(value) {
		if (value == null) return [];
		if (value is String) value = value.split(',');
		return ArrayConverter.toArray(value);
	}

}