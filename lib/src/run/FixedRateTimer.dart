// /** @module run */
// /** @hidden */ 
// let _ = require('lodash');

// import { IClosable } from './IClosable';
// import { INotifiable } from './INotifiable';
// import { Parameters } from './Parameters';

// /**
//  * Timer that is triggered in equal time intervals.
//  * 
//  * It has summetric cross-language implementation 
//  * and is often used by Pip.Services toolkit to
//  * perform periodic processing and cleanup in microservices.
//  * 
//  * @see [[INotifiable]]
//  * 
//  * ### Example ###
//  * 
//  *     class MyComponent {
//  *         private timer: FixedRateTimer = new FixedRateTimer(() => { this.cleanup }, 60000);
//  *         ...
//  *         public open(correlationId: string, callback: (err: any) => void): void {
//  *             ...
//  *             timer.start();
//  *             ...
//  *         }
//  *         
//  *         public open(correlationId: string, callback: (err: any) => void): void {
//  *             ...
//  *             timer.stop();
//  *             ...
//  *         }
//  *         
//  *         private cleanup(): void {
//  *             ...
//  *         }
//  *         ...
//  *     }
//  */
// export class FixedRateTimer implements IClosable {
//     private _task: INotifiable;
//     private _callback: () => void;
// 	private _delay: number;
// 	private _interval: number;
// 	private _timer: any;
//     private _timeout: any;
    
//     /**
//      * Creates new instance of the timer and sets its values.
//      * 
//      * @param taskOrCallback    (optional) a Notifiable object or callback function to call when timer is triggered.
//      * @param interval          (optional) an interval to trigger timer in milliseconds.
//      * @param delay             (optional) a delay before the first triggering in milliseconds.
//      * 
//      * @see [[setTask]]
//      * @see [[setCallback]]
//      * @see [[setInterval]] 
//      * @see [[setDelay]]
//      */
// 	public constructor(taskOrCallback: any = null, interval: number = null, delay: number = null) {
//         if (_.isObject(taskOrCallback) && _.isFunction(taskOrCallback.notify))
//             this.setTask(taskOrCallback);
//         else 
// 		    this.setCallback(taskOrCallback);

//         this.setInterval(interval);
// 		this.setDelay(delay);
// 	}

//     /** 
//      * Gets the INotifiable object that receives notifications from this timer.
//      * 
//      * @returns the INotifiable object or null if it is not set.
//      */
//     public getTask(): INotifiable {return this._task; }

//     /**
//      * Sets a new INotifiable object to receive notifications from this timer.
//      * 
//      * @param value a INotifiable object to be triggered.
//      */
// 	public setTask(value: INotifiable): void {
//         this._task = value;
//         this._callback = () => { 
//             this._task.notify("pip-commons-timer", new Parameters()); 
//         }
//     }

//     /** 
//      * Gets the callback function that is called when this timer is triggered.
//      * 
//      * @returns the callback function or null if it is not set. 
//      */
//     public getCallback(): () => void { return this._callback; }

//     /** 
//      * Sets the callback function that is called when this timer is triggered.
//      * 
//      * @param value the callback function to be called.
//      */
//     public setCallback(value: () => void) {
//         this._callback = value;
//         this._task = null;
//     }

//     /**
//      * Gets initial delay before the timer is triggered for the first time.
//      * 
//      * @returns the delay in milliseconds.
//      */
//     public getDelay(): number { return this._delay; }

//     /** 
//      * Sets initial delay before the timer is triggered for the first time.
//      * 
//      * @param value a delay in milliseconds. 
//      */
// 	public setDelay(value: number): void { this._delay = value; }
    
//     /**
//      * Gets periodic timer triggering interval.
//      * 
//      * @returns the interval in milliseconds
//      */
//     public getInterval(): number { return this._interval; }
    
    
//     /** 
//      * Sets periodic timer triggering interval.
//      * 
//      * @param value an interval in milliseconds.
//      */
// 	public setInterval(value: number): void { this._interval = value; }
    
//     /** 
//      * Checks if the timer is started.
//      * 
//      * @returns true if the timer is started and false if it is stopped.
//      */
// 	public isStarted(): boolean { return this._timer != null; }
    
//     /**
//      * Starts the timer.
//      * 
//      * Initially the timer is triggered after delay.
//      * After that it is triggered after interval until it is stopped.
//      * 
//      * @see [[stop]]
//      */
// 	public start(): void {
//         // Stop previously set timer
//         this.stop();
        
//         // Exit if interval is not defined
//         if (this._interval == null || this._interval <= 0) return;

//         // Introducing delay
//         let delay = Math.max(0, this._delay - this._interval);

//         this._timeout = setTimeout(() => {
//             this._timeout = null;

//             // Set a new timer
//             this._timer = setInterval(() => {
//                 try {
//                     if (this._callback) this._callback();
//                 } catch (ex) {
//                     // Ignore or better log!
//                 }
//             }, this._interval);
//         }, delay);
// 	}
    
//     /**
//      * Stops the timer.
//      * 
//      * @see [[start]]
//      */
// 	public stop(): void {
//         if (this._timeout != null) {
//             clearTimeout(this._timeout);
//             this._timeout = null;
//         }

//         if (this._timer != null) {
//             clearInterval(this._timer);
//             this._timer = null;
//         }
// 	}
    
//     /**
//      * Closes the timer.
//      * 
//      * This is required by [[ICloseable]] interface,
//      * but besides that it is identical to stop().
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param callback 			callback function that receives error or null no errors occured.
//      * 
//      * @see [[stop]]
//      */
// 	public close(correlationId: string, callback?: (err: any) => void): void {
// 		this.stop();

//         if (callback != null)
//             callback(null);
// 	}
// }
