import './Parameters.dart';

/**
 * Helper class that executes components.
 * 
 * [[IExecutable]]
 */
class Executor {
  /**
	 * Executes specific component.
	 * 
	 * To be executed components must implement [[IExecutable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param component 		the component that is to be executed.
     * @param args              execution arguments.
     * @param callback 			callback function that receives execution result or error.
	 * 
	 * @see [[IExecutable]]
     * @see [[Parameters]]
	 */
  static executeOne(String correlationId, dynamic component, Parameters args,
      callback(dynamic err, dynamic result)) {
    if (component.execute is Function) {
      try {
        return component.execute(correlationId, args, callback);
      } catch (err) {
        callback(err, null);
      }
    } else
      callback(null, null);
  }

  /**
	 * Executes multiple components.
	 * 
	 * To be executed components must implement [[IExecutable]] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * @param correlationId 	(optional) transaction id to trace execution through call chain.
	 * @param components 		a list of components that are to be executed.
     * @param args              execution arguments.
     * @param callback 			callback function that receives execution result or error.
	 * 
	 * @see [[executeOne]]
	 * @see [[IExecutable]]
     * @see [[Parameters]]
	 */
  static execute(String correlationId, List<dynamic> components,
      Parameters args, callback(dynamic err, dynamic results)) async {
    var results = new List<dynamic>();

    await Future.forEach(components, (component) {
      return Future<dynamic>(() {
        var err;
        Executor.executeOne(correlationId, component, args, (e, result) {
          results.add(result);
          err = e;
        });
        return err;
      });
    }).then((err) {
      callback(err, results);
    });
  }
}
