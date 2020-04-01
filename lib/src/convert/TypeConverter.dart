import './TypeCode.dart';
import './StringConverter.dart';
import './BooleanConverter.dart';
import './IntegerConverter.dart';
import './LongConverter.dart';
import './FloatConverter.dart';
import './DoubleConverter.dart';
import './DateTimeConverter.dart';
import './DurationConverter.dart';
import './ArrayConverter.dart';
import './MapConverter.dart';


/// Converts arbitrary values into objects specific by TypeCodes.
/// For each TypeCode this class calls corresponding converter which applies
/// extended conversion rules to convert the values.
/// 
/// See [TypeCode]
/// 
/// ### Example ###
/// 
///     var value1 = TypeConverter.toType(TypeCode.Integer, '123.456'); // Result: 123
///     var value2 = TypeConverter.toType(TypeCode.DateTime, 123); // Result: DateTime(123)
///     var value3 = TypeConverter.toType(TypeCode.Boolean, 'F'); // Result: false
 
class TypeConverter {
  
	/// Gets TypeCode for specific value.
	/// 
	/// - [value] 	value whose TypeCode is to be resolved.
	/// Returns			the TypeCode that corresponds to the passed object's type.
	 
  static TypeCode toTypeCode(value) {
    if (value == null) return TypeCode.Unknown;

    if (value is List) return TypeCode.Array;
    if (value is bool) return TypeCode.Boolean;
    if (value is DateTime) return TypeCode.DateTime;
    if (value is Duration) return TypeCode.Duration;
    if (value is int) return TypeCode.Long;
    if (value is double) return TypeCode.Double;
    if (value is Map) return TypeCode.Map;

    if (value is String) {
      // if (value == 'undefined')
      //     return TypeCode.Unknown;
      // if (value == 'object')
      //     return TypeCode.Map;
      // if (value == 'boolean')
      //     return TypeCode.Boolean;
      // if (value == 'number')
      //     return TypeCode.Double;
      // if (value == 'string')
      //     return TypeCode.String;
      // if (value == 'function')
      //     return TypeCode.Object;

      return TypeCode.String;
    }

    return TypeCode.Object;
  }

  
	/// Converts value into an object type specified by Type Code or returns null when conversion is not possible.
	/// 
	/// - [type] 		the TypeCode for the data type into which 'value' is to be converted.
	/// - [value] 	the value to convert.
	/// Returns			object value of type corresponding to TypeCode, or null when conversion is not supported.
	/// 
	/// See [toTypeCode]
	 
  static T toNullableType<T>(TypeCode type, value) {
    if (value == null) return null;

    // Convert to known types
    if (type == TypeCode.String)
      value = StringConverter.toNullableString(value);
    else if (type == TypeCode.Boolean)
      value = BooleanConverter.toNullableBoolean(value);
    else if (type == TypeCode.Integer)
      value = IntegerConverter.toNullableInteger(value);
    else if (type == TypeCode.Long)
      value = LongConverter.toNullableLong(value);
    else if (type == TypeCode.Float)
      value = FloatConverter.toNullableFloat(value);
    else if (type == TypeCode.Double)
      value = DoubleConverter.toNullableDouble(value);
    else if (type == TypeCode.DateTime)
      value = DateTimeConverter.toNullableDateTime(value);
    else if (type == TypeCode.Duration)
      value = DurationConverter.toNullableDuration(value);
    else if (type == TypeCode.Array)
      value = ArrayConverter.toNullableArray(value);
    else if (type == TypeCode.Map) value = MapConverter.toNullableMap(value);

    return value as T;
  }

  
	/// Converts value into an object type specified by Type Code or returns type default when conversion is not possible.
	/// 
	/// - [type] 		the TypeCode for the data type into which 'value' is to be converted.
	/// - [value] 	the value to convert.
	/// Returns			object value of type corresponding to TypeCode, or type default when conversion is not supported.
	/// 
	/// See [toNullableType]
	/// See [toTypeCode]
	 
  static T toType<T>(TypeCode type, value) {
    // Convert to the specified type
    var result = TypeConverter.toNullableType<T>(type, value);
    if (result != null) return result;

    // Define and return default value based on type
    if (type == TypeCode.Integer)
      value = 0;
    else if (type == TypeCode.Long)
      value = 0;
    else if (type == TypeCode.Float)
      value = 0;
    else if (type == TypeCode.Double)
      value = 0;
    else if (type ==
        TypeCode.Boolean) // cases from here down were added by Mark Makarychev.
      value = false;
    else if (type == TypeCode.String)
      value = '';
    else if (type == TypeCode.DateTime)
      value = new DateTime.now();
    else if (type == TypeCode.Duration)
      value = new Duration();
    else if (type == TypeCode.Map)
      value = new Map<String, dynamic>();
    else if (type == TypeCode.Array) value = [];

    return value as T;
  }

  
	/// Converts value into an object type specified by Type Code or returns default value when conversion is not possible.
	/// 
	/// - [type] 			the TypeCode for the data type into which 'value' is to be converted.
	/// - [value] 		the value to convert.
	/// - [defaultValue]	the default value to return if conversion is not possible (returns null).
	/// Returns			object value of type corresponding to TypeCode, or default value when conversion is not supported.
	/// 
	/// See [toNullableType]
	/// See [toTypeCode]
	 
  static T toTypeWithDefault<T>(TypeCode type, value, T defaultValue) {
    var result = TypeConverter.toNullableType<T>(type, value);
    return result != null ? result : defaultValue;
  }

  
	/// Converts a TypeCode into its string name.
	/// 
	/// - [type] 	the TypeCode to convert into a string.
	/// Returns		the name of the TypeCode passed as a string value.
	 
  static String asString(TypeCode type) {
    switch (type) {
      case TypeCode.Unknown:
        return 'unknown';
      case TypeCode.String:
        return 'String';
      case TypeCode.Boolean:
        return 'bool';
      case TypeCode.Integer:
        return 'int';
      case TypeCode.Long:
        return 'int';
      case TypeCode.Float:
        return 'double';
      case TypeCode.Double:
        return 'double';
      case TypeCode.DateTime:
        return 'DateTime';
      case TypeCode.Duration:
        return 'Duration';
      case TypeCode.Object:
        return 'object';
      case TypeCode.Enum:
        return 'enum';
      case TypeCode.Array:
        return 'List';
      case TypeCode.Map:
        return 'Map';
      default:
        return 'unknown';
    }
  }
}
