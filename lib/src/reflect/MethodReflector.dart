import 'dart:mirrors';

/**
 * Helper class to perform method introspection and dynamic invocation.
 * 
 * This class has symmetric implementation across all languages supported
 * by Pip.Services toolkit and used to support dynamic data processing.
 * 
 * Because all languages have different casing and case sensitivity rules,
 * this MethodReflector treats all method names as case insensitive.
 * 
 * ### Example ###
 * 
 *     let myObj = new MyObject();
 *     
 *     let methods = MethodReflector.getMethodNames();
 *     MethodReflector.hasMethod(myObj, "myMethod");
 *     MethodReflector.invokeMethod(myObj, "myMethod", 123);
 */
class MethodReflector {
  static String _extractName(Symbol field) {
    var name = field.toString();
    var pos = name.indexOf('("');
    name = name.substring(pos + 2, name.length - 2);
    if (name.endsWith('=')) name = name.substring(0, name.length - 1);
    return name;
  }

  static bool _matchMethod(Symbol field, String expectedName) {
    if (expectedName == null) return true;

    var fieldName = field.toString().toLowerCase();
    var matchName = 'symbol("' + expectedName + '")';
    return fieldName == matchName;
  }

  static Symbol _findMethod(obj, String name) {
    name = name.toLowerCase();
    var cm = reflectClass(obj.runtimeType);
    for (var dm in cm.instanceMembers.values) {
      if (dm is MethodMirror &&
          !dm.isGetter &&
          !dm.isSetter &&
          !dm.isStatic &&
          !dm.isPrivate) {
        if (_matchMethod(dm.simpleName, name)) return dm.simpleName;
      }
    }
    return null;
  }

  /**
	 * Checks if object has a method with specified name..
	 * 
	 * - obj 	an object to introspect.
	 * - name 	a name of the method to check.
	 * Returns true if the object has the method and false if it doesn't.
	 */
  static bool hasMethod(obj, String name) {
    if (obj == null) throw new Exception("Object cannot be null");
    if (name == null) throw new Exception("Method name cannot be null");

    var foundName = _findMethod(obj, name);
    return foundName != null;
  }

  /**
	 * Invokes an object method by its name with specified parameters.
	 * 
	 * - obj 	an object to invoke.
	 * - name 	a name of the method to invoke.
	 * - args 	a list of method arguments.
	 * Returns the result of the method invocation or null if method returns void.
	 */
  static invokeMethod(obj, String name, List args) {
    if (obj == null) throw new Exception("Object cannot be null");
    if (name == null) throw new Exception("Method name cannot be null");

    var foundName = _findMethod(obj, name);
    if (foundName != null) {
      try {
        var im = reflect(obj);
        return im.invoke(foundName, args).reflectee;
      } catch (ex) {
        // Ignore exceptions
      }
    }

    return null;
  }

  /**
     * Gets names of all methods implemented in specified object.
     * 
     * - obj   an objec to introspect.
     * Returns a list with method names.
     */
  static List<String> getMethodNames(obj) {
    var methods = new List<String>();

    var cm = reflectClass(obj.runtimeType);
    for (var dm in cm.instanceMembers.values) {
      Symbol foundName = null;

      if (dm is MethodMirror &&
          !dm.isGetter &&
          !dm.isSetter &&
          !dm.isStatic &&
          !dm.isPrivate) foundName = dm.simpleName;

      if (foundName != null) methods.add(_extractName(foundName));
    }

    return methods;
  }
}
