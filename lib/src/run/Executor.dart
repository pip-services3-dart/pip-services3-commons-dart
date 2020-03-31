import 'dart:async';

import './Parameters.dart';
import './IExecutable.dart';

/**
 * Helper class that executes components.
 * 
 * [IExecutable]
 */
class Executor {
  /**
	 * Executes specific component.
	 * 
	 * To be executed components must implement [IExecutable] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * - [correlationId] 	(optional) transaction id to trace execution through call chain.
	 * - [component] 		the component that is to be executed.
   * - [args]              execution arguments.
   * Return			    Future that receives execution result or error.
	 * 
	 * See [IExecutable]
   * See [Parameters]
	 */
  static Future<dynamic> executeOne(
      String correlationId, component, Parameters args) async {
    if (component is IExecutable)
      return await component.execute(correlationId, args);
  }

  /**
	 * Executes multiple components.
	 * 
	 * To be executed components must implement [IExecutable] interface.
	 * If they don't the call to this method has no effect.
	 * 
	 * - [correlationId] 	(optional) transaction id to trace execution through call chain.
	 * - [components] 		a list of components that are to be executed.
   * - [args]              execution arguments.
   * Return 			  Future that receives execution result or error.
	 * 
	 * See [executeOne]
	 * See [IExecutable]
   * See [Parameters]
	 */
  static Future<List> execute(
      String correlationId, List components, Parameters args) async {
    var results = new List();

    if (components == null) return results;

    for (var component in components) {
      var result = await executeOne(correlationId, component, args);
      results.add(result);
    }

    return results;
  }
}
