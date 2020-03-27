import 'dart:async';

/**
 * Interface for components that require explicit closure.
 * 
 * For components that require opening as well as closing 
 * use [[IOpenable]] interface instead.
 * 
 * See [[IOpenable]]
 * See [[Closer]]
 * 
 * ### Example ###
 * 
 *     class MyConnector implements ICloseable {
 *         private _client: any = null;
 *         
 *         ... // The _client can be lazy created
 *         
 *         public close(correlationId: string, callback: (err: any) => void): void {
 *             if (this._client != null) {
 *                 this._client.close();
 *                 this._client = null;
 *             }
 *             callback(null);
 *         }
 *     }
 * 
 */
abstract class IClosable {
  /**
	 * Closes component and frees used resources.
	 * 
	 * - correlationId 	(optional) transaction id to trace execution through call chain.
     * - callback 			callback function that receives error or null no errors occured.
	 */
  Future close(String correlationId);
}
