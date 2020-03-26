/** @module run */
import './Parameters.dart';

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
  /**
	 * Notifies the component about occured event.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param args 				notification arguments.
	 */
  void notify(String correlationId, Parameters args);
}
