import 'dart:mirrors';


/// Helper class to perform property introspection and dynamic reading and writing.
/// 
/// This class has symmetric implementation across all languages supported
/// by Pip.Services toolkit and used to support dynamic data processing.
/// 
/// Because all languages have different casing and case sensitivity rules,
/// this PropertyReflector treats all property names as case insensitive.
/// 
/// ### Example ###
/// 
///     var myObj = new MyObject();
///     
///     var properties = PropertyReflector.getPropertyNames();
///     PropertyReflector.hasProperty(myObj, "myProperty");
///     var value = PropertyReflector.getProperty(myObj, "myProperty");
///     PropertyReflector.setProperty(myObj, "myProperty", 123);
 
class PropertyReflector {
  static String _extractName(Symbol field) {
    var name = field.toString();
    var pos = name.indexOf('("');
    name = name.substring(pos + 2, name.length - 2);
    if (name.endsWith('=')) name = name.substring(0, name.length - 1);
    return name;
  }

  static bool _matchField(Symbol field, String expectedName) {
    if (expectedName == null) return true;

    var fieldName = field.toString().toLowerCase();
    var matchName = 'symbol("' + expectedName + '")';
    return fieldName == matchName;
  }

  static Symbol _findReadField(obj, String name) {
    name = name.toLowerCase();
    var cm = reflectClass(obj.runtimeType);
    for (var dm in cm.declarations.values) {
      if (dm is VariableMirror && !dm.isStatic && !dm.isPrivate) {
        if (_matchField(dm.simpleName, name)) return dm.simpleName;
      } else if (dm is MethodMirror &&
          dm.isGetter &&
          !dm.isStatic &&
          !dm.isPrivate) {
        if (_matchField(dm.simpleName, name)) return dm.simpleName;
      }
    }
    return null;
  }

  static Symbol _findWriteField(obj, String name) {
    name = name.toLowerCase();
    var cm = reflectClass(obj.runtimeType);
    for (var dm in cm.declarations.values) {
      if (dm is VariableMirror && !dm.isStatic && !dm.isPrivate) {
        if (_matchField(dm.simpleName, name)) return dm.simpleName;
      } else if (dm is MethodMirror &&
          dm.isSetter &&
          !dm.isStatic &&
          !dm.isPrivate) {
        if (_matchField(dm.simpleName, name + "=")) return dm.simpleName;
      }
    }
    return null;
  }

  
	/// Checks if object has a property with specified name..
	/// 
	/// - [obj] 	an object to introspect.
	/// - [name] 	a name of the property to check.
	/// Returns true if the object has the property and false if it doesn't.
	 
  static bool hasProperty(obj, String name) {
    if (obj == null) throw new Exception("Object cannot be null");
    if (name == null) throw new Exception("Property name cannot be null");

    var foundName = _findReadField(obj, name);

    return foundName != null;
  }

  
	/// Gets value of object property specified by its name.
	/// 
	/// - [obj] 	an object to read property from.
	/// - [name] 	a name of the property to get.
	/// Returns the property value or null if property doesn't exist or introspection failed.
	 
  static getProperty(obj, String name) {
    if (obj == null) throw new Exception("Object cannot be null");
    if (name == null) throw new Exception("Property name cannot be null");

    var foundName = _findReadField(obj, name);
    if (foundName != null) {
      try {
        var im = reflect(obj);
        return im.getField(foundName).reflectee;
      } catch (e) {
        // Ignore exceptions
      }
    }

    return null;
  }

  
    /// Gets names of all properties implemented in specified object.
    /// 
    /// - [obj]   an objec to introspect.
    /// Returns a list with property names.
     
  static List<String> getPropertyNames(obj) {
    var properties = new List<String>();

    var cm = reflectClass(obj.runtimeType);
    for (var dm in cm.declarations.values) {
      Symbol foundName = null;

      if (dm is VariableMirror && !dm.isStatic && !dm.isPrivate)
        foundName = dm.simpleName;
      else if (dm is MethodMirror &&
          dm.isGetter &&
          !dm.isStatic &&
          !dm.isPrivate) foundName = dm.simpleName;

      if (foundName != null) properties.add(_extractName(foundName));
    }

    return properties;
  }

  
    /// Get values of all properties in specified object
	/// and returns them as a map.
    /// 
    /// - [obj]   an object to get properties from.
    /// Returns a map, containing the names of the object's properties and their values.
     
  static Map<String, dynamic> getProperties(obj) {
    var map = new Map<String, dynamic>();

    var cm = reflectClass(obj.runtimeType);
    var im = reflect(obj);
    for (var dm in cm.declarations.values) {
      Symbol foundName = null;

      if (dm is VariableMirror && !dm.isStatic && !dm.isPrivate)
        foundName = dm.simpleName;
      else if (dm is MethodMirror &&
          dm.isGetter &&
          !dm.isStatic &&
          !dm.isPrivate) foundName = dm.simpleName;

      if (foundName != null) {
        try {
          var name = _extractName(foundName);
          var value = im.getField(foundName).reflectee;
          map[name] = value;
        } catch (ex) {
          // Ignore exceptions...
        }
      }
    }

    return map;
  }

  
	/// Sets value of object property specified by its name.
	/// 
	/// If the property does not exist or introspection fails
	/// this method doesn't do anything and doesn't any throw errors.
	/// 
	/// - [obj] 	an object to write property to.
	/// - [name] 	a name of the property to set.
	/// - [value] a new value for the property to set.
     
  static void setProperty(obj, String name, value) {
    if (obj == null) throw new Exception("Object cannot be null");
    if (name == null) throw new Exception("Property name cannot be null");

    var foundName = _findWriteField(obj, name);
    if (foundName != null) {
      try {
        var im = reflect(obj);
        // Fix name for setters which have '=' at the end
        foundName = new Symbol(_extractName(foundName));
        im.setField(foundName, value);
      } catch (ex) {
        // Ignore exceptions...
      }
    }
  }

  
	/// Sets values of some (all) object properties.
	/// 
	/// If some properties do not exist or introspection fails
	/// they are just silently skipped and no errors thrown.
	/// 
	/// - [obj] 		 an object to write properties to.
	/// - [values] 	a map, containing property names and their values.
	/// 
	/// See [[setProperty]]
	 
  static void setProperties(obj, Map<String, dynamic> values) {
    if (values == null) return;

    for (var field in values.keys) {
      var fieldValue = values[field];
      PropertyReflector.setProperty(obj, field, fieldValue);
    }
  }
}
