import 'dart:async';

import './Parameters.dart';


/// Interface for components that can be called to execute work.
/// 
/// See [Executor]
/// See [INotifiable]
/// See [Parameters]
/// 
/// ### Example ###
/// 
///     class EchoComponent implements IExecutable {
///         ...
///         Future<dynamic> execute(String correlationId, Parameters args)  {
///            return Future.delayed(Duration(), (){
///                return args.getAsObject('message');
///            })         
///         }
///     }
///     
///     var echo = new EchoComponent();
///     var message = 'Test';
///     echo.execute('123', Parameters.fromTuples(['message', message])
///        .then((result) {
///             console.log('Request: ' + message + ' Response: ' + result);
///         })
///     );
 
abstract class IExecutable {
  
	/// Executes component with arguments and receives execution result.
	/// 
	/// - [correlationId] 	(optional) transaction id to trace execution through call chain.
	/// - [args] 				execution arguments.
  /// Return 			  Future that receives execution result or error.
	 
  Future<dynamic> execute(String correlationId, Parameters args);
}
