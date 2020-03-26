import 'dart:cli';
import 'dart:io';
import 'dart:mirrors';

import './TypeDescriptor.dart';
import '../errors/NotFoundException.dart';
import '../convert/TypeCode.dart';
import '../convert/TypeConverter.dart';

/**
 * Helper class to perform object type introspection and object instantiation.
 * 
 * This class has symmetric implementation across all languages supported
 * by Pip.Services toolkit and used to support dynamic data processing.
 * 
 * Because all languages have different casing and case sensitivity rules,
 * this TypeReflector treats all type names as case insensitive.
 * 
 * @see [[TypeDescriptor]]
 * 
 * ### Example ###
 * 
 *     var descriptor = new TypeDescriptor("MyObject", "mylibrary");
 *     Typeeflector.getTypeByDescriptor(descriptor);
 *     var myObj = TypeReflector.createInstanceByDescriptor(descriptor);
 *     
 *     TypeDescriptor.isPrimitive(myObject); 		// Result: false
 *     TypeDescriptor.isPrimitive(123);				// Result: true
 */
class TypeReflector {
  static Type _findType(LibraryMirror lib, String name) {
    var typeName = new Symbol(name);
    for (var declaration in lib.declarations.values) {
      if (declaration is ClassMirror && declaration.simpleName == typeName) {
        return declaration.reflectedType;
      }
    }
    return null;
  }

  /**
	 * Gets object type by its name and library where it is defined.
	 * 
	 * @param name 		an object type name.
	 * @param library 	a library where the type is defined
	 * @returns the object type or null is the type wasn't found.
	 */
  static Type getType(String name, [String library = null]) {
    // If library is not defined then scan all loaded libraries
    if (library == null) {
      for (var lib in currentMirrorSystem().libraries.values) {
        var result = _findType(lib, name);
        if (result != null) return result;
      }
      return null;
    }

    // Load library dynamically
    try {
      Uri libraryUri;

      // When library defined as URI
      if (library.startsWith("package:") ||
          library.startsWith("dart:") ||
          library.startsWith("file:")) {
        libraryUri = Uri.parse(library);
      }
      // Otherwise treat it as a file
      else {
        // Add current directory to the relative path
        if (library.startsWith("."))
          library = Directory.current.path + "/" + library;
        libraryUri = Uri.file(library);
      }

      // Load the library synchronously
      var lib = waitFor(currentMirrorSystem().isolate.loadUri(libraryUri));
      var result = _findType(lib, name);

      return result;
    } catch (ex) {
      return null;
    }
  }

  /**
	 * Gets object type by type descriptor.
	 * 
	 * @param descriptor 	a type descriptor that points to an object type
	 * @returns the object type or null is the type wasn't found.
	 * 
	 * @see [[getType]]
	 * @see [[TypeDescriptor]]
	 */
  static Type getTypeByDescriptor(TypeDescriptor descriptor) {
    if (descriptor == null)
      throw new Exception("Type descriptor cannot be null");

    return TypeReflector.getType(descriptor.getName(), descriptor.getLibrary());
  }

  /**
	 * Creates an instance of an object type.
	 * 
	 * @param type 		an object type (factory function) to create.
	 * @param args		arguments for the object constructor.
	 * @returns the created object instance.
	 */
  static createInstanceByType(Type type, List args) {
    if (type == null) throw new Exception("Type constructor cannot be null");

    var cm = reflectClass(type);
    var im = cm.newInstance(Symbol(''), args ?? []);
    return im.reflectee;
  }

  /**
	 * Creates an instance of an object type specified by its name
	 * and library where it is defined.
	 * 
	 * @param name 		an object type name.
	 * @param library 	a library (module) where object type is defined.
	 * @param args		arguments for the object constructor.
	 * @returns the created object instance.
	 * 
	 * @see [[getType]]
	 * @see [[createInstanceByType]]
	 */
  static createInstance(String name, String library, List args) {
    var type = TypeReflector.getType(name, library);
    if (type == null) {
      throw new NotFoundException(null, "TYPE_NOT_FOUND",
              "Type " + name + "," + library + " was not found")
          .withDetails("type", name)
          .withDetails("library", library);
    }

    return TypeReflector.createInstanceByType(type, args);
  }

  /**
	 * Creates an instance of an object type specified by type descriptor.
	 * 
	 * @param descriptor 	a type descriptor that points to an object type
	 * @param args		arguments for the object constructor.
	 * @returns the created object instance.
	 * 
	 * @see [[createInstance]]
	 * @see [[TypeDescriptor]]
	 */
  static createInstanceByDescriptor(TypeDescriptor descriptor, List args) {
    if (descriptor == null)
      throw new Exception("Type descriptor cannot be null");

    return TypeReflector.createInstance(
        descriptor.getName(), descriptor.getLibrary(), args);
  }

  /**
	 * Checks if value has primitive type.
	 * 
	 * Primitive types are: numbers, strings, booleans, date and time.
	 * Complex (non-primitive types are): objects, maps and arrays
	 * 
	 * @param value 	a value to check
	 * @returns true if the value has primitive type and false if value type is complex.
	 * 
	 * @see [[TypeConverter.toTypeCode]]
	 * @see [[TypeCode]]
	 */
  static bool isPrimitive(value) {
    var typeCode = TypeConverter.toTypeCode(value);
    return typeCode == TypeCode.String ||
        typeCode == TypeCode.Enum ||
        typeCode == TypeCode.Boolean ||
        typeCode == TypeCode.Integer ||
        typeCode == TypeCode.Long ||
        typeCode == TypeCode.Float ||
        typeCode == TypeCode.Double ||
        typeCode == TypeCode.DateTime ||
        typeCode == TypeCode.Duration;
  }
}
