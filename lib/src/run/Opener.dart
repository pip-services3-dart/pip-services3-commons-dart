import 'dart:async';

<<<<<<< HEAD
import './IOpenable.dart';

/**
 * Helper class that opens components.
 * 
 * [[IOpenable]]
 */
class Opener {
	/**
	 * Checks if specified component is opened.
	 * 
	 * To be checked components must implement [[IOpenable]] interface.
	 * If they don't the call to this method returns true.
	 * 
	 * @param component 	the component that is to be checked.
	 * @returns true if component is opened and false otherwise.
	 * 
	 * @see [[IOpenable]]
	 */
	static bool isOpenOne(component) {
		if (component is IOpenable)
			return component.isOpen();
		else
			return true;
	}	

	/**
=======
/**
 * Helper class that opens components.
 * 
 * [[IOpenable]]
 */
class Opener {
  /**
	 * Checks if specified component is opened.
	 * 
	 * To be checked components must implement [[IOpenable]] interface.
	 * If they don't the call to this method returns true.
	 * 
	 * @param component 	the component that is to be checked.
	 * @returns true if component is opened and false otherwise.
	 * 
	 * @see [[IOpenable]]
	 */
  static bool isOpenOne(dynamic component) {
    if (component.isOpen is Function)
      return component.isOpen();
    else
      return true;
  }

  /**
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
	 * Checks if all components are opened.
	 * 
	 * To be checked components must implement [[IOpenable]] interface.
	 * If they don't the call to this method returns true.
	 * 
	 * @param components 	a list of components that are to be checked.
	 * @returns true if all components are opened and false if at least one component is closed.
	 * 
	 * @see [[isOpenOne]]
	 * @see [[IOpenable]]
	 */
<<<<<<< HEAD
	static bool isOpen(List components) {
		if (components == null) return true;
		
		var result = true;
		for (var component in components)
			result = result && Opener.isOpenOne(component);
		
		return result;
	}

	/**
	 * Opens specific component.
	 * 
	 * To be opened components must implement [[IOpenable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param component 		the component that is to be opened.
     * @param callback 			callback function that returns error or null no errors occured.
	 * 
	 * @see [[IOpenable]]
	 */
	static Future openOne(String correlationId, component) async {
    if (component is IOpenable)
      await component.open(correlationId);
	}	

	/**
	 * Opens multiple components.
	 * 
	 * To be opened components must implement [[IOpenable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param components 		the list of components that are to be closed.
     * @param callback 			callback function that returns error or null no errors occured.
	 * 
	 * @see [[openOne]]
	 * @see [[IOpenable]]
	 */
	static Future open(String correlationId, List components) async {
		if (components == null) return true;

    for (var component in components) {
      if (component is IOpenable)
        await component.open(correlationId);
    }
	}

=======
  static bool isOpen(List<dynamic> components) {
    if (components == null) return true;

    var result = true;
    for (var index = 0; index < components.length; index++)
      result = result && Opener.isOpenOne(components[index]);

    return result;
  }

  /**
	 * Opens specific component.
	 * 
	 * To be opened components must implement [[IOpenable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param component 		the component that is to be opened.
     * @param callback 			callback function that returns error or null no errors occured.
	 * 
	 * @see [[IOpenable]]
	 */
  static void openOne(String correlationId, dynamic component,
      [callback(dynamic err)]) {
    if (component.open is Function) {
      try {
        component.open(correlationId, callback);
      } catch (err) {
        if (callback != null)
          callback(err);
        else if (err) throw err;
      }
    } else if (callback != null) callback(null);
  }

  /**
	 * Opens multiple components.
	 * 
	 * To be opened components must implement [[IOpenable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param components 		the list of components that are to be closed.
     * @param callback 			callback function that returns error or null no errors occured.
	 * 
	 * @see [[openOne]]
	 * @see [[IOpenable]]
	 */
  static void open(String correlationId, List<dynamic> components,
      [callback(dynamic err)]) async {
    await Future.forEach(components, (component) {
      return Future<dynamic>(() {
        var err;
        Opener.openOne(correlationId, component, (e) {
          err = e;
        });
        return err;
      });
    }).then((err) {
      if (callback != null)
        callback(err);
      else if (err) throw err;
    });
  }
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
}
