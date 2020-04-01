
/// Interface for data objects that contain their latest change time.
/// 
/// ### Example ###
/// 
///     class MyData implements IStringIdentifiable, IChangeable {
///          String id;
///          String field1;
///          int field2;
///          DateTime change_time;
///         ...
///     }
 
abstract class IChangeable {
  /// The UTC time at which the object was last changed (created or updated). 
  DateTime change_time;
}
