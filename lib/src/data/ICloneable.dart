
/// Interface for data objects that are able to create their full binary copy.
/// 
/// ### Example ###
/// 
///     class MyClass implements IMyClass, ICloneable {
///       MyClass() { };
///     
///       clone() {
///           var cloneObj =  (this.<any constructor>());
///                  
///           // Copy every attribute from this to cloneObj here.
///           ...
///                  
///           return cloneObj;
///       }
///     }
 
abstract class ICloneable {
   
    /// Creates a binary clone of this object.
    /// 
    /// Returns a clone of this object.
     
  clone();
}
