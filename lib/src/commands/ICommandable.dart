import './CommandSet.dart';

/// An interface for commandable objects, which are part of the command design pattern.
/// The commandable object exposes its functonality as commands and events groupped
/// into a [CommandSet CommandSet].

/// This interface is typically implemented by controllers and is used to auto generate
/// external interfaces.

/// See [CommandSet]

/// ### Example ###

///     class MyDataController implements ICommandable, IMyDataController {
///       MyDataCommandSet _commandSet;

///       CommandSet getCommandSet() {
///         if (_commandSet == null)
///           _commandSet =  MyDataCommandSet(this);
///         return _commandSet;
///       }

///       ...
///     }

/// See [CommandSet] examples

abstract class ICommandable {
  /// Gets a command set with all supported commands and events.

  /// Returns a command set with commands and events.

  /// See [CommandSet]

  CommandSet getCommandSet();
}
