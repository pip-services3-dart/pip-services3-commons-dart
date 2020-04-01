import '../errors/InvocationException.dart';
import '../run/Parameters.dart';

import './IEvent.dart';
import './IEventListener.dart';


/// Concrete implementation of [IEvent IEvent] interface.
/// It allows to send asynchronous notifications to multiple subscribed listeners.
/// 
/// See [IEvent]
/// See [IEventListener]
/// 
/// ### Example ###
/// 
///     var event =  Event('my_event');
///      
///     event.addListener(myListener);
///     
///     event.notify('123', Parameters.fromTuples(
///       ['param1', 'ABC',
///       'param2', 123]
///     ));
 
class Event implements IEvent {
  String _name;
  List<IEventListener> _listeners;

  
    /// Creates a new event and assigns its name.
    /// 
    /// - name  the name of the event that is to be created.
    /// @throws an Error if the name is null.
     
  Event(String name) {
    if (name == null) throw ('Name cannot be null');

    this._name = name;
  }

  
    /// Gets the name of the event.
    /// 
    /// Returns the name of this event.
     
  String getName() {
    return this._name;
  }

  
    /// Gets all listeners registred in this event.
    /// 
    /// Returns a list of listeners.
     
  List<IEventListener> getListeners() {
    return this._listeners;
  }

  
    /// Adds a listener to receive notifications when this event is fired.
    /// 
    /// - [listener] the listener reference to add.
     
  void addListener(IEventListener listener) {
    this._listeners.add(listener);
  }

  
    /// Removes a listener, so that it no longer receives notifications for this event.
    /// 
    /// - [listener]      the listener reference to remove.
     
  void removeListener(IEventListener listener) {
    var index = this._listeners.indexOf(listener);

    if (index > -1) this._listeners.removeAt(index);
  }

  
    /// Fires this event and notifies all registred listeners.
    /// 
    /// - [correlationId]     (optional) transaction id to trace execution through call chain.
    /// - [args]              the parameters to raise this event with.
    /// throws an [InvocationException] if the event fails to be raised.  
     
  void notify(String correlationId, Parameters args) {
    for (var i = 0; i < this._listeners.length; i++) {
      try {
        var listener = this._listeners[i];
        listener.onEvent(correlationId, this, args);
      } catch (ex) {
        throw  InvocationException(correlationId, 'EXEC_FAILED',
                'Raising event ' + this.getName() + ' failed: ' + ex)
            .withDetails('event', this.getName())
            .wrap(ex);
      }
    }
  }
}
