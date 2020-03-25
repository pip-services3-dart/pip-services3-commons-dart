// /** @module commands */
// import { IEvent } from './IEvent';
// import { Parameters } from '../run/Parameters';

// /**
//  * An interface for listener objects that receive notifications on fired events.
//  * 
//  * @see [[IEvent]]
//  * @see [[Event]]
//  * 
//  * ### Example ###
//  * 
//  *     export class MyListener implements IEventListener {
//  *         private onEvent(correlationId: string, event: IEvent, args: Parameters): void {
//  *             console.log("Fired event " + event.getName());
//  *         }
//  *     }
//  *     
//  *     let event = new Event("myevent");
//  *     event.addListener(new MyListener());
//  *     event.notify("123", Parameters.fromTuples("param1", "ABC"));
//  *     
//  *     // Console output: Fired event myevent
//  */
// export interface IEventListener {
// 	/**
// 	 * A method called when events this listener is subscrubed to are fired.
// 	 * 
// 	 * @param event 			a fired evemt
// 	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
// 	 * @param args 			    event arguments.
// 	 */
//     onEvent(correlationId: string, event: IEvent, args: Parameters): void;
// }
