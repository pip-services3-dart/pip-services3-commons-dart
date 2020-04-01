import '../run/INotifiable.dart';
import './IEventListener.dart';


/// An interface for Events, which are part of the Command design pattern.
/// Events allows to send asynchronious notifications to multiple subscribed listeners.
/// 
/// See [IEventListener]
 
abstract class IEvent extends INotifiable {
  
    /// Gets the event name.
    /// 
	/// Returns the name of the event.
	 
  String getName();

  
    /// Gets all subscribed listeners.
    /// 
    /// Returns a list of listeners.
     
  List<IEventListener> getListeners();

  
    /// Adds a listener to receive notifications for this event.
    /// 
    /// - [listener]      the listener reference to add.
     
  void addListener(IEventListener listener);

  
    /// Removes a listener, so that it no longer receives notifications for this event.
    /// 
    /// - [listener]      the listener reference to remove.
     
  void removeListener(IEventListener listener);
}
