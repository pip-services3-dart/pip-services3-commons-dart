import 'dart:async';

/**
 * Helper class that closes previously opened components.
 * 
 * [[ICloseable]]
 */
class Closer {
  /**
	 * Closes specific component.
	 * 
	 * To be closed components must implement [[ICloseable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param component 		the component that is to be closed.
     * @param callback 			callback function that receives error or null no errors occured.
	 * 
	 * @see [[IClosable]]
	 */
  static void closeOne(String correlationId, dynamic component,
      [callback(dynamic err)]) {
    if (component.close is Function) {
      try {
        component.close(correlationId, callback);
      } catch (err) {
        if (callback != null)
          callback(err);
        else
          throw err;
      }
    } else if (callback != null) callback(null);
  }

  /**
	 * Closes multiple components.
	 * 
	 * To be closed components must implement [[ICloseable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param components 		the list of components that are to be closed.
     * @param callback 			callback function that receives error or null no errors occured.
	 * 
	 * @see [[closeOne]]
	 * @see [[IClosable]]
	 */
  static void close(String correlationId, List<dynamic> components,
      [callback(dynamic err)]) async {
    await Future.forEach(components, (dynamic component) {
      return Future<dynamic>(() {
        var err;
        Closer.closeOne(correlationId, component, (e){
          err = e;
        });
        return err;
      });
    }).then((dynamic err) {
      if (callback != null)
        callback(err);
      else if (err) throw err;
    });
  }
}
