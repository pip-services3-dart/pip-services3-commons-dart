import 'dart:async';

import '../run/Parameters.dart';
import '../validate/ValidationResult.dart';

import './ICommand.dart';

/**
 * An interface for stackable command intercepters, which can extend
 * and modify the command call chain.
 * 
 * This mechanism can be used for authentication, logging, and other functions.
 * 
 * @see [[ICommand]]
 * @see [[InterceptedCommand]]
 */
abstract class ICommandInterceptor {
  /**
     * Gets the name of the wrapped command.
     * 
     * The interceptor can use this method to override the command name.
     * Otherwise it shall just delegate the call to the wrapped command.
     * 
     * @param command   the next command in the call chain.
     * @returns the name of the wrapped command.
     */
  String getName(ICommand command);

  /**
     * Executes the wrapped command with specified arguments.
     * 
     * The interceptor can use this method to intercept and alter the command execution.
     * Otherwise it shall just delete the call to the wrapped command.
     * 
     * @param correlationId (optional) transaction id to trace execution through call chain.
     * @param command       the next command in the call chain that is to be executed.
     * @param args          the parameters (arguments) to pass to the command for execution.
     * @param callback      the function that is to be called once execution is complete. If an exception is raised, then
     *                      it will be called with the error.
     * 
     * @see [[Parameters]]
     */
  Future<dynamic> execute(
      String correlationId, ICommand command, Parameters args);

  /**
     * Validates arguments of the wrapped command before its execution.
     * 
     * The interceptor can use this method to intercept and alter validation of the command arguments.
     * Otherwise it shall just delegate the call to the wrapped command.
     * 
     * @param command   the next command in the call chain to be validated against.
     * @param args      the parameters (arguments) to validate.
     * @returns         an array of ValidationResults.
     * 
     * @see [[Parameters]]
     * @see [[ValidationResult]]
     */
  List<ValidationResult> validate(ICommand command, Parameters args);
}
