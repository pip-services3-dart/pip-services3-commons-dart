import "../convert/convert.dart";
import "./ICloneable.dart";
// import "./AnyValueArray.dart";
// import "./AnyValueMap.dart";

/**
 * Cross-language implementation of dynamic object what can hold value of any type.
 * The stored value can be converted to different types using variety of accessor methods.
 * 
 * ### Example ###
 * 
 *     var value1 = new AnyValue("123.456");
 *     
 *     value1.getAsInteger();   // Result: 123
 *     value1.getAsString();    // Result: "123.456"
 *     value1.getAsFloat();     // Result: 123.456
 * 
 * @see [[StringConverter]]
 * @see [[TypeConverter]]
 * @see [[BooleanConverter]]
 * @see [[IntegerConverter]]
 * @see [[LongConverter]]
 * @see [[DoubleConverter]]
 * @see [[FloatConverter]]
 * @see [[DateTimeConverter]]
 * @see [[ICloneable]]
 */
class AnyValue implements ICloneable {
    /** The value stored by this object. */
	var value;

    /**
     * Creates a new instance of the object and assigns its value.
     * 
     * @param value     (optional) value to initialize this object.
     */
    AnyValue([value = null]) {
    	if (value is AnyValue)
    		this.value = value.value;
    	else
			  this.value = value;
    }

    /** 
     * Gets type code for the value stored in this object.
     * 
     * @returns type code of the object value. 
     * 
     * @see [[TypeConverter.toTypeCode]]
     */
    TypeCode getTypeCode() {
    	return TypeConverter.toTypeCode(this.value);
    }
    
    /** 
     * Gets the value stored in this object without any conversions
     * 
     * @returns the object value. 
     */
    getAsObject() {
        return this.value;
    }

    /** 
     * Sets a new value for this object
     * 
     * @param value     the new object value.
     */
    void setAsObject(value) {
        if (value is AnyValue)
            this.value = value.value;
        else
            this.value = value;
    }

    /** 
     * Converts object value into a string or returns null if conversion is not possible.
     * 
     * @returns string value or null if conversion is not supported. 
     * 
     * @see [[StringConverter.toNullableString]]
     */
    String getAsNullableString() {
        return StringConverter.toNullableString(this.value);
    }

    /** 
     * Converts object value into a string or returns "" if conversion is not possible.
     * 
     * @returns string value or "" if conversion is not supported. 
     * 
     * @see [[getAsStringWithDefault]]
     */
    String getAsString() {
        return this.getAsStringWithDefault(null);
    }

