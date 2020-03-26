<<<<<<< HEAD
import 'dart:async';

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
abstract class IOpenable implements IClosable {
	/**
	 * Checks if the component is opened.
	 * 
	 * @returns true if the component has been opened and false otherwise.
	 */
	bool isOpen();

=======
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

>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
	/**
	 * Opens the component.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
<<<<<<< HEAD
   * @param callback 			callback function that receives error or null no errors occured.
	 */
	Future open(String correlationId);
=======
     * @param callback 			callback function that receives error or null no errors occured.
	 */
	void open(String correlationId, [callback (dynamic err)]);
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
}
