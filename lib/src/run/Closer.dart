import 'dart:async';

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
	 * - correlationId 	(optional) transaction id to trace execution through call chain.
	 * - component 		the component that is to be closed.
     * - callback 			callback function that receives error or null no errors occured.
	 * 
	 * See [[IClosable]]
	 */
  static Future closeOne(String correlationId, component) async {
    if (component is IClosable) await component.close(correlationId);
  }

  /**
	 * Closes multiple components.
	 * 
	 * To be closed components must implement [[ICloseable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * - correlationId 	(optional) transaction id to trace execution through call chain.
	 * - components 		the list of components that are to be closed.
     * - callback 			callback function that receives error or null no errors occured.
	 * 
	 * See [[closeOne]]
	 * See [[IClosable]]
	 */
  static Future close(String correlationId, List components) async {
    if (components == null) return;

    for (var component in components) {
      await Closer.closeOne(correlationId, component);
    }
  }
}
