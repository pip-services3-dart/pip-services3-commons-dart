import 'dart:async';

import './ICleanable.dart';

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
  static Future clearOne(String correlationId, component) async {
    if (component is ICleanable) await component.clear(correlationId);
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
  static Future clear(String correlationId, List components) async {
    if (components == null) return;

    for (var component in components)
      await Cleaner.clearOne(correlationId, component);
  }
}
