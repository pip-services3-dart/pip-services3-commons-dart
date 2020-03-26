import 'dart:async';

/**
 * Interface for components that should clean their state.
 * 
 * Cleaning state most often is used during testing. 
 * But there may be situations when it can be done in production.
 * 
 * @see [[Cleaner]]
 * 
 * ### Example ###
 * 
 *     class MyObjectWithState implements ICleanable {
 *         private _state: any = {};
 *         ...
 *         Future clear(correlationId: string) {
 *            this._state = {};
 *            return new Future();
 *         }
 *     }
 * 
 */
abstract class ICleanable {
  /**
	 * Clears component state.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
   * @param callback 			callback function that receives error or null no errors occured.
	 */
  Future clear(String correlationId);
}
