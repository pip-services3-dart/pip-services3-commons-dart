// /** @module run */
// /** @hidden */ 
// let _ = require('lodash');
// /** @hidden */ 
// let async = require('async');

// import { Parameters } from './Parameters';

// /**
//  * Helper class that executes components.
//  * 
//  * [[IExecutable]]
//  */
// export class Executor {
//     /**
// 	 * Executes specific component.
// 	 * 
// 	 * To be executed components must implement [[IExecutable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param component 		the component that is to be executed.
//      * @param args              execution arguments.
//      * @param callback 			callback function that receives execution result or error.
// 	 * 
// 	 * @see [[IExecutable]]
//      * @see [[Parameters]]
// 	 */
// 	public static executeOne(
// 		correlationId: string, component: any, args: Parameters, callback: (err: any, result: any) => void) {

//         if (_.isFunction(component.execute)) {
//             try {
// 			    return component.execute(correlationId, args, callback);
// 			} catch (err) {
//                 callback(err, null);
// 			}
//         } else callback(null, null);
// 	}

//     /**
// 	 * Executes multiple components.
// 	 * 
// 	 * To be executed components must implement [[IExecutable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param components 		a list of components that are to be executed.
//      * @param args              execution arguments.
//      * @param callback 			callback function that receives execution result or error.
// 	 * 
// 	 * @see [[executeOne]]
// 	 * @see [[IExecutable]]
//      * @see [[Parameters]]
// 	 */
//     public static execute(correlationId: string, components: any[], args: Parameters, callback: (err: any, results: any[]) => void) {
//         let results: any[] = [];				

//         async.eachSeries(
//             components,
//             (component, callback) => {
//                 Executor.executeOne(
//                     correlationId, component, args,
//                     (err, result) => {
//                         results.push(result);
//                         callback(err);
//                     }
//                 );
//             }, 
//             (err) => {
//                 callback(err, results);
//             }
//         );
// 	}
// }