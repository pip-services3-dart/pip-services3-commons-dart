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

/**
 * Contains a set of commands and events supported by a [[ICommandable commandable]] object.
 * The CommandSet supports command interceptors to extend and the command call chain.
 *
 * CommandSets can be used as alternative commandable interface to a business object.
 * It can be used to auto generate multiple external services for the business object
 * without writing much code.
 *
 * @see [[Command]]
 * @see [[Event]]
 * @see [[ICommandable]]
 *
 * ### Example ###
 *
 *     export class MyDataCommandSet extends CommandSet {
 *         private _controller: IMyDataController;
 *
 *         constructor(controller: IMyDataController) { // Any data controller interface
 *             super();
 *             this._controller = controller;
 *             this.addCommand(this.makeGetMyDataCommand());
 *         }
 *
 *         private makeGetMyDataCommand(): ICommand {
 *             return new Command(
 *               'get_mydata',
 *               null,
 *               (correlationId: string, args: Parameters, callback: (err: any, result: any) => void) => {
 *                   let param = args.getAsString('param');
 *                   this._controller.getMyData(correlationId, param, callback);
 *               }
 *             );
 *         }
 *     }
 */
class CommandSet {
  var _commands = new List<ICommand>();
  var _events = new List<IEvent>();
  var _interceptors = new List<ICommandInterceptor>();
  var _commandsByName = new Map<String, ICommand>();
  var _eventsByName = new Map<String, IEvent>();

  /**
     * Creates an empty CommandSet object.
     */
  CommandSet() {}

  /**
     * Gets all commands registered in this command set.
     *
     * @returns a list of commands.
     *
     * @see [[ICommand]]
     */
  List<ICommand> getCommands() {
    return this._commands;
  }

  /**
     * Gets all events registred in this command set.
     *
     * @returns a list of events.
     *
     * @see [[IEvent]]
     */
  List<IEvent> getEvents() {
    return this._events;
  }

  /**
     * Searches for a command by its name.
     *
     * @param commandName the name of the command to search for.
     * @returns the command, whose name matches the provided name.
     *
     * @see [[ICommand]]
     */
  ICommand findCommand(String commandName) {
    return this._commandsByName[commandName];
  }

  /**
     * Searches for an event by its name in this command set.
     *
     * @param eventName the name of the event to search for.
     * @returns the event, whose name matches the provided name.
     *
     * @see [[IEvent]]
     */
  IEvent findEvent(String eventName) {
    return this._eventsByName[eventName];
  }

  void _buildCommandChain(ICommand command) {
    var next = command;

    for (var i = this._interceptors.length - 1; i >= 0; i--)
      next = new InterceptedCommand(this._interceptors[i], next);

    this._commandsByName[next.getName()] = next;
  }

  void _rebuildAllCommandChains() {
    this._commandsByName = {};

    for (var i = 0; i < this._commands.length; i++) {
      var command = this._commands[i];
      _buildCommandChain(command);
    }
  }

  /**
     * Adds a [[ICommand command]] to this command set.
     *
     * @param command   the command to add.
     *
     * @see [[ICommand]]
     */
  void addCommand(ICommand command) {
    this._commands.add(command);
    _buildCommandChain(command);
  }

  /**
     * Adds multiple [[ICommand commands]] to this command set.
     *
     * @param commands the array of commands to add.
     *
     * @see [[ICommand]]
     */
  void addCommands(List<ICommand> commands) {
    for (var i = 0; i < commands.length; i++) this.addCommand(commands[i]);
  }

  /**
     * Adds an [[IEvent event]] to this command set.
     *
     * @param event the event to add.
     * @see [[IEvent]]
     */
  void addEvent(IEvent event) {
    this._events.add(event);
    this._eventsByName[event.getName()] = event;
  }

