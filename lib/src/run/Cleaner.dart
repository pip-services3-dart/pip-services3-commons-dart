import 'dart:async';

/**
 * Helper class that cleans stored object state.
 * 
 * @see [[ICleanable]]
 */
class Cleaner {
  /**
	 * Clears state of specific component.
	 * 
	 * To be cleaned state components must implement [[ICleanable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param component 		the component that is to be cleaned.
     * @param callback 			callback function that returns error or null no errors occured.
	 * 
	 * @see [[ICleanable]]
	 */
  static void clearOne(String correlationId, dynamic component,
      [callback(dynamic err) = null]) {
    if (component.clear is Function) {
      try {
        component.clear(correlationId);
      } catch (err) {
        if (callback != null)
          callback(err);
        else
          throw err;
      }
    } else if (callback != null) callback(null);
  }

  /**
	 * Clears state of multiple components.
	 * 
	 * To be cleaned state components must implement [[ICleanable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param components 		the list of components that are to be cleaned.
     * @param callback 			callback function that returns error or null no errors occured.
	 * 
	 * @see [[clearOne]]
	 * @see [[ICleanable]]
	 */
  static void clear(String correlationId, List<dynamic> components,
      [callback(dynamic err)]) async {
   await Future.forEach(components, (dynamic component) {
      return Future<dynamic>(() {
        var err;
        Cleaner.clearOne(correlationId, component, (e) {
          err = e;
        });
        return err;
      });
    }).then((dynamic err) {
      if (callback != null)
        callback(err);
      else if (err != null) throw err;
    });
  }
}
