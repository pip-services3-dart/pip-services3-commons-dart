/** @module run */
import './IClosable.dart';

/**
 * Interface for components that require explicit opening and closing.
 * 
 * For components that perform opening on demand consider using
 * [[ICloseable]] interface instead.
 * 
 * @see [[IOpenable]]
 * @see [[Opener]]
 * 
 * ### Example ###
 * 
 *     class MyPersistence implements IOpenable {
 *         private _client: any;
 *         ...
 *         public isOpen(): boolean {
 *             return this._client != null;
 *         } 
 *         
 *         public open(correlationId: string, callback: (err: any) => void): void {
 *             if (this.isOpen()) {
 *                 callback(null);
 *                 return;
 *             }
 *             ...
 *         }
 *         
 *         public close(correlationId: string, callback: (err: any) => void): void {
 *             if (this._client != null) {
 *                 this._client.close();
 *                 this._client = null;
 *             }
 *             callback(null);
 *         }
 *        
 *         ...
 *     }
 */
abstract class IOpenable extends IClosable {
	/**
	 * Checks if the component is opened.
	 * 
	 * @returns true if the component has been opened and false otherwise.
	 */
	bool isOpen();

	/**
	 * Opens the component.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
     * @param callback 			callback function that receives error or null no errors occured.
	 */
	void open(String correlationId, [callback (dynamic err)]);
}
