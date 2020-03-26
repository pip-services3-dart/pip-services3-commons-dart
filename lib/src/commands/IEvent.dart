/** @module commands */
import './ICommand.dart';
import './IEventListener.dart';
import '../run/INotifiable.dart';

/**
 * An interface for Events, which are part of the Command design pattern.
 * Events allows to send asynchronious notifications to multiple subscribed listeners.
 * 
 * @see [[IEventListener]]
 */
abstract class IEvent extends INotifiable {
  /**
     * Gets the event name.
     * 
	 * @returns the name of the event.
	 */
  String getName();

  /**
     * Gets all subscribed listeners.
     * 
     * @returns a list of listeners.
     */
  List<IEventListener> getListeners();

  /**
     * Adds a listener to receive notifications for this event.
     * 
     * @param listener      the listener reference to add.
     */
  void addListener(IEventListener listener);

  /**
     * Removes a listener, so that it no longer receives notifications for this event.
     * 
     * @param listener      the listener reference to remove.
     */
  void removeListener(IEventListener listener);
}
