import 'LongConverter.dart';


/// Converts arbitrary values into integers using extended conversion rules:
/// - Strings are converted to floats, then to integers
/// - DateTime: total number of milliseconds since unix epoсh
/// - Boolean: 1 for true and 0 for false
/// 
/// ### Example ###
/// 
///     var value1 = IntegerConverter.toNullableInteger('ABC'); // Result: null
///     var value2 = IntegerConverter.toNullableInteger('123.456'); // Result: 123
///     var value3 = IntegerConverter.toNullableInteger(true); // Result: 1
///     var value4 = IntegerConverter.toNullableInteger(new Date()); // Result: current milliseconds
 
class IntegerConverter {
  
    /// Converts value into integer or returns null when conversion is not possible.
    /// 
    /// - [value]     the value to convert.
    /// Returns         integer value or null when conversion is not supported.
    /// 
    /// See [[LongConverter.toNullableLong]]
     
  static int toNullableInteger(value) {
    return LongConverter.toNullableLong(value);
  }

  
    /// Converts value into integer or returns 0 when conversion is not possible.
    ///  
    /// - [value]     the value to convert.
    /// Returns         integer value or 0 when conversion is not supported.
    /// 
    /// See [[LongConverter.toLong]]
    /// See [[LongConverter.toLongWithDefault]]
     
  static int toInteger(value) {
    return LongConverter.toLong(value);
  }

  
    /// Converts value into integer or returns default value when conversion is not possible.
    /// 
    /// - [value]         the value to convert.
    /// - defaultValue  the default value.
    /// Returns             integer value or default when conversion is not supported. 
    /// 
    /// See [[LongConverter.toLongWithDefault]]
    /// See [[LongConverter.toNullableLong]]
     
  static int toIntegerWithDefault(value, int defaultValue) {
    return LongConverter.toLongWithDefault(value, defaultValue);
  }
}
