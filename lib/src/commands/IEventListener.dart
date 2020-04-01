import '../run/Parameters.dart';
import './IEvent.dart';

/// An interface for listener objects that receive notifications on fired events.
///
/// See [IEvent]
/// See [Event]
///
/// ### Example ###
///
///     class MyListener implements IEventListener {
///          void _onEvent(String correlationId, IEvent event, Parameters args ) {
///             print('Fired event ' + event.getName());
///         }
///     }
///
///     var event =  Event('myevent');
///     event.addListener( MyListener());
///     event.notify('123', Parameters.fromTuples(['param1', 'ABC']));
///
///     // Console output: Fired event myevent

abstract class IEventListener {
  /// A method called when events this listener is subscrubed to are fired.
  ///
  /// - [event] 			a fired evemt
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// - [args] 			    event arguments.

  void onEvent(String correlationId, IEvent event, Parameters args);
}
