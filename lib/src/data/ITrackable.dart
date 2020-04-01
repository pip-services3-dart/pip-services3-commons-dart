import './IChangeable.dart';

/// Interface for data objects that can track their changes, including logical deletion.
///
/// See [IChangeable]
///
/// ### Example ###
///
///     class MyData implements IStringIdentifiable, ITrackable {
///         String id;
///         String  field1;
///         int field2;
///         ...
///         DateTime change_time;
///         DateTime create_time;
///         bool deleted;
///     }

abstract class ITrackable implements IChangeable {
  /// The UTC time at which the object was created.
  DateTime create_time;

  /// The UTC time at which the object was last changed (created, updated, or deleted).
  DateTime change_time;

  /// The logical deletion flag. True when object is deleted and null or false otherwise
  bool deleted;
}
