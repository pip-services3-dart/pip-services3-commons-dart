/// Interface for data objects that have human-readable names.
///
/// ### Example ###
///
///     class MyData implements IStringIdentifiable, INamed {
///         String id;
///         String name;
///         String field1;
///         String field2;
///         ...
///     }

abstract class INamed {
  /// The object's humand-readable name.
  String name;
}
