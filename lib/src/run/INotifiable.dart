<<<<<<< HEAD
import 'dart:async';

import './Parameters.dart';

=======
/** @module run */
import './Parameters.dart';

>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
/**
 * Interface for components that can be asynchronously notified.
 * The notification may include optional argument that describe
 * the occured event.
 * 
 * @see [[Notifier]]
 * @see [[IExecutable]]
 * 
 * ### Example ###
 * 
 *     class MyComponent implements INotifable {
 *         ...
 *         public notify(correlationId: string, args: Parameters): void {
 *             console.log("Occured event " + args.getAsString("event"));
 *         }
 *     }
 *     
 *     let myComponent = new MyComponent();
 *     
 *     myComponent.notify("123", Parameters.fromTuples("event", "Test Event"));
 */
abstract class INotifiable {
<<<<<<< HEAD
	/**
=======
  /**
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
	 * Notifies the component about occured event.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param args 				notification arguments.
	 */
<<<<<<< HEAD
	void notify(String correlationId, Parameters args);
=======
  void notify(String correlationId, Parameters args);
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
}
