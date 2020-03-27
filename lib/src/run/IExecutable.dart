import 'dart:async';

import './Parameters.dart';

/**
 * Interface for components that can be called to execute work.
 * 
 * See [[Executor]]
 * See [[INotifiable]]
 * See [[Parameters]]
 * 
 * ### Example ###
 * 
 *     class EchoComponent implements IExecutable {
 *         ...
 *         public execute(correlationId: string, args: Parameters, callback: (err: any, result: any) => void): void {
 *             let result = args.getAsObject("message");
 *             callback(null, result);
 *         }
 *     }
 *     
 *     let echo = new EchoComponent();
 *     let message = "Test";
 *     echo.execute("123", Parameters.fromTuples("message", message),
 *         (err, result) => {
 *             console.log("Request: " + message + " Response: " + result);
 *         }
 *     );
 */
abstract class IExecutable {
  /**
	 * Executes component with arguments and receives execution result.
	 * 
	 * - correlationId 	(optional) transaction id to trace execution through call chain.
	 * - args 				execution arguments.
     * - callback 			callback function that receives execution result or error.
	 */
  Future<dynamic> execute(String correlationId, Parameters args);
}
