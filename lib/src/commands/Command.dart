import 'dart:async';

import '../../pip_services3_commons.dart';
import '../errors/InvocationException.dart';
import '../validate/Schema.dart';
import '../run/Parameters.dart';
import '../validate/ValidationResult.dart';
import './ICommand.dart';

/// Concrete implementation of [ICommand] interface. Command allows to call a method
/// or function using Command pattern.

/// ### Example ###

///     var command =  Command('add', null, (correlationId, args) {
///         var param1 = args.getAsFloat('param1');
///         var param2 = args.getAsFloat('param2');
///         var result = param1 + param2;
///         return result;
///     });

///     result = await command.execute(
///       '123',
///       Parameters.fromTuples(
///         ['param1', 2,
///         'param2', 2]
///       )).catch(err) {
///         if (err!= null) print(err);
///         else print('2 + 2 = ' + result);
///       }
///     );

///     // Console output: 2 + 2 = 4

/// See [ICommand]
/// See [CommandSet]

class Command implements ICommand {
  String _name;
  Schema _schema;
  Future<dynamic> Function(String correlationId, Parameters args) _function;

  /// Creates a new command object and assigns it's parameters.

  /// - name      the command name.
  /// - schema    the schema to validate command arguments.
  /// - func      the function to be executed by this command.

  Command(String name, Schema schema, func) {
    if (name == null) throw Exception('Name cannot be null');
    if (func == null) throw Exception('Function cannot be null');

    _name = name;
    _schema = schema;

    if (func is IExecutable) {
      _function = func.execute;
    } else {
      _function = func;
    }

    if (!(_function is Function)) {
      throw Exception('Function doesn\'t have function type');
    }
  }

  /// Gets the command name.
  /// Returns the name of this command.
  @override
  String getName() {
    return _name;
  }

  /// Executes the command. Before execution it validates [Parameters args] using
  /// the defined schema. The command execution intercepts exceptions raised
  /// by the called function and returns them as an error in callback.

  /// - correlationId (optional) transaction id to trace execution through call chain.
  /// - args          the parameters (arguments) to pass to this command for execution.
  /// Return          Future when command is complete
  /// See [Parameters]
  @override
  Future<dynamic> execute(String correlationId, Parameters args) async {
    if (_schema != null) {
      _schema.validateAndThrowException(correlationId, args);
    }

    try {
      var result = await _function(correlationId, args);
      return result;
    } catch (ex) {
      throw InvocationException(correlationId, 'EXEC_FAILED',
              'Execution ' + getName() + ' failed: ' + ex)
          .withDetails('command', getName())
          .wrap(ex);
    }
  }

  /// Validates the command [Parameters args] before execution using the defined schema.
  /// - args  the parameters (arguments) to validate using this command's schema.
  /// Returns     an array of ValidationResults or an empty array (if no schema is set).
  /// See [Parameters]
  /// See [ValidationResult]
  @override
  List<ValidationResult> validate(Parameters args) {
    if (_schema != null) return _schema.validate(args);
    return [];
  }
}
