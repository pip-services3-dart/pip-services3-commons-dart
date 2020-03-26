import 'dart:async';

import '../../pip_services3_commons.dart';
import '../errors/InvocationException.dart';
import '../validate/Schema.dart';
import '../run/Parameters.dart';
import '../validate/ValidationResult.dart';
import './ICommand.dart';

/**
 * Concrete implementation of [[ICommand ICommand]] interface. Command allows to call a method
 * or function using Command pattern.
 *
 * ### Example ###
 *
 *     let command = new Command("add", null, (correlationId, args, callback) => {
 *         let param1 = args.getAsFloat("param1");
 *         let param2 = args.getAsFloat("param2");
 *         let result = param1 + param2;
 *         callback(null, result);
 *     });
 *
 *     command.execute(
 *       "123",
 *       Parameters.fromTuples(
 *         "param1", 2,
 *         "param2", 2
 *       ),
 *       (err, result) => {
 *         if (err) console.error(err);
 *         else console.log("2 + 2 = " + result);
 *       }
 *     );
 *
 *     // Console output: 2 + 2 = 4
 *
 * @see [[ICommand]]
 * @see [[CommandSet]]
 */
class Command implements ICommand {
  String _name;
  Schema _schema;
  Future<dynamic> Function(String correlationId, Parameters args) _function;

  /**
     * Creates a new command object and assigns it's parameters.
     *
     * @param name      the command name.
     * @param schema    the schema to validate command arguments.
     * @param func      the function to be executed by this command.
     */
  Command(String name, Schema schema, func) {
    if (name == null) throw new Exception("Name cannot be null");
    if (func == null) throw new Exception("Function cannot be null");

    this._name = name;
    this._schema = schema;

    if (func is IExecutable)
      this._function = func.execute;
    else
      this._function = func;

    if (!(this._function is Function))
      throw new Exception("Function doesn't have function type");
  }

  /**
     * Gets the command name.
     * @returns the name of this command.
     */
  String getName() {
    return this._name;
  }

  /**
     * Executes the command. Before execution it validates [[Parameters args]] using
     * the defined schema. The command execution intercepts exceptions raised
     * by the called function and returns them as an error in callback.
     *
     * @param correlationId (optional) transaction id to trace execution through call chain.
     * @param args          the parameters (arguments) to pass to this command for execution.
     * @param callback      function to be called when command is complete
     *
     * @see [[Parameters]]
     */
  Future<dynamic> execute(String correlationId, Parameters args) async {
    if (this._schema != null) {
      this._schema.validateAndThrowException(correlationId, args);
    }

    try {
      var result = await this._function(correlationId, args);
      return result;
    } catch (ex) {
      throw new InvocationException(correlationId, "EXEC_FAILED",
              "Execution " + this.getName() + " failed: " + ex)
          .withDetails("command", this.getName())
          .wrap(ex);
    }
  }

  /**
     * Validates the command [[Parameters args]] before execution using the defined schema.
     *
     * @param args  the parameters (arguments) to validate using this command's schema.
     * @returns     an array of ValidationResults or an empty array (if no schema is set).
     *
     * @see [[Parameters]]
     * @see [[ValidationResult]]
     */
  List<ValidationResult> validate(Parameters args) {
    if (this._schema != null) return this._schema.validate(args);

    return [];
  }
}
