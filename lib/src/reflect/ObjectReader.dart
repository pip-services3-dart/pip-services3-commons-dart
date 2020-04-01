import './IValueWrapper.dart';
import './PropertyReflector.dart';
import '../convert/IntegerConverter.dart';

/// Helper class to perform property introspection and dynamic reading.
///
/// In contrast to [PropertyReflector] which only introspects regular objects,
/// this ObjectReader is also able to handle maps and arrays.
/// For maps properties are key-pairs identified by string keys,
/// For arrays properties are elements identified by integer index.
///
/// This class has symmetric implementation across all languages supported
/// by Pip.Services toolkit and used to support dynamic data processing.
///
/// Because all languages have different casing and case sensitivity rules,
/// this ObjectReader treats all property names as case insensitive.

/// See [PropertyReflector]
///
/// ### Example ###
///
///     var myObj =  MyObject();
///
///     var properties = ObjectReader.getPropertyNames();
///     ObjectReader.hasProperty(myObj, 'myProperty');
///     var value = PropertyReflector.getProperty(myObj, 'myProperty');
///
///     var myMap = { 'key1': 123, 'key2': 'ABC' };
///     ObjectReader.hasProperty(myMap, 'key1');
///     var value = ObjectReader.getProperty(myMap, 'key1');
///
///     var myArray = [1, 2, 3]
///     ObjectReader.hasProperty(myArrat, '0');
///     var value = ObjectReader.getProperty(myArray, '0');

class ObjectReader {
  /// Gets a real object value.
  /// If object is a wrapper, it unwraps the value behind it.
  /// Otherwise it returns the same object value.
  ///
  /// - [obj]   an object to unwrap..
  /// Returns an actual (unwrapped) object value.

  static getValue(obj) {
    if (obj is IValueWrapper) return obj.innerValue();
    return obj;
  }

  /// Checks if object has a property with specified name.
  ///
  /// The object can be a user defined object, map or array.
  /// The property name correspondently must be object property,
  /// map key or array index.
  ///
  /// - [obj] 	an object to introspect.
  /// - [name] 	a name of the property to check.
  /// Returns true if the object has the property and false if it doesn't.

  static bool hasProperty(obj, String name) {
    if (obj == null || name == null) {
      return false;
    }

    if (obj is IValueWrapper) obj = obj.innerValue();

    if (obj is Map) {
      var targetKey = name.toLowerCase();
      for (var key in obj.keys) {
        if (key.toString().toString() == targetKey) return true;
      }
    } else if (obj is List) {
      var index = IntegerConverter.toNullableInteger(name);
      return index != null && index < obj.length;
    } else {
      return PropertyReflector.hasProperty(obj, name);
    }

    return false;
  }

  /// Gets value of object property specified by its name.
  ///
  /// The object can be a user defined object, map or array.
  /// The property name correspondently must be object property,
  /// map key or array index.
  ///
  /// - [obj] 	an object to read property from.
  /// - [name] 	a name of the property to get.
  /// Returns the property value or null if property doesn't exist or introspection failed.

  static getProperty(obj, String name) {
    if (obj == null || name == null) {
      return null;
    }

    if (obj is IValueWrapper) obj = obj.innerValue();

    if (obj is Map) {
      var targetKey = name.toLowerCase();
      for (var key in obj.keys) {
        if (key.toString().toString() == targetKey) return obj[key];
      }
    } else if (obj is List) {
      var index = IntegerConverter.toNullableInteger(name);
      return index != null && index < obj.length ? obj[index] : null;
    } else {
      return PropertyReflector.getProperty(obj, name);
    }

    return null;
  }

  /// Gets names of all properties implemented in specified object.
  ///
  /// The object can be a user defined object, map or array.
  /// Returned property name correspondently are object properties,
  /// map keys or array indexes.
  ///
  /// - [obj]   an objec to introspect.
  /// Returns a list with property names.

  static List<String> getPropertyNames(obj) {
    var properties = List<String>();

    if (obj is IValueWrapper) obj = obj.innerValue();

    if (obj == null) {
      // Do nothing
    } else if (obj is Map) {
      for (var key in obj.keys) {
        properties.add(key.toString());
      }
    } else if (obj is List) {
      for (var index = 0; index < obj.length; index++) {
        properties.add(index.toString());
      }
    } else {
      properties = PropertyReflector.getPropertyNames(obj);
    }

    return properties;
  }

  /// Get values of all properties in specified object
  /// and returns them as a map.
  ///
  /// The object can be a user defined object, map or array.
  /// Returned properties correspondently are object properties,
  /// map key-pairs or array elements with their indexes.
  ///
  /// - [obj]   an object to get properties from.
  /// Returns a map, containing the names of the object's properties and their values.

  static Map<String, dynamic> getProperties(obj) {
    var map = Map<String, dynamic>();

    if (obj is IValueWrapper) obj = obj.innerValue();

    if (obj == null) {
      // Do nothing
    } else if (obj is Map) {
      for (var key in obj.keys) {
        map[key.toString()] = obj[key];
      }
    } else if (obj is List) {
      for (var index = 0; index < obj.length; index++) {
        map[index.toString()] = obj[index];
      }
    } else {
      map = PropertyReflector.getProperties(obj);
    }

    return map;
  }
}
