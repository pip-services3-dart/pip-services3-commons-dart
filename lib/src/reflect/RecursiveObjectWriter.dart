import '../convert/IntegerConverter.dart';
import './ObjectReader.dart';
import './ObjectWriter.dart';
import './RecursiveObjectReader.dart';

/**
 * Helper class to perform property introspection and dynamic writing.
 * 
 * It is similar to [[ObjectWriter]] but writes properties recursively
 * through the entire object graph. Nested property names are defined
 * using dot notation as "object.subobject.property"
 *
 * @see [[PropertyReflector]]
 * @see [[ObjectWriter]]
 */
class RecursiveObjectWriter {
  static _createProperty(obj, List<String> names, int nameIndex) {
    // If next field is index then create an array
    var subField = names.length > nameIndex + 1 ? names[nameIndex + 1] : null;
    var subFieldIndex = IntegerConverter.toNullableInteger(subField);
    if (subFieldIndex != null) return [];

    // Else create a map
    return {};
  }

  static _performSetProperty(obj, List<String> names, int nameIndex, value) {
    if (nameIndex < names.length - 1) {
      var subObj = ObjectReader.getProperty(obj, names[nameIndex]);
      if (subObj != null)
        RecursiveObjectWriter._performSetProperty(
            subObj, names, nameIndex + 1, value);
      else {
        subObj = RecursiveObjectWriter._createProperty(obj, names, nameIndex);
        if (subObj != null) {
          RecursiveObjectWriter._performSetProperty(
              subObj, names, nameIndex + 1, value);
          ObjectWriter.setProperty(obj, names[nameIndex], subObj);
        }
      }
    } else
      ObjectWriter.setProperty(obj, names[nameIndex], value);
  }

  /**
	 * Recursively sets value of object and its subobjects property specified by its name.
	 * 
     * The object can be a user defined object, map or array.
     * The property name correspondently must be object property,
     * map key or array index.
	 * 
	 * If the property does not exist or introspection fails
	 * this method doesn't do anything and doesn't any throw errors.
	 * 
	 * @param obj 	an object to write property to.
	 * @param name 	a name of the property to set.
	 * @param value a new value for the property to set.
	 */
  static void setProperty(obj, String name, value) {
    if (obj == null || name == null) return;

    var names = name.split(".");
    if (names == null || names.length == 0) return;

    RecursiveObjectWriter._performSetProperty(obj, names, 0, value);
  }

  /**
	 * Recursively sets values of some (all) object and its subobjects properties.
	 * 
     * The object can be a user defined object, map or array.
     * Property values correspondently are object properties,
     * map key-pairs or array elements with their indexes.
	 * 
	 * If some properties do not exist or introspection fails
	 * they are just silently skipped and no errors thrown.
	 * 
	 * @param obj 		 an object to write properties to.
	 * @param values 	a map, containing property names and their values.
	 * 
	 * @see [[setProperty]]
	 */
  static void setProperties(obj, Map<String, dynamic> values) {
    if (values == null) return;

    for (var key in values.keys) {
      var value = values[key];
      RecursiveObjectWriter.setProperty(obj, key, value);
    }
  }

  /**
	 * Copies content of one object to another object
	 * by recursively reading all properties from source object
	 * and then recursively writing them to destination object.
	 * 
	 * @param dest 	a destination object to write properties to.
	 * @param src 	a source object to read properties from
	 */
  static void copyProperties(dest, src) {
    if (dest == null || src == null) return;

    var values = RecursiveObjectReader.getProperties(src);
    RecursiveObjectWriter.setProperties(dest, values);
  }
}
