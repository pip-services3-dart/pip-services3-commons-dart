import '../convert/convert.dart';
import '../reflect/IValueWrapper.dart';

import './ICloneable.dart';
import './AnyValueArray.dart';
import './AnyValueMap.dart';

/// Cross-language implementation of dynamic object what can hold value of any type.
/// The stored value can be converted to different types using variety of accessor methods.
///
/// ### Example ###
///
///     var value1 =  AnyValue('123.456');
///
///     value1.getAsInteger();   // Result: 123
///     value1.getAsString();    // Result: '123.456'
///     value1.getAsFloat();     // Result: 123.456
///
/// See [StringConverter]
/// See [TypeConverter]
/// See [BooleanConverter]
/// See [IntegerConverter]
/// See [LongConverter]
/// See [DoubleConverter]
/// See [FloatConverter]
/// See [DateTimeConverter]
/// See [ICloneable]

class AnyValue implements ICloneable, IValueWrapper {
  /// The value stored by this object.
  var _value;

  /// Creates a new instance of the object and assigns its value.
  ///
  /// - [value]     (optional) value to initialize this object.

  AnyValue([value]) {
    if (value is AnyValue) {
      _value = value._value;
    } else {
      _value = value;
    }
  }

  /// Creates a new instance of the object from json.
  ///
  /// - [json]     json to initialize this object.
  factory AnyValue.fromJson(Map<String, dynamic> json) {
    return AnyValue(json['value']);
  }

  /// Returned inner values in Map object
  @override
  dynamic innerValue() {
    return _value;
  }

