
/// Interface for data objects that can be versioned.
/// 
/// Versioning is often used as optimistic concurrency mechanism. 
/// 
/// The version doesn't have to be a number, but it is recommended to use sequential
/// values to determine if one object has newer or older version than another one.
/// 
/// It is a common pattern to use the time of change as the object version.
/// 
/// ### Example ###
/// 
///     class MyData implements IStringIdentifiable, IVersioned {
///          String id;
///         String  field1;
///         int field2;
///         String version;
///         ...
///     }
///     
///      void updateData(String correlationId, MyData item ) {
///         ...
///         if (item.version < oldItem.version) {
///             throw  ConcurrencyException(null, 'VERSION_CONFLICT', 'The change has older version stored value');
///         }
///         ...
///     }
 
abstract class IVersioned {
  /// The object's version. 
  String version;
}
