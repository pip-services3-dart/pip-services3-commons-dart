import './Parameters.dart';
<<<<<<< HEAD
import './INotifiable.dart';
=======
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb

/**
 * Helper class that notifies components.
 * 
 * [[INotifiable]]
 */
class Notifier {
<<<<<<< HEAD
	/**
=======
  /**
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
	 * Notifies specific component.
	 * 
	 * To be notiied components must implement [[INotifiable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param component 		the component that is to be notified.
     * @param args              notifiation arguments.
	 * 
	 * @see [[INotifiable]]
	 */
<<<<<<< HEAD
	static void notifyOne(String correlationId, component, Parameters args) {
    if (component is INotifiable)
			component.notify(correlationId, args);
	}

	/**
=======
  static void notifyOne(
      String correlationId, dynamic component, Parameters args) {
    if (component.notify is Function) component.notify(correlationId, args);
  }

  /**
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
	 * Notifies multiple components.
	 * 
	 * To be notified components must implement [[INotifiable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param components 		a list of components that are to be notified.
     * @param args              notification arguments.
	 * 
	 * @see [[notifyOne]]
	 * @see [[INotifiable]]
	 */
<<<<<<< HEAD
  static void notify(String correlationId, List components, Parameters args) {
		if (components == null) return;
		
		for (var component in components) 
      Notifier.notifyOne(correlationId, component, args);
	}
=======
  static void notify(
      String correlationId, List<dynamic> components, Parameters args) {
    if (components == null) return;

    for (var index = 0; index < components.length; index++)
      Notifier.notifyOne(correlationId, components[index], args);
  }
>>>>>>> 6bfeb7c92f5e99eeea08c8f0dc4514882833fedb
}
