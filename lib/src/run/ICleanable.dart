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
 *         public clear(correlationId: string): void {
 *             this._state = {};
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
  void clear(String correlationId, [callback(dynamic err) = null]);
}
