// /** @module commands */
// import { ICommand } from './ICommand';
// import { IEventListener } from './IEventListener';
// import { INotifiable } from '../run/INotifiable';

// /**
//  * An interface for Events, which are part of the Command design pattern.
//  * Events allows to send asynchronious notifications to multiple subscribed listeners.
//  * 
//  * @see [[IEventListener]]
//  */
// export interface IEvent extends INotifiable {
// 	/**
//      * Gets the event name.
//      * 
// 	 * @returns the name of the event.
// 	 */
//     getName(): string;

//     /**
//      * Gets all subscribed listeners.
//      * 
//      * @returns a list of listeners.
//      */
//     getListeners(): IEventListener[];

//     /**
//      * Adds a listener to receive notifications for this event.
//      * 
//      * @param listener      the listener reference to add.
//      */
//     addListener(listener: IEventListener): void;

//     /**
//      * Removes a listener, so that it no longer receives notifications for this event.
//      * 
//      * @param listener      the listener reference to remove.
//      */
//     removeListener(listener: IEventListener): void;
// }
