import './Parameters.dart';

/// Interface for components that can be asynchronously notified.
/// The notification may include optional argument that describe
/// the occured event.
///
/// See [Notifier]
/// See [IExecutable]
///
/// ### Example ###
///
///     class MyComponent implements INotifable {
///         ...
///         void notify(String correlationId, Parameters args) {
///             console.log('Occured event ' + args.getAsString('event'));
///         }
///     }
///
///     var myComponent =  MyComponent();
///
///     myComponent.notify('123', Parameters.fromTuples('event', 'Test Event'));

abstract class INotifiable {
  /// Notifies the component about occured event.
  ///
  /// - correlationId 	(optional) transaction id to trace execution through call chain.
  /// - args 				notification arguments.

  void notify(String correlationId, Parameters args);
}
