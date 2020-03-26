import '../run/IExecutable.dart';
import '../run/Parameters.dart';
import '../validate/ValidationResult.dart';

/**
 * An interface for Commands, which are part of the Command design pattern.
 * Each command wraps a method or function and allows to call them in uniform and safe manner.
 * 
 * @see [[Command]]
 * @see [[IExecutable]]
 * @see [[ICommandInterceptor]]
 * @see [[InterceptedCommand]]
 */
abstract class ICommand extends IExecutable {
  /**
     * Gets the command name.
     * 
     * @returns the command name.
     */
  String getName();

  /**
     * Validates command arguments before execution using defined schema.
     * 
     * @param args  the parameters (arguments) to validate.
     * @returns     an array of ValidationResults.
     * 
     * @see [[Parameters]]
     * @see [[ValidationResult]]
     */
  List<ValidationResult> validate(Parameters args);
}
