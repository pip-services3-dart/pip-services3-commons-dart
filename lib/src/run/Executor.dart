import 'dart:async';

import './Parameters.dart';
import './IExecutable.dart';

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
	static Future<dynamic> executeOne(String correlationId, component, Parameters args) async {
    if (component is IExecutable)
      return await component.execute(correlationId, args);
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
  static Future<List> execute(String correlationId, List components, Parameters args) async {
    var results = new List();				

		if (components == null) return results;

    for (var component in components) {
      var result = await executeOne(correlationId, component, args);
      results.add(result);
    }

    return results;
	}
}