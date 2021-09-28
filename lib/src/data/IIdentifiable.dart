/// Generic interface for data objects that can be uniquely identified by an id.
///
/// The type specified in the interface defines the type of id field.
///
/// ### Example ###
///
///     class MyData implements IIdentifiable<string> {
///          String id;
///          String field1;
///          int field2;
///         ...
///     }

abstract class IIdentifiable<K> {
  /// The unique object identifier of type K.
  abstract K? id;
}
