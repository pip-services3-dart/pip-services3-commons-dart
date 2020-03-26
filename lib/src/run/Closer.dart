import 'dart:async';

<<<<<<< HEAD
import './IClosable.dart';

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
	static Future closeOne(String correlationId, component) async {
    if (component is IClosable)
      await component.close(correlationId);
	}

	/**
=======
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
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
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
<<<<<<< HEAD
	static Future close(String correlationId, List components) async {
		if (components == null) return;

    for (var component in components) {
      await Closer.closeOne(correlationId, component);
    }
	}
=======
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
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
}
