// /** @module run */
// /** @hidden */ 
// let _ = require('lodash');

// import { Parameters } from './Parameters';

// /**
//  * Helper class that notifies components.
//  * 
//  * [[INotifiable]]
//  */
// export class Notifier {
// 	/**
// 	 * Notifies specific component.
// 	 * 
// 	 * To be notiied components must implement [[INotifiable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param component 		the component that is to be notified.
//      * @param args              notifiation arguments.
// 	 * 
// 	 * @see [[INotifiable]]
// 	 */
// 	public static notifyOne(correlationId: string, component: any, args: Parameters): void {
//         if (_.isFunction(component.notify))
// 			component.notify(correlationId, args);
// 	}

// 	/**
// 	 * Notifies multiple components.
// 	 * 
// 	 * To be notified components must implement [[INotifiable]] interface.
// 	 * If they don't the call to this method has no effect.
// 	 * 
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param components 		a list of components that are to be notified.
//      * @param args              notification arguments.
// 	 * 
// 	 * @see [[notifyOne]]
// 	 * @see [[INotifiable]]
// 	 */
//     public static notify(correlationId: string, components: any[], args: Parameters): void {
// 		if (components == null) return;
		
// 		for (let index = 0; index < components.length; index++) 
//             Notifier.notifyOne(correlationId, components[index], args);
// 	}
// }
