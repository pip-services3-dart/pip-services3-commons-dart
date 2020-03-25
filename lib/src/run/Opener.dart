// /** @module run */
// /** @hidden */ 
// let _ = require('lodash');
// /** @hidden */ 
// let async = require('async');

// /**
//  * Helper class that opens components.
//  * 
//  * [[IOpenable]]
//  */
// export class Opener {
// 	/**
// 	 * Checks if specified component is opened.
// 	 * 
// 	 * To be checked components must implement [[IOpenable]] interface.
// 	 * If they don't the call to this method returns true.
// 	 * 
// 	 * @param component 	the component that is to be checked.
// 	 * @returns true if component is opened and false otherwise.
// 	 * 
// 	 * @see [[IOpenable]]
// 	 */
// 	public static isOpenOne(component: any): boolean {
// 		if (_.isFunction(component.isOpen))
// 			return component.isOpen();
// 		else
// 			return true;
// 	}	

// 	/**
// 	 * Checks if all components are opened.
// 	 * 
// 	 * To be checked components must implement [[IOpenable]] interface.
// 	 * If they don't the call to this method returns true.
// 	 * 
// 	 * @param components 	a list of components that are to be checked.
// 	 * @returns true if all components are opened and false if at least one component is closed.
// 	 * 
// 	 * @see [[isOpenOne]]
// 	 * @see [[IOpenable]]
// 	 */
// 	public static isOpen(components: any[]): boolean {
// 		if (components == null) return true;
		
// 		let result: boolean = true;
// 		for (let index = 0; index < components.length; index++)
// 			result = result && Opener.isOpenOne(components[index]);
		
// 		return result;
// 	}

// 	/**
// 	 * Opens specific component.
// 	 * 
// 	 * To be opened components must implement [[IOpenable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param component 		the component that is to be opened.
//      * @param callback 			callback function that returns error or null no errors occured.
// 	 * 
// 	 * @see [[IOpenable]]
// 	 */
// 	public static openOne(correlationId: string, component: any, callback?: (err: any) => void): void {
//         if (_.isFunction(component.open)) {
// 			try {
// 				component.open(correlationId, callback);
// 			} catch (err) {
// 				if (callback) callback(err);
// 				else if (err) throw err;
// 			}
// 		} else if (callback)
// 			callback(null);
// 	}	

// 	/**
// 	 * Opens multiple components.
// 	 * 
// 	 * To be opened components must implement [[IOpenable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param components 		the list of components that are to be closed.
//      * @param callback 			callback function that returns error or null no errors occured.
// 	 * 
// 	 * @see [[openOne]]
// 	 * @see [[IOpenable]]
// 	 */
// 	public static open(correlationId: string, components: any[], callback?: (err: any) => void): void {
//         async.eachSeries(
//             components,
//             (component, callback) => {
//                 Opener.openOne(correlationId, component, callback);
//             }, 
//             (err) => {
// 				if (callback) callback(err);
// 				else if (err) throw err;
// 			}
//         );
// 	}

// }
