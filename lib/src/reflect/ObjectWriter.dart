import './IValueWrapper.dart';
import './PropertyReflector.dart';
import '../convert/IntegerConverter.dart';


/// Helper class to perform property introspection and dynamic writing.
/// 
/// In contrast to [PropertyReflector] which only introspects regular objects,
/// this ObjectWriter is also able to handle maps and arrays.
/// For maps properties are key-pairs identified by string keys,
/// For arrays properties are elements identified by integer index.
/// 
/// This class has symmetric implementation across all languages supported
/// by Pip.Services toolkit and used to support dynamic data processing.
/// 
/// Because all languages have different casing and case sensitivity rules,
/// this ObjectWriter treats all property names as case insensitive.

/// See [PropertyReflector]
/// 
/// ### Example ###
/// 
///     var myObj =  MyObject();
///     
///     ObjectWriter.setProperty(myObj, 'myProperty', 123);
///     
///     var myMap = { key1: 123, key2: 'ABC' };
///     ObjectWriter.setProperty(myMap, 'key1', 'XYZ');
///     
///     var myArray = [1, 2, 3]
///     ObjectWriter.setProperty(myArray, '0', 123);
 
class ObjectWriter {
  
	/// Sets value of object property specified by its name.
	/// 
  /// The object can be a user defined object, map or array.
  /// The property name correspondently must be object property,
  /// map key or array index.
	/// 
	/// If the property does not exist or introspection fails
	/// this method doesn't do anything and doesn't any throw errors.
	/// 
	/// - [obj] 	an object to write property to.
	/// - [name] 	a name of the property to set.
	/// - [value] a new value for the property to set.
	 
  static void setProperty(obj, String name, value) {
    if (obj == null) throw  Exception('Object cannot be null');
    if (name == null) throw  Exception('Property name cannot be null');

    if (obj is IValueWrapper) obj = obj.innerValue();

    if (obj is Map) {
      try {
        var targetKey = name.toLowerCase();
        var foundKey = null;
        for (var key in obj.keys) {
          if (key.toString().toString() == targetKey) {
            foundKey = key;
            break;
          }
        }
        foundKey = foundKey ?? name;
        obj[foundKey] = value;
      } catch (e) {
        // Ignore exceptions
      }
    } else if (obj is List) {
      try {
        var index = IntegerConverter.toNullableInteger(name);
        if (index >= 0) {
          while (index > obj.length - 1) {
            obj.add(null);
          }
          obj[index] = value;
        }
      } catch (e) {
        // Ignore exceptions
      }
    } else {
      return PropertyReflector.setProperty(obj, name, value);
    }
  }

  
	/// Sets values of some (all) object properties.
	/// 
  /// The object can be a user defined object, map or array.
  /// Property values correspondently are object properties,
  /// map key-pairs or array elements with their indexes.
	/// 
	/// If some properties do not exist or introspection fails
	/// they are just silently skipped and no errors thrown.
	/// 
	/// - [obj] 		 an object to write properties to.
	/// - [values] 	a map, containing property names and their values.
	/// 
	/// See [setProperty]
	 
  static void setProperties(obj, Map<String, dynamic> values) {
    if (values == null) return;

    for (var key in values.keys) {
      var value = values[key];
      ObjectWriter.setProperty(obj, key, value);
    }
  }
}
