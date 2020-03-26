/** @module commands */
import './IEvent.dart';
import '../run/Parameters.dart';

/**
 * An interface for listener objects that receive notifications on fired events.
 * 
 * @see [[IEvent]]
 * @see [[Event]]
 * 
 * ### Example ###
 * 
 *     export class MyListener implements IEventListener {
 *         private onEvent(correlationId: string, event: IEvent, args: Parameters): void {
 *             console.log("Fired event " + event.getName());
 *         }
 *     }
 *     
 *     let event = new Event("myevent");
 *     event.addListener(new MyListener());
 *     event.notify("123", Parameters.fromTuples("param1", "ABC"));
 *     
 *     // Console output: Fired event myevent
 */
abstract class IEventListener {
  /**
	 * A method called when events this listener is subscrubed to are fired.
	 * 
	 * @param event 			a fired evemt
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param args 			    event arguments.
	 */
  void onEvent(String correlationId, IEvent event, Parameters args);
}
