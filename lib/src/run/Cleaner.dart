// /** @module run */
// /** @hidden */ 
// let _ = require('lodash');
// /** @hidden */ 
// let async = require('async');

// /**
//  * Helper class that cleans stored object state.
//  * 
//  * @see [[ICleanable]]
//  */
// export class Cleaner {
// 	/**
// 	 * Clears state of specific component.
// 	 * 
// 	 * To be cleaned state components must implement [[ICleanable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param component 		the component that is to be cleaned.
//      * @param callback 			callback function that returns error or null no errors occured.
// 	 * 
// 	 * @see [[ICleanable]]
// 	 */
// 	public static clearOne(correlationId: string, component: any, callback?: (err: any) => void): void {
//         if (_.isFunction(component.clear)) {
// 			try {
// 				component.clear(correlationId);
// 			} catch (err) {
// 				if (callback) callback(err);
// 				else throw err;
// 			}
// 		} else if (callback)
// 			callback(null);
// 	}

// 	/**
// 	 * Clears state of multiple components.
// 	 * 
// 	 * To be cleaned state components must implement [[ICleanable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param components 		the list of components that are to be cleaned.
//      * @param callback 			callback function that returns error or null no errors occured.
// 	 * 
// 	 * @see [[clearOne]]
// 	 * @see [[ICleanable]]
// 	 */
// 	public static clear(correlationId: string, components: any[], callback?: (err: any) => void) {		
//         async.eachSeries(
//             components, 
//             (component, callback) => {
// 				Cleaner.clearOne(correlationId, component, callback);
//             },
//             (err) => {
// 				if (callback) callback(err);
// 				else if (err) throw err;
// 			}
//         );            
// 	}
// }