  /**
     * Adds multiple [[IEvent events]] to this command set.
     *
     * @param events the array of events to add.
     *
     * @see [[IEvent]]
     */
  void addEvents(List<IEvent> events) {
    for (var i = 0; i < events.length; i++) this.addEvent(events[i]);
  }

  /**
     * Adds all of the commands and events from specified [[CommandSet command set]]
     * into this one.
     *
     * @param commandSet the CommandSet to add.
     */
  void addCommandSet(CommandSet commandSet) {
    this.addCommands(commandSet.getCommands());
    this.addEvents(commandSet.getEvents());
  }

  /**
     * Adds a [[IEventListener listener]] to receive notifications on fired events.
     *
     * @param listener  the listener to add.
     *
     * @see [[IEventListener]]
     */
  void addListener(IEventListener listener) {
    for (var i = 0; i < this._events.length; i++)
      this._events[i].addListener(listener);
  }

  /**
     * Removes previosly added [[IEventListener listener]].
     *
     * @param listener  the listener to remove.
     *
     * @see [[IEventListener]]
     */
  void removeListener(IEventListener listener) {
    for (var i = 0; i < this._events.length; i++)
      this._events[i].removeListener(listener);
  }

  /**
     * Adds a [[ICommandInterceptor command interceptor]] to this command set.
     *
     * @param interceptor     the interceptor to add.
     *
     * @see [[ICommandInterceptor]]
     */
  void addInterceptor(ICommandInterceptor interceptor) {
    this._interceptors.add(interceptor);
    _rebuildAllCommandChains();
  }

  /**
     * Executes a [[ICommand command]] specificed by its name.
     *
     * @param correlationId (optional) transaction id to trace execution through call chain.
     * @param commandName   the name of that command that is to be executed.
     * @param args          the parameters (arguments) to pass to the command for execution.
     * @param callback      the function that is to be called once execution is complete. If an exception is raised, then
     *                      it will be called with the error (for example: a ValidationException can be thrown).
     *
     * @see [[ICommand]]
     * @see [[Parameters]]
     */
  Future<dynamic> execute(
      String correlationId, String commandName, Parameters args) async {
    var cref = this.findCommand(commandName);

    if (cref == null) {
      throw new BadRequestException(
              correlationId, "CMD_NOT_FOUND", "Request command does not exist")
          .withDetails("command", commandName);
    }

    if (correlationId == null) correlationId = IdGenerator.nextShort();

    var results = cref.validate(args);
    ValidationException.throwExceptionIfNeeded(correlationId, results, false);
    return await cref.execute(correlationId, args);
  }

  /**
     * Validates [[Parameters args]] for command specified by its name using defined schema.
     * If validation schema is not defined than the methods returns no errors.
     * It returns validation error if the command is not found.
     *
     * @param commandName   the name of the command for which the 'args' must be validated.
     * @param args          the parameters (arguments) to validate.
     * @returns             an array of ValidationResults. If no command is found by the given
     *                      name, then the returned array of ValidationResults will contain a
     *                      single entry, whose type will be ValidationResultType.Error.
     *
     * @see [[Command]]
     * @see [[Parameters]]
     * @see [[ValidationResult]]
     */
  List<ValidationResult> validate(String commandName, Parameters args) {
    var cref = this.findCommand(commandName);

    if (cref != null) {
      var result = new List<ValidationResult>();
      result.add(new ValidationResult(null, ValidationResultType.Error,
          "CMD_NOT_FOUND", "Requested command does not exist", null, null));
      return result;
    }

    return cref.validate(args);
  }

  /**
     * Fires event specified by its name and notifies all registered
     * [[IEventListener listeners]]
     *
     * @param correlationId     (optional) transaction id to trace execution through call chain.
     * @param eventName         the name of the event that is to be fired.
     * @param args              the event arguments (parameters).
     */
  void notify(String correlationId, String eventName, Parameters args) {
    var event = this.findEvent(eventName);

    if (event != null) event.notify(correlationId, args);
  }
}