  /// Returned JSON Map object from values of this object

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'value': _value};
  }

  /// Initialize this object from JSON Map object

  void fromJson(Map<String, dynamic> json) {
    _value = json['value'];
  }

  /// Gets type code for the value stored in this object.
  ///
  /// Returns type code of the object value.
  ///
  /// See [TypeConverter.toTypeCode]

  TypeCode getTypeCode() {
    return TypeConverter.toTypeCode(_value);
  }

  /// Gets the value stored in this object without any conversions
  ///
  /// Returns the object value.

  dynamic getAsObject() {
    return _value;
  }

  /// Sets a new value for this object
  ///
  /// - [value]     the new object value.
  void setAsObject(value) {
    if (value is AnyValue) {
      _value = value._value;
    } else {
      _value = value;
    }
  }

  /// Converts object value into a string or returns null if conversion is not possible.
  ///
  /// Returns string value or null if conversion is not supported.
  ///
  /// See [StringConverter.toNullableString]
  String? getAsNullableString() {
    return StringConverter.toNullableString(_value);
  }

  /// Converts object value into a string or returns '' if conversion is not possible.
  ///
  /// Returns string value or '' if conversion is not supported.
  ///
  /// See [getAsStringWithDefault]
  String getAsString() {
    return getAsStringWithDefault('');
  }

  /// Converts object value into a string or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns string value or default if conversion is not supported.
  ///
  /// See [StringConverter.toStringWithDefault]
  String getAsStringWithDefault(String defaultValue) {
    return StringConverter.toStringWithDefault(_value, defaultValue);
  }

  /// Converts object value into a boolean or returns null if conversion is not possible.
  ///
  /// Returns boolean value or null if conversion is not supported.
  ///
  /// See [BooleanConverter.toNullableBoolean]

  bool? getAsNullableBoolean() {
    return BooleanConverter.toNullableBoolean(_value);
  }

  /// Converts object value into a boolean or returns false if conversion is not possible.
  ///
  /// Returns string value or false if conversion is not supported.
  ///
  /// See [getAsBooleanWithDefault]

  bool getAsBoolean() {
    return getAsBooleanWithDefault(false);
  }

  /// Converts object value into a boolean or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns boolean value or default if conversion is not supported.
  ///
  /// See [BooleanConverter.toBooleanWithDefault]

  bool getAsBooleanWithDefault(bool defaultValue) {
    return BooleanConverter.toBooleanWithDefault(_value, defaultValue);
  }

  /// Converts object value into an integer or returns null if conversion is not possible.
  ///
  /// Returns integer value or null if conversion is not supported.
  ///
  /// See [IntegerConverter.toNullableInteger]

  int? getAsNullableInteger() {
    return IntegerConverter.toNullableInteger(_value);
  }

  /// Converts object value into an integer or returns 0 if conversion is not possible.
  ///
  /// Returns integer value or 0 if conversion is not supported.
  ///
  /// See [getAsIntegerWithDefault]

  int getAsInteger() {
    return getAsIntegerWithDefault(0);
  }

  /// Converts object value into a integer or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns integer value or default if conversion is not supported.
  ///
  /// See [IntegerConverter.toIntegerWithDefault]

  int getAsIntegerWithDefault(int defaultValue) {
    return IntegerConverter.toIntegerWithDefault(_value, defaultValue);
  }

  /// Converts object value into a long or returns null if conversion is not possible.
  ///
  /// Returns long value or null if conversion is not supported.
  ///
  /// See [LongConverter.toNullableLong]

  int? getAsNullableLong() {
    return LongConverter.toNullableLong(_value);
  }

  /// Converts object value into a long or returns 0 if conversion is not possible.
  ///
  /// Returns string value or 0 if conversion is not supported.
  ///
  /// See [getAsLongWithDefault]

  int getAsLong() {
    return getAsLongWithDefault(0);
  }

  /// Converts object value into a long or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns long value or default if conversion is not supported.
  ///
  /// See [LongConverter.toLongWithDefault]

  int getAsLongWithDefault(int defaultValue) {
    return LongConverter.toLongWithDefault(_value, defaultValue);
  }

  /// Converts object value into a float or returns null if conversion is not possible.
  ///
  /// Returns float value or null if conversion is not supported.
  ///
  /// See [FloatConverter.toNullableFloat]

  double? getAsNullableFloat() {
    return FloatConverter.toNullableFloat(_value);
  }

  /// Converts object value into a float or returns 0 if conversion is not possible.
  ///
  /// Returns float value or 0 if conversion is not supported.
  ///
  /// See [getAsFloatWithDefault]

  double getAsFloat() {
    return getAsFloatWithDefault(0);
  }

  /// Converts object value into a float or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns float value or default if conversion is not supported.
  ///
  /// See [FloatConverter.toFloatWithDefault]

  double getAsFloatWithDefault(double defaultValue) {
    return FloatConverter.toFloatWithDefault(_value, defaultValue);
  }

  /// Converts object value into a double or returns null if conversion is not possible.
  ///
  /// Returns double value or null if conversion is not supported.
  ///
  /// See [DoubleConverter.toNullableDouble]

  double? getAsNullableDouble() {
    return DoubleConverter.toNullableDouble(_value);
  }

  /// Converts object value into a double or returns 0 if conversion is not possible.
  ///
  /// Returns double value or 0 if conversion is not supported.
  ///
  /// See [getAsDoubleWithDefault]
  double getAsDouble() {
    return getAsDoubleWithDefault(0);
  }

  /// Converts object value into a double or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns double value or default if conversion is not supported.
  ///
  /// See [DoubleConverter.toDoubleWithDefault]
  double getAsDoubleWithDefault(double defaultValue) {
    return DoubleConverter.toDoubleWithDefault(_value, defaultValue);
  }

  /// Converts object value into a DateTime or returns null if conversion is not possible.
  ///
  /// Returns DateTime value or null if conversion is not supported.
  ///
  /// See [DateTimeConverter.toNullableDateTime]
  DateTime? getAsNullableDateTime() {
    return DateTimeConverter.toNullableDateTime(_value);
  }

  /// Converts object value into a DateTime or returns current date if conversion is not possible.
  ///
  /// Returns DateTime value or current date if conversion is not supported.
  ///
  /// See [getAsDateTimeWithDefault]
  DateTime getAsDateTime() {
    return getAsDateTimeWithDefault(DateTime.now().toUtc());
  }

  /// Converts object value into a DateTime or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns DateTime value or default if conversion is not supported.
  ///
  /// See [DateTimeConverter.toDateTimeWithDefault]
  DateTime getAsDateTimeWithDefault(DateTime defaultValue) {
    return DateTimeConverter.toDateTimeWithDefault(_value, defaultValue);
  }

  /// Converts object value into a Duration or returns null if conversion is not possible.
  ///
  /// Returns Duration value or null if conversion is not supported.
  ///
  /// See [DurationConverter.toNullableDuration]
  Duration? getAsNullableDuration() {
    return DurationConverter.toNullableDuration(_value);
  }

  /// Converts object value into a Duration or returns current date if conversion is not possible.
  ///
  /// Returns Duration value or current date if conversion is not supported.
  ///
  /// See [getAsDurationWithDefault]
  Duration getAsDuration() {
    return getAsDurationWithDefault(Duration());
  }

  /// Converts object value into a Duration or returns default value if conversion is not possible.
  ///
  /// - [defaultValue]      the default value.
  /// Returns Duration value or default if conversion is not supported.
  ///
  /// See [DurationConverter.toDurationWithDefault]
  Duration getAsDurationWithDefault(Duration defaultValue) {
    return DurationConverter.toDurationWithDefault(_value, defaultValue);
  }

  /// Converts object value into a value defined by specied typecode.
  /// If conversion is not possible it returns null.
  ///
  /// - [type]      the TypeCode that defined the type of the result
  /// Returns value defined by the typecode or null if conversion is not supported.
  ///
  /// See [TypeConverter.toNullableType]
  T? getAsNullableType<T>(TypeCode type) {
    return TypeConverter.toNullableType<T>(type, _value);
  }

  /// Converts object value into a value defined by specied typecode.
  /// If conversion is not possible it returns default value for the specified type.
  ///
  /// - [typeCode]    the TypeCode that defined the type of the result
  /// Returns value defined by the typecode or type default value if conversion is not supported.
  ///
  /// See [getAsTypeWithDefault]
  T getAsType<T>(TypeCode typeCode) {
    var defaultValue = T as T;
    return getAsTypeWithDefault<T>(typeCode, defaultValue);
  }

  /// Converts object value into a value defined by specied typecode.
  /// If conversion is not possible it returns default value.
  ///
  /// - [typeCode]      the TypeCode that defined the type of the result
  /// - defaultValue  the default value
  /// Returns value defined by the typecode or type default value if conversion is not supported.
  ///
  /// See [TypeConverter.toTypeWithDefault]
  T getAsTypeWithDefault<T>(TypeCode typeCode, T defaultValue) {
    return TypeConverter.toTypeWithDefault<T>(typeCode, _value, defaultValue);
  }

  /// Converts object value into an AnyArray or returns empty AnyArray if conversion is not possible.
  ///
  /// Returns AnyArray value or empty AnyArray if conversion is not supported.
  ///
  /// See [AnyValueArray.fromValue]
  AnyValueArray getAsArray() {
    return AnyValueArray.fromValue(_value);
  }

  /// Converts object value into AnyMap or returns empty AnyMap if conversion is not possible.
  ///
  /// Returns AnyMap value or empty AnyMap if conversion is not supported.
  ///
  /// See [AnyValueMap.fromValue]
  AnyValueMap getAsMap() {
    return AnyValueMap.fromValue(_value);
  }

  /// Compares this object value to specified specified value.
  /// When direct comparison gives negative results it tries
  /// to compare values as strings.
  ///
  /// - [obj]   the value to be compared with.
  /// Returns     true when objects are equal and false otherwise.
  bool equals(obj) {
    if (obj == null && _value == null) return true;
    if (obj == null || _value == null) return false;

    if (obj is AnyValue) obj = obj._value;

    var strThisValue = StringConverter.toNullableString(_value);
    var strValue = StringConverter.toNullableString(obj);

    if (strThisValue == null && strValue == null) return true;
    if (strThisValue == null || strValue == null) return false;
    return strThisValue == strValue;
  }

  /// Compares this object value to specified specified value.
  /// When direct comparison gives negative results it converts
  /// values to type specified by type code and compare them again.
  ///
  /// - [obj]   the value to be compared with.
  /// Returns     true when objects are equal and false otherwise.
  ///
  /// See [TypeConverter.toType]
  bool equalsAsType<T>(TypeCode type, obj) {
    if (obj == null && _value == null) return true;
    if (obj == null || _value == null) return false;

    if (obj is AnyValue) obj = obj._value;

    var typedThisValue = TypeConverter.toType<T>(type, _value);
    var typedValue = TypeConverter.toType<T>(type, obj);

    if (typedThisValue == null && typedValue == null) return true;
    if (typedThisValue == null || typedValue == null) return false;
    return typedThisValue == typedValue;
  }

  /// Creates a binary clone of this object.
  ///
  /// Returns a clone of this object.
  @override
  dynamic clone() {
    return AnyValue(_value);
  }

  /// Gets a string representation of the object.
  ///
  /// Returns a string representation of the object.
  /// See [StringConverter.toString]
  @override
  String toString() {
    return StringConverter.toNullableString(_value) ?? '';
  }

  /// Gets an object hash code which can be used to optimize storing and searching.
  ///
  /// Returns an object hash code.
  @override
  int get hashCode {
    return _value.hashCode;
  }
}
