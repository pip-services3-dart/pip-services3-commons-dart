import 'dart:async';

import './IClosable.dart';

/**
 * Interface for components that require explicit opening and closing.
 * 
 * For components that perform opening on demand consider using
 * [[ICloseable]] interface instead.
 * 
 * See [[IOpenable]]
 * See [[Opener]]
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
	 * Returns true if the component has been opened and false otherwise.
	 */
  bool isOpen();

  /**
	 * Opens the component.
	 * 
	 * - correlationId 	(optional) transaction id to trace execution through call chain.
   * - callback 			callback function that receives error or null no errors occured.
	 */
  Future open(String correlationId);
}