    /**
     * Converts object value into a string or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns string value or default if conversion is not supported. 
     * 
     * @see [[StringConverter.toStringWithDefault]]
     */
    String getAsStringWithDefault(String defaultValue) {
        return StringConverter.toStringWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into a boolean or returns null if conversion is not possible.
     * 
     * @returns boolean value or null if conversion is not supported. 
     * 
     * @see [[BooleanConverter.toNullableBoolean]]
     */
    bool getAsNullableBoolean() {
        return BooleanConverter.toNullableBoolean(this.value);
    }

    /** 
     * Converts object value into a boolean or returns false if conversion is not possible.
     * 
     * @returns string value or false if conversion is not supported. 
     * 
     * @see [[getAsBooleanWithDefault]]
     */
    bool getAsBoolean() {
        return this.getAsBooleanWithDefault(false);
    }

    /**
     * Converts object value into a boolean or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns boolean value or default if conversion is not supported. 
     * 
     * @see [[BooleanConverter.toBooleanWithDefault]]
     */
    bool getAsBooleanWithDefault(bool defaultValue) {
        return BooleanConverter.toBooleanWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into an integer or returns null if conversion is not possible.
     * 
     * @returns integer value or null if conversion is not supported. 
     * 
     * @see [[IntegerConverter.toNullableInteger]]
     */
    int getAsNullableInteger() {
        return IntegerConverter.toNullableInteger(this.value);
    }

    /** 
     * Converts object value into an integer or returns 0 if conversion is not possible.
     * 
     * @returns integer value or 0 if conversion is not supported. 
     * 
     * @see [[getAsIntegerWithDefault]]
     */
    int getAsInteger() {
        return this.getAsIntegerWithDefault(0);
    }

    /**
     * Converts object value into a integer or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns integer value or default if conversion is not supported. 
     * 
     * @see [[IntegerConverter.toIntegerWithDefault]]
     */
    int getAsIntegerWithDefault(int defaultValue) {
        return IntegerConverter.toIntegerWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into a long or returns null if conversion is not possible.
     * 
     * @returns long value or null if conversion is not supported. 
     * 
     * @see [[LongConverter.toNullableLong]]
     */
    int getAsNullableLong() {
        return LongConverter.toNullableLong(this.value);
    }

    /** 
     * Converts object value into a long or returns 0 if conversion is not possible.
     * 
     * @returns string value or 0 if conversion is not supported. 
     * 
     * @see [[getAsLongWithDefault]]
     */
    int getAsLong() {
        return this.getAsLongWithDefault(0);
    }

    /**
     * Converts object value into a long or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns long value or default if conversion is not supported. 
     * 
     * @see [[LongConverter.toLongWithDefault]]
     */
    int getAsLongWithDefault(int defaultValue) {
        return LongConverter.toLongWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into a float or returns null if conversion is not possible.
     * 
     * @returns float value or null if conversion is not supported. 
     * 
     * @see [[FloatConverter.toNullableFloat]]
     */
    double getAsNullableFloat() {
        return FloatConverter.toNullableFloat(this.value);
    }

    /**
     * Converts object value into a float or returns 0 if conversion is not possible.
     * 
     * @returns float value or 0 if conversion is not supported. 
     * 
     * @see [[getAsFloatWithDefault]]
     */
    double getAsFloat() {
        return this.getAsFloatWithDefault(0);
    }

    /**
     * Converts object value into a float or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns float value or default if conversion is not supported. 
     * 
     * @see [[FloatConverter.toFloatWithDefault]]
     */
    double getAsFloatWithDefault(double defaultValue) {
        return FloatConverter.toFloatWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into a double or returns null if conversion is not possible.
     * 
     * @returns double value or null if conversion is not supported. 
     * 
     * @see [[DoubleConverter.toNullableDouble]]
     */
    double getAsNullableDouble() {
        return DoubleConverter.toNullableDouble(this.value);
    }

    /** 
     * Converts object value into a double or returns 0 if conversion is not possible.
     * 
     * @returns double value or 0 if conversion is not supported. 
     * 
     * @see [[getAsDoubleWithDefault]]
     */
    double getAsDouble() {
        return this.getAsDoubleWithDefault(0);
    }

    /**
     * Converts object value into a double or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns double value or default if conversion is not supported. 
     * 
     * @see [[DoubleConverter.toDoubleWithDefault]]
     */
    double getAsDoubleWithDefault(double defaultValue) {
        return DoubleConverter.toDoubleWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into a DateTime or returns null if conversion is not possible.
     * 
     * @returns DateTime value or null if conversion is not supported. 
     * 
     * @see [[DateTimeConverter.toNullableDateTime]]
     */
    DateTime getAsNullableDateTime() {
        return DateTimeConverter.toNullableDateTime(this.value);
    }

    /** 
     * Converts object value into a DateTime or returns current date if conversion is not possible.
     * 
     * @returns DateTime value or current date if conversion is not supported. 
     * 
     * @see [[getAsDateTimeWithDefault]]
     */
    DateTime getAsDateTime() {
        return this.getAsDateTimeWithDefault(DateTime.now());
    }

    /**
     * Converts object value into a DateTime or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns DateTime value or default if conversion is not supported. 
     * 
     * @see [[DateTimeConverter.toDateTimeWithDefault]]
     */
    DateTime getAsDateTimeWithDefault(DateTime defaultValue) {
        return DateTimeConverter.toDateTimeWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into a Duration or returns null if conversion is not possible.
     * 
     * @returns Duration value or null if conversion is not supported. 
     * 
     * @see [[DurationConverter.toNullableDuration]]
     */
    Duration getAsNullableDuration() {
        return DurationConverter.toNullableDuration(this.value);
    }

    /** 
     * Converts object value into a Duration or returns current date if conversion is not possible.
     * 
     * @returns Duration value or current date if conversion is not supported. 
     * 
     * @see [[getAsDurationWithDefault]]
     */
    Duration getAsDuration() {
        return this.getAsDurationWithDefault(new Duration());
    }

    /**
     * Converts object value into a Duration or returns default value if conversion is not possible.
     * 
     * @param defaultValue      the default value.
     * @returns Duration value or default if conversion is not supported. 
     * 
     * @see [[DurationConverter.toDurationWithDefault]]
     */
    Duration getAsDurationWithDefault(Duration defaultValue) {
        return DurationConverter.toDurationWithDefault(this.value, defaultValue);
    }

    /** 
     * Converts object value into a value defined by specied typecode.
     * If conversion is not possible it returns null.
     * 
     * @param type      the TypeCode that defined the type of the result
     * @returns value defined by the typecode or null if conversion is not supported. 
     * 
     * @see [[TypeConverter.toNullableType]]
     */
    T getAsNullableType<T>(TypeCode type) {
        return TypeConverter.toNullableType<T>(type, this.value);
    }

    /** 
     * Converts object value into a value defined by specied typecode.
     * If conversion is not possible it returns default value for the specified type.
     * 
     * @param typeCode    the TypeCode that defined the type of the result
     * @returns value defined by the typecode or type default value if conversion is not supported. 
     * 
     * @see [[getAsTypeWithDefault]]
     */
    T getAsType<T>(TypeCode typeCode) {
        return this.getAsTypeWithDefault<T>(typeCode, null);
    }

    /**
     * Converts object value into a value defined by specied typecode.
     * If conversion is not possible it returns default value.
     * 
     * @param typeCode      the TypeCode that defined the type of the result
     * @param defaultValue  the default value
     * @returns value defined by the typecode or type default value if conversion is not supported. 
     * 
     * @see [[TypeConverter.toTypeWithDefault]]
     */
    T getAsTypeWithDefault<T>(TypeCode typeCode, T defaultValue) {
        return TypeConverter.toTypeWithDefault<T>(typeCode, this.value, defaultValue);
    }

    /** 
     * Converts object value into an AnyArray or returns empty AnyArray if conversion is not possible.
     * 
     * @returns AnyArray value or empty AnyArray if conversion is not supported. 
     * 
     * @see [[AnyValueArray.fromValue]]
     */
    // AnyValueArray getAsArray() {
    // 	return AnyValueArray.fromValue(this.value);
    // }

    /** 
     * Converts object value into AnyMap or returns empty AnyMap if conversion is not possible.
     * 
     * @returns AnyMap value or empty AnyMap if conversion is not supported. 
     * 
     * @see [[AnyValueMap.fromValue]]
     */
    // AnyValueMap getAsMap() {
    // 	return AnyValueMap.fromValue(this.value);
    // }

    /**
     * Compares this object value to specified specified value.
     * When direct comparison gives negative results it tries
     * to compare values as strings.
     * 
     * @param obj   the value to be compared with.
     * @returns     true when objects are equal and false otherwise.
     */
    bool equals(obj) {
        if (obj == null && this.value == null) return true;
        if (obj == null || this.value == null) return false;

        if (obj is AnyValue)
        	obj = obj.value;

        var strThisValue = StringConverter.toNullableString(this.value);
        var strValue = StringConverter.toNullableString(obj);
        
        if (strThisValue == null && strValue == null) return true;
        if (strThisValue == null || strValue == null) return false;        
        return strThisValue == strValue;
    }

    /**
     * Compares this object value to specified specified value.
     * When direct comparison gives negative results it converts 
     * values to type specified by type code and compare them again.
     * 
     * @param obj   the value to be compared with.
     * @returns     true when objects are equal and false otherwise.
     * 
     * @see [[TypeConverter.toType]]
     */
    bool equalsAsType<T>(TypeCode type, obj) {
        if (obj == null && this.value == null) return true;
        if (obj == null || this.value == null) return false;

        if (obj is AnyValue)
        	obj = obj.value;

        var typedThisValue = TypeConverter.toType<T>(type, this.value);
        var typedValue = TypeConverter.toType<T>(type, obj);
        
        if (typedThisValue == null && typedValue == null) return true;
        if (typedThisValue == null || typedValue == null) return false;        
        return typedThisValue == typedValue;
    }

    /** 
     * Creates a binary clone of this object.
     * 
     * @returns a clone of this object.
     */
    clone() {
    	return new AnyValue(this.value);
    }
    
    /** 
     * Gets a string representation of the object.
     * 
     * @returns a string representation of the object.
     *
     * @see [[StringConverter.toString]]
     */
    @override
    String toString() {
        return StringConverter.toNullableString(this.value);
    }

    /**
     * Gets an object hash code which can be used to optimize storing and searching.
     * 
     * @returns an object hash code. 
     */
    @override
    int get hashCode {
        return this.value != null ? this.value.hashCode: 0;
    }
}
