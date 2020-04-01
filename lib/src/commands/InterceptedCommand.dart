import 'dart:async';

import '../run/Parameters.dart';
import '../validate/ValidationResult.dart';
import './ICommand.dart';
import './ICommandInterceptor.dart';


/// Implements a [ICommand command] wrapped by an interceptor.
/// It allows to build command call chains. The interceptor can alter execution
/// and delegate calls to a next command, which can be intercepted or concrete.

/// See [ICommand]
/// See [ICommandInterceptor]

/// ### Example ###

///     class CommandLogger implements ICommandInterceptor {

///         String getName(ICommand command) {
///             return command.getName();
///         }

///         void execute(String correlationId, ICommand command , Parameters args,) async {
///             print("Executed command " + command.getName());
///             return await command.execute(correlationId, args);
///         }

///         List<ValidationResult> validate(ICommand command, Parameters args) {
///             return command.validate(args);
///         }
///     }

///     var logger = new CommandLogger();
///     var loggedCommand = new InterceptedCommand(logger, command);

///     // Each called command will output: Executed command <command name>

 
class InterceptedCommand implements ICommand {
  ICommandInterceptor _interceptor;
  ICommand _next;

  
    /// Creates a new InterceptedCommand, which serves as a link in an execution chain. Contains information
    /// about the interceptor that is being used and the next command in the chain.
    
    /// - interceptor   the interceptor that is intercepting the command.
    /// - next          (link to) the next command in the command's execution chain.
     
  InterceptedCommand(ICommandInterceptor interceptor, ICommand next) {
    this._interceptor = interceptor;
    this._next = next;
  }

  
    /// Returns the name of the command that is being intercepted.
     
  String getName() {
    return this._interceptor.getName(this._next);
  }

  
    /// Executes the next command in the execution chain using the given [Parameters parameters] (arguments).
    
    /// - correlationId unique transaction id to trace calls across components.
    /// - args          the parameters (arguments) to pass to the command for execution.
    /// - callback      the function that is to be called once execution is complete. If an exception is raised, then
    ///                      it will be called with the error.
    
    /// See [Parameters]
     
  Future<dynamic> execute(String correlationId, Parameters args) async {
    return await this._interceptor.execute(correlationId, this._next, args);
  }

  
    /// Validates the [Parameters parameters] (arguments) that are to be passed to the command that is next
    /// in the execution chain.
    
    /// - args      the parameters (arguments) to validate for the next command.
    /// Returns         an array of ValidationResults.
    
    /// See [Parameters]
    /// See [ValidationResult]
     
  List<ValidationResult> validate(Parameters args) {
    return this._interceptor.validate(this._next, args);
  }
}
