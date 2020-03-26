<<<<<<< HEAD
import 'dart:async';

=======
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
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
<<<<<<< HEAD
 *         Future clear(correlationId: string) {
 *            this._state = {};
 *            return new Future();
=======
 *         public clear(correlationId: string): void {
 *             this._state = {};
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
 *         }
 *     }
 * 
 */
abstract class ICleanable {
<<<<<<< HEAD
	/**
	 * Clears component state.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
   * @param callback 			callback function that receives error or null no errors occured.
	 */
	Future clear(String correlationId);
=======
  /**
	 * Clears component state.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
     * @param callback 			callback function that receives error or null no errors occured.
	 */
  void clear(String correlationId, [callback(dynamic err) = null]);
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
}
