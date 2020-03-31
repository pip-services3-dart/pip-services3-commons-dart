import 'dart:collection';

import '../convert/TypeCode.dart';
import '../convert/TypeConverter.dart';
import '../convert/StringConverter.dart';
import '../convert/BooleanConverter.dart';
import '../convert/IntegerConverter.dart';
import '../convert/LongConverter.dart';
import '../convert/FloatConverter.dart';
import '../convert/DoubleConverter.dart';
import '../convert/DateTimeConverter.dart';
import '../convert/DurationConverter.dart';
import '../convert/ArrayConverter.dart';
import '../reflect/IValueWrapper.dart';

import './ICloneable.dart';
import './AnyValue.dart';
import './AnyValueMap.dart';

/**
/// Cross-language implementation of dynamic object array what can hold values of any type.
/// The stored values can be converted to different types using variety of accessor methods.
/// 
/// ### Example ###
/// 
///     var value1 = new AnyValueArray([1, "123.456", "2018-01-01"]);
///     
///     value1.getAsBoolean(0);   // Result: true
///     value1.getAsInteger(1);   // Result: 123
///     value1.getAsFloat(1);     // Result: 123.456
///     value1.getAsDateTime(2);  // Result: new Date(2018,0,1)
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
 */
class AnyValueArray extends ListBase<dynamic>
    implements ICloneable, IValueWrapper {
  List _values;

  /**
  /// Creates a new instance of the array and assigns its value.
  /// 
  /// - value     (optional) values to initialize this array.
   */
  AnyValueArray([Iterable values = null]) {
    this._values = new List();

    if (values != null) {
      this._values.addAll(values);
    }
  }

  /**
  /// Creates a new instance of the array from JSON.
  /// 
  /// - [json]     values to initialize this array.
   */
  factory AnyValueArray.fromJson(Map<String, dynamic> json) {
    return new AnyValueArray(json["values"]);
  }

  /**
  /// Returned inner values in Map object
   */
  innerValue() {
    return this._values;
  }

  /**
  /// Returned JSON Map object from values of this object
   */
  Map<String, dynamic> toJson() {
    return <String, dynamic>{"values": this._values};
  }

/**
  /// Initialize this object from JSON Map object
   */
  void fromJson(Map<String, dynamic> json) {
    this._values = null;
    append(json["values"]);
  }

  /**
   /// Gets an array with values.
   /// 
   /// Returns         the value of the array elements.
    */
  List getValue() {
    return this._values;
  }

  /**
    /// Gets an array element specified by its index.
    /// 
    /// - [index]     an index of the element to get.
    /// Returns         the value of the array element.
     */
  get(int index) {
    return this._values[index];
  }

  /**
    /// Puts a new value into array element specified by its index.
    /// 
    /// - [index]     an index of the element to put.
    /// - [value]     a new value for array element.
     */
  void put(int index, value) {
    this._values[index] = value;
  }

  /**
   Retruns length of array
  */
  @override
  void set length(int l) {
    this._values.length = l;
  }

  @override
  int get length => _values.length;
  
  /**
    /// Appends new elements to this array.
    /// 
    /// - [elements]  a list of elements to be added.
     */
  void append(elements) {
    if (elements is Iterable) {
      for (var item in elements) this._values.add(item);
    }
  }

  /**
    /// Clears this array by removing all its elements.
    */
  void clear() {
    this._values.clear();
  }

  /**
    /// Gets the value stored in array element without any conversions.
    /// When element index is not defined it returns the entire array value.
    /// 
    /// - index     (optional) an index of the element to get
    /// Returns the element value or value of the array when index is not defined. 
     */
  getAsObject([int index = null]) {
    if (index == null) {
      var result = List();
      for (var item in this._values) result.add(item);
      return result;
    } else {
      return this._values[index];
    }
  }

  /**
    /// Sets a new value to array element specified by its index.
    /// When the index is not defined, it resets the entire array value.
    /// This method has double purpose because method overrides are not supported in JavaScript.
    /// 
    /// - [index]     (optional) an index of the element to set
    /// - [value]     a new element or array value.
    /// 
    /// See [ArrayConverter.toArray]
     */
  void setAsObject(dynamic index, dynamic value) {
    if (value == null) {
      this.clear();
      var elements = ArrayConverter.toArray(index);
      this.append(elements);
    } else {
      this._values[index] = value;
    }
  }

  /**
    /// Converts array element into a string or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns string value of the element or null if conversion is not supported. 
    /// 
    /// See [StringConverter.toNullableString]
     */
  String getAsNullableString(int index) {
    var value = this._values[index];
    return StringConverter.toNullableString(value);
  }

  /**
    /// Converts array element into a string or returns "" if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns string value ot the element or "" if conversion is not supported. 
    /// 
    /// See [getAsStringWithDefault]
     */
  String getAsString(int index) {
    return this.getAsStringWithDefault(index, null);
  }

  /**
    /// Converts array element into a string or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns string value ot the element or default value if conversion is not supported. 
    /// 
    /// See [StringConverter.toStringWithDefault]
     */
  String getAsStringWithDefault(int index, String defaultValue) {
    var value = this._values[index];
    return StringConverter.toStringWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into a boolean or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns boolean value of the element or null if conversion is not supported. 
    /// 
    /// See [BooleanConverter.toNullableBoolean]
     */
  bool getAsNullableBoolean(int index) {
    var value = this._values[index];
    return BooleanConverter.toNullableBoolean(value);
  }

  /**
    /// Converts array element into a boolean or returns false if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns boolean value ot the element or false if conversion is not supported. 
    /// 
    /// See [getAsBooleanWithDefault]
     */
  bool getAsBoolean(int index) {
    return this.getAsBooleanWithDefault(index, false);
  }

  /**
    /// Converts array element into a boolean or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns boolean value ot the element or default value if conversion is not supported. 
    /// 
    /// See [BooleanConverter.toBooleanWithDefault]
     */
  bool getAsBooleanWithDefault(int index, bool defaultValue) {
    var value = this._values[index];
    return BooleanConverter.toBooleanWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into an integer or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns integer value of the element or null if conversion is not supported. 
    /// 
    /// See [IntegerConverter.toNullableInteger]
     */
  int getAsNullableInteger(int index) {
    var value = this._values[index];
    return IntegerConverter.toNullableInteger(value);
  }

  /**
    /// Converts array element into an integer or returns 0 if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns integer value ot the element or 0 if conversion is not supported. 
    /// 
    /// See [getAsIntegerWithDefault]
     */
  int getAsInteger(int index) {
    return this.getAsIntegerWithDefault(index, 0);
  }

  /**
    /// Converts array element into an integer or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns integer value ot the element or default value if conversion is not supported. 
    /// 
    /// See [IntegerConverter.toIntegerWithDefault]
     */
  int getAsIntegerWithDefault(int index, int defaultValue) {
    var value = this._values[index];
    return IntegerConverter.toIntegerWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into a long or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns long value of the element or null if conversion is not supported. 
    /// 
    /// See [LongConverter.toNullableLong]
     */
  int getAsNullableLong(int index) {
    var value = this._values[index];
    return LongConverter.toNullableLong(value);
  }

  /**
    /// Converts array element into a long or returns 0 if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns long value ot the element or 0 if conversion is not supported. 
    /// 
    /// See [getAsLongWithDefault]
     */
  int getAsLong(int index) {
    return this.getAsLongWithDefault(index, 0);
  }

  /**
    /// Converts array element into a long or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns long value ot the element or default value if conversion is not supported. 
    /// 
    /// See [LongConverter.toLongWithDefault]
     */
  int getAsLongWithDefault(int index, int defaultValue) {
    var value = this._values[index];
    return LongConverter.toLongWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into a float or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns float value of the element or null if conversion is not supported. 
    /// 
    /// See [FloatConverter.toNullableFloat]
     */
  double getAsNullableFloat(int index) {
    var value = this._values[index];
    return FloatConverter.toNullableFloat(value);
  }

  /**
    /// Converts array element into a float or returns 0 if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns float value ot the element or 0 if conversion is not supported. 
    /// 
    /// See [getAsFloatWithDefault]
     */
  double getAsFloat(int index) {
    return this.getAsFloatWithDefault(index, 0);
  }

  /**
    /// Converts array element into a float or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns float value ot the element or default value if conversion is not supported. 
    /// 
    /// See [FloatConverter.toFloatWithDefault]
     */
  double getAsFloatWithDefault(int index, double defaultValue) {
    var value = this._values[index];
    return FloatConverter.toFloatWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into a double or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns double value of the element or null if conversion is not supported. 
    /// 
    /// See [DoubleConverter.toNullableDouble]
     */
  double getAsNullableDouble(int index) {
    var value = this._values[index];
    return DoubleConverter.toNullableDouble(value);
  }

  /**
    /// Converts array element into a double or returns 0 if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns double value ot the element or 0 if conversion is not supported. 
    /// 
    /// See [getAsDoubleWithDefault]
     */
  double getAsDouble(index) {
    return this.getAsDoubleWithDefault(index, 0);
  }

  /**
    /// Converts array element into a double or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns double value ot the element or default value if conversion is not supported. 
    /// 
    /// See [DoubleConverter.toDoubleWithDefault]
     */
  double getAsDoubleWithDefault(int index, double defaultValue) {
    var value = this._values[index];
    return DoubleConverter.toDoubleWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into a DateTime or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns DateTime value of the element or null if conversion is not supported. 
    /// 
    /// See [DateTimeConverter.toNullableDateTime]
     */
  DateTime getAsNullableDateTime(int index) {
    var value = this._values[index];
    return DateTimeConverter.toNullableDateTime(value);
  }

  /**
    /// Converts array element into a DateTime or returns the current date if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns DateTime value ot the element or the current date if conversion is not supported. 
    /// 
    /// See [getAsDateTimeWithDefault]
     */
  DateTime getAsDateTime(int index) {
    return this.getAsDateTimeWithDefault(index, new DateTime.now());
  }

  /**
    /// Converts array element into a DateTime or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns DateTime value ot the element or default value if conversion is not supported. 
    /// 
    /// See [DateTimeConverter.toDateTimeWithDefault]
     */
  DateTime getAsDateTimeWithDefault(int index, DateTime defaultValue) {
    var value = this._values[index];
    return DateTimeConverter.toDateTimeWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into a Duration or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns Duration value of the element or null if conversion is not supported. 
    /// 
    /// See [DurationConverter.toNullableDuration]
     */
  Duration getAsNullableDuration(int index) {
    var value = this._values[index];
    return DurationConverter.toNullableDuration(value);
  }

  /**
    /// Converts array element into a Duration or returns the current date if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns Duration value ot the element or the current date if conversion is not supported. 
    /// 
    /// See [getAsDurationWithDefault]
     */
  Duration getAsDuration(int index) {
    return this.getAsDurationWithDefault(index, new Duration());
  }

  /**
    /// Converts array element into a Duration or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns Duration value ot the element or default value if conversion is not supported. 
    /// 
    /// See [DurationConverter.toDurationWithDefault]
     */
  Duration getAsDurationWithDefault(int index, Duration defaultValue) {
    var value = this._values[index];
    return DurationConverter.toDurationWithDefault(value, defaultValue);
  }

  /**
    /// Converts array element into a value defined by specied typecode.
    /// If conversion is not possible it returns null.
    /// 
    /// - [type]      the TypeCode that defined the type of the result
    /// - [index]     an index of element to get.
    /// Returns element value defined by the typecode or null if conversion is not supported. 
    /// 
    /// See [TypeConverter.toNullableType]
     */
  T getAsNullableType<T>(TypeCode type, int index) {
    var value = this._values[index];
    return TypeConverter.toNullableType<T>(type, value);
  }

  /**
    /// Converts array element into a value defined by specied typecode.
    /// If conversion is not possible it returns default value for the specified type.
    /// 
    /// - [type]      the TypeCode that defined the type of the result
    /// - [index]     an index of element to get.
    /// Returns element value defined by the typecode or default if conversion is not supported. 
    /// 
    /// See [getAsTypeWithDefault]
     */
  T getAsType<T>(TypeCode type, int index) {
    return this.getAsTypeWithDefault(type, index, null);
  }

  /**
    /// Converts array element into a value defined by specied typecode.
    /// If conversion is not possible it returns default value.
    /// 
    /// - [type]          the TypeCode that defined the type of the result
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns element value defined by the typecode or default value if conversion is not supported. 
    /// 
    /// See [TypeConverter.toTypeWithDefault]
     */
  T getAsTypeWithDefault<T>(TypeCode type, int index, T defaultValue) {
    var value = this._values[index];
    return TypeConverter.toTypeWithDefault(type, value, defaultValue);
  }

  /**
    /// Converts array element into an AnyValue or returns an empty AnyValue if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns AnyValue value of the element or empty AnyValue if conversion is not supported. 
    /// 
    /// See [AnyValue]
    /// See [AnyValue.constructor]
     */
  AnyValue getAsValue(int index) {
    var value = this._values[index];
    return new AnyValue(value);
  }

  /**
    /// Converts array element into an AnyValueArray or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns AnyValueArray value of the element or null if conversion is not supported. 
    /// 
    /// See [fromValue]
     */
  AnyValueArray getAsNullableArray(int index) {
    var value = this._values[index];
    return value != null ? AnyValueArray.fromValue(value) : null;
  }

  /**
    /// Converts array element into an AnyValueArray or returns empty AnyValueArray if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns AnyValueArray value of the element or empty AnyValueArray if conversion is not supported. 
    /// 
    /// See [fromValue]
     */
  AnyValueArray getAsArray(int index) {
    var value = this._values[index];
    return AnyValueArray.fromValue(value);
  }

  /**
    /// Converts array element into an AnyValueArray or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns AnyValueArray value of the element or default value if conversion is not supported. 
    /// 
    /// See [getAsNullableArray]
     */
  AnyValueArray getAsArrayWithDefault(int index, AnyValueArray defaultValue) {
    var result = this.getAsNullableArray(index);
    return result != null ? result : defaultValue;
  }

  /**
    /// Converts array element into an AnyValueMap or returns null if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns AnyValueMap value of the element or null if conversion is not supported. 
    /// 
    /// See [AnyValueMap]
    /// See [AnyValueMap.fromValue]
     */
  AnyValueMap getAsNullableMap(int index) {
    var value = this._values[index];
    return value != null ? AnyValueMap.fromValue(value) : null;
  }

  /**
    /// Converts array element into an AnyValueMap or returns empty AnyValueMap if conversion is not possible.
    /// 
    /// - [index]     an index of element to get.
    /// Returns AnyValueMap value of the element or empty AnyValueMap if conversion is not supported. 
    /// 
    /// See [AnyValueMap]
    /// See [AnyValueMap.fromValue]
     */
  AnyValueMap getAsMap(int index) {
    var value = this._values[index];
    return AnyValueMap.fromValue(value);
  }

  /**
    /// Converts array element into an AnyValueMap or returns default value if conversion is not possible.
    /// 
    /// - [index]         an index of element to get.
    /// - defaultValue  the default value
    /// Returns AnyValueMap value of the element or default value if conversion is not supported. 
    /// 
    /// See [getAsNullableMap]
     */
  AnyValueMap getAsMapWithDefault(int index, AnyValueMap defaultValue) {
    var result = this.getAsNullableMap(index);
    return result != null ? AnyValueMap.fromValue(result) : defaultValue;
  }

  /**
    /// Checks if this array contains a value.
    /// The check uses direct comparison between elements and the specified value.
    /// 
    /// - [value]     a value to be checked
    /// Returns         true if this array contains the value or false otherwise.
     */
  bool contains(dynamic value) {
    for (var index = 0; index < this._values.length; index++) {
      var element = this._values[index];

      if (value == null && element == null) return true;
      if (value == null || element == null) continue;
      if (value == element) return true;
    }

    return false;
  }

  /**
    /// Checks if this array contains a value.
    /// The check before comparison converts elements and the value to type specified by type code.
    /// 
    /// - typeCode  a type code that defines a type to convert values before comparison
    /// - [value]     a value to be checked
    /// Returns         true if this array contains the value or false otherwise.
    /// 
    /// See [TypeConverter.toType]
    /// See [TypeConverter.toNullableType]
     */
  bool containsAsType<T>(TypeCode typeCode, dynamic value) {
    var typedValue = TypeConverter.toType<T>(typeCode, value);

    for (var index = 0; index < this._values.length; index++) {
      var thisTypedValue =
          TypeConverter.toNullableType(typeCode, this._values[index]);

      if (typedValue == null && thisTypedValue == null) return true;
      if (typedValue == null || thisTypedValue == null) continue;
      if (typedValue == thisTypedValue) return true;
    }

    return false;
  }

  /**
    /// Creates a binary clone of this object.
    /// 
    /// Returns a clone of this object.
     */
  clone() {
    return new AnyValueArray(this._values);
  }

  /**
    /// Gets a string representation of the object.
    /// The result is a comma-separated list of string representations of individual elements as
    /// "value1,value2,value3"
    /// 
    /// Returns a string representation of the object.
     *
    /// See [StringConverter.toString]
     */
  @override
  String toString() {
    var builder = '';
    for (var index = 0; index < this._values.length; index++) {
      if (index > 0) builder += ',';
      builder += this.getAsStringWithDefault(index, "");
    }
    return builder;
  }

  /**
    /// Creates a new AnyValueArray from a list of values
    /// 
    /// - [values]    a list of values to initialize the created AnyValueArray
    /// Returns         a newly created AnyValueArray.
     */
  static AnyValueArray fromValues(List values) {
    return new AnyValueArray(values);
  }

  /**
    /// Converts specified value into AnyValueArray.
    /// 
    /// - [value]     value to be converted
    /// Returns         a newly created AnyValueArray.
    /// 
    /// See [ArrayConverter.toNullableArray]
     */
  static AnyValueArray fromValue(value) {
    var values = ArrayConverter.toNullableArray(value);
    return new AnyValueArray(values);
  }

  /**
    /// Splits specified string into elements using a separator and assigns 
    /// the elements to a newly created AnyValueArray.
    /// 
    /// - [values]            a string value to be split and assigned to AnyValueArray
    /// - [separator]         a separator to split the string
    /// - [removeDuplicates]  (optional) true to remove duplicated elements
    /// Returns                 a newly created AnyValueArray.
     */
  static AnyValueArray fromString(String values, String separator,
      [bool removeDuplicates = false]) {
    var result = new AnyValueArray();

    if (values == null || values.length == 0) return result;

    var items = values.split(separator);
    for (var index = 0; index < items.length; index++) {
      var item = items[index];
      if ((item != null && item.length > 0) || removeDuplicates == false)
        result._values.add(item != null ? new AnyValue(item) : null);
    }
    return result;
  }


  dynamic operator [](int index) {
    return this._values[index];
  }

  void operator []=(int index, dynamic item) {
    this._values[index] = item;
  }
}
