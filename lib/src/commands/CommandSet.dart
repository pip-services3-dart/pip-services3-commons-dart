import 'dart:async';

import './ICommand.dart';
import './IEvent.dart';
import './IEventListener.dart';
import './ICommandInterceptor.dart';
import './InterceptedCommand.dart';
import '../errors/BadRequestException.dart';
import '../validate/ValidationException.dart';
import '../validate/ValidationResult.dart';
import '../validate/ValidationResultType.dart';
import '../run/Parameters.dart';
import '../data/IdGenerator.dart';

/// Contains a set of commands and events supported by a [ICommandable commandable] object.
/// The CommandSet supports command interceptors to extend and the command call chain.

/// CommandSets can be used as alternative commandable interface to a business object.
/// It can be used to auto generate multiple external services for the business object
/// without writing much code.

/// See [Command]
/// See [Event]
/// See [ICommandable]

/// ### Example ###

///     class MyDataCommandSet extends CommandSet {
///          IMyDataController _controller ;

///         MyDataCommandSet(IMyDataController controller): super() { // Any data controller interface
///             _controller = controller;
///             addCommand(makeGetMyDataCommand());
///         }

///         ICommand _makeGetMyDataCommand()  {
///             return  Command(
///               'get_mydata',
///               null,
///               (String correlationId, Parameters args) {
///                   var param = args.getAsString('param');
///                   return _controller.getMyData(correlationId, param);
///               }
///             );
///         }
///     }

class CommandSet {
  final _commands = <ICommand>[];
  final _events = <IEvent>[];
  final _interceptors = <ICommandInterceptor>[];
  var _commandsByName = <String, ICommand>{};
  final _eventsByName = <String, IEvent>{};

  /// Creates an empty CommandSet object.

  CommandSet();

  /// Gets all commands registered in this command set.

  /// Returns a list of commands.

  /// See [ICommand]

  List<ICommand> getCommands() {
    return _commands;
  }

  /// Gets all events registred in this command set.

  /// Returns a list of events.

  /// See [IEvent]

  List<IEvent> getEvents() {
    return _events;
  }

  /// Searches for a command by its name.

  /// - [commandName] the name of the command to search for.
  /// Returns the command, whose name matches the provided name.

  /// See [ICommand]

  ICommand? findCommand(String commandName) {
    return _commandsByName[commandName];
  }

  /// Searches for an event by its name in this command set.

  /// - [eventName] the name of the event to search for.
  /// Returns the event, whose name matches the provided name.

  /// See [IEvent]

  IEvent? findEvent(String eventName) {
    return _eventsByName[eventName];
  }

  void _buildCommandChain(ICommand command) {
    var next = command;

    for (var i = _interceptors.length - 1; i >= 0; i--) {
      next = InterceptedCommand(_interceptors[i], next);
    }

    _commandsByName[next.getName()] = next;
  }

  void _rebuildAllCommandChains() {
    _commandsByName = {};

    for (var i = 0; i < _commands.length; i++) {
      var command = _commands[i];
      _buildCommandChain(command);
    }
  }

  /// Adds a [ICommand command] to this command set.

  /// - [command]   the command to add.

  /// See [ICommand]

  void addCommand(ICommand command) {
    _commands.add(command);
    _buildCommandChain(command);
  }

  /// Adds multiple [ICommand commands] to this command set.

  /// - [commands] the array of commands to add.

  /// See [ICommand]

  void addCommands(List<ICommand> commands) {
    for (var i = 0; i < commands.length; i++) {
      addCommand(commands[i]);
    }
  }

  /// Adds an [IEvent event] to this command set.

  /// - [event] the event to add.
  /// See [IEvent]

  void addEvent(IEvent event) {
    _events.add(event);
    _eventsByName[event.getName()] = event;
  }

  /// Adds multiple [IEvent events] to this command set.

  /// - [events] the array of events to add.

  /// See [IEvent]

  void addEvents(List<IEvent> events) {
    for (var i = 0; i < events.length; i++) {
      addEvent(events[i]);
    }
  }

  /// Adds all of the commands and events from specified [CommandSet command set]
  /// into this one.

  /// - [commandSet] the CommandSet to add.

  void addCommandSet(CommandSet commandSet) {
    addCommands(commandSet.getCommands());
    addEvents(commandSet.getEvents());
  }

  /// Adds a [IEventListener listener] to receive notifications on fired events.

  /// - [listener]  the listener to add.

  /// See [IEventListener]

  void addListener(IEventListener listener) {
    for (var i = 0; i < _events.length; i++) {
      _events[i].addListener(listener);
    }
  }

  /// Removes previosly added [IEventListener listener].

  /// - [listener]  the listener to remove.

  /// See [IEventListener]

  void removeListener(IEventListener listener) {
    for (var i = 0; i < _events.length; i++) {
      _events[i].removeListener(listener);
    }
  }

  /// Adds a [ICommandInterceptor command interceptor] to this command set.

  /// - [interceptor]     the interceptor to add.

  /// See [ICommandInterceptor]

  void addInterceptor(ICommandInterceptor interceptor) {
    _interceptors.add(interceptor);
    _rebuildAllCommandChains();
  }

  /// Executes a [ICommand command]specificed by its name.

  /// - [correlationId] (optional) transaction id to trace execution through call chain.
  /// - [commandName]   the name of that command that is to be executed.
  /// - [args]          the parameters (arguments) to pass to the command for execution.
  /// - Returns       execution result. If an exception is raised, then
  ///                      it will be throw the exeption (for example: a ValidationException can be thrown).

  /// See [ICommand]
  /// See [Parameters]

  Future<dynamic> execute(
      String? correlationId, String commandName, Parameters args) async {
    var cref = findCommand(commandName);

    if (cref == null) {
      throw BadRequestException(
              correlationId, 'CMD_NOT_FOUND', 'Request command does not exist')
          .withDetails('command', commandName);
    }

    correlationId ??= IdGenerator.nextShort();

    var results = cref.validate(args);
    ValidationException.throwExceptionIfNeeded(correlationId, results, false);
    return await cref.execute(correlationId, args);
  }

  /// Validates [Parameters args] for command specified by its name using defined schema.
  /// If validation schema is not defined than the methods returns no errors.
  /// It returns validation error if the command is not found.

  /// - [commandName]   the name of the command for which the 'args' must be validated.
  /// - [args]          the parameters (arguments) to validate.
  /// Returns             an array of ValidationResults. If no command is found by the given
  ///                      name, then the returned array of ValidationResults will contain a
  ///                      single entry, whose type will be ValidationResultType.Error.

  /// See [Command]
  /// See [Parameters]
  /// See [ValidationResult]

  List<ValidationResult> validate(String commandName, Parameters args) {
    var cref = findCommand(commandName);

    if (cref == null) {
      var result = <ValidationResult>[];
      result.add(ValidationResult(null, ValidationResultType.Error,
          'CMD_NOT_FOUND', 'Requested command does not exist', null, null));
      return result;
    }

    return cref.validate(args);
  }

  /// Fires event specified by its name and notifies all registered
  /// [IEventListener listeners]

  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [eventName]         the name of the event that is to be fired.
  /// - [args]              the event arguments (parameters).

  void notify(String? correlationId, String eventName, Parameters args) {
    var event = findEvent(eventName);

    if (event != null) event.notify(correlationId, args);
  }
}
