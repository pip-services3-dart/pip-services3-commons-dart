// /** @module run */
// /** @hidden */ 
// let _ = require('lodash');
// /** @hidden */ 
// let async = require('async');

// /**
//  * Helper class that closes previously opened components.
//  * 
//  * [[ICloseable]]
//  */
// export class Closer {
// 	/**
// 	 * Closes specific component.
// 	 * 
// 	 * To be closed components must implement [[ICloseable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param component 		the component that is to be closed.
//      * @param callback 			callback function that receives error or null no errors occured.
// 	 * 
// 	 * @see [[IClosable]]
// 	 */
// 	public static closeOne(correlationId: string, component: any, callback?: (err: any) => void): void {
//         if (_.isFunction(component.close)) {
// 			try {
// 				component.close(correlationId, callback);
// 			} catch (err) {
// 				if (callback) callback(err);
// 				else throw err;
// 			}
// 		} else if (callback) 
// 			callback(null);
// 	}

// 	/**
// 	 * Closes multiple components.
// 	 * 
// 	 * To be closed components must implement [[ICloseable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param components 		the list of components that are to be closed.
//      * @param callback 			callback function that receives error or null no errors occured.
// 	 * 
// 	 * @see [[closeOne]]
// 	 * @see [[IClosable]]
// 	 */
// 	public static close(correlationId: string, components: any[], callback?: (err: any) => void): void {
//         async.eachSeries(
//             components,
//             (component, callback) => {
// 				Closer.closeOne(correlationId, component, callback);
//             }, 
//             (err) => {
// 				if (callback) callback(err);
// 				else if (err) throw err;
// 			}
//         );
// 	}
// }
