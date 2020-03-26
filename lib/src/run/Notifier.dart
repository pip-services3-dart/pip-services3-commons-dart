import './Parameters.dart';
import './INotifiable.dart';

/**
 * Helper class that notifies components.
 * 
 * [[INotifiable]]
 */
class Notifier {
	/**
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
	static void notifyOne(String correlationId, component, Parameters args) {
    if (component is INotifiable)
			component.notify(correlationId, args);
	}

	/**
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
  static void notify(String correlationId, List components, Parameters args) {
		if (components == null) return;
		
		for (var component in components) 
      Notifier.notifyOne(correlationId, component, args);
	}
}
