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
 * See [ICommand]
 * See [InterceptedCommand]
 */
abstract class ICommandInterceptor {
  /**
     * Gets the name of the wrapped command.
     * 
     * The interceptor can use this method to override the command name.
     * Otherwise it shall just delegate the call to the wrapped command.
     * 
     * - [command]   the next command in the call chain.
     * Returns the name of the wrapped command.
     */
  String getName(ICommand command);

  /**
     * Executes the wrapped command with specified arguments.
     * 
     * The interceptor can use this method to intercept and alter the command execution.
     * Otherwise it shall just delete the call to the wrapped command.
     * 
     * - [correlationId] (optional) transaction id to trace execution through call chain.
     * - [command]       the next command in the call chain that is to be executed.
     * - [args]          the parameters (arguments) to pass to the command for execution.
     *   Returns         execution result. If an exception is raised, then
     *                      it will be throw exception.
     * 
     * See [Parameters]
     */
  Future<dynamic> execute(
      String correlationId, ICommand command, Parameters args);

  /**
     * Validates arguments of the wrapped command before its execution.
     * 
     * The interceptor can use this method to intercept and alter validation of the command arguments.
     * Otherwise it shall just delegate the call to the wrapped command.
     * 
     * - [command]   the next command in the call chain to be validated against.
     * - [args]      the parameters (arguments) to validate.
     * Returns         an array of ValidationResults.
     * 
     * See [Parameters]
     * See [ValidationResult]
     */
  List<ValidationResult> validate(ICommand command, Parameters args);
}
