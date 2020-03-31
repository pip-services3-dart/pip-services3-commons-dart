import './ConfigParams.dart';

/**
/// An interface to set configuration parameters to an object.
/// 
/// It can be added to any existing class by implementing a single <code>configure()</code> method.
/// 
/// If you need to emphasis the fact that <code>configure()</code> method can be called multiple times
/// to change object configuration in runtime, use [IReconfigurable] interface instead.
/// 
/// See [ConfigParams]
/// 
/// ### Example ###
/// 
///     class MyClass implements IConfigurable {
///         var _myParam = "default value";
///              
///         void configure(ConfigParams config) {
///             this._myParam = config.getAsStringWithDefault("options.param", myParam);
///             ...
///         }
///     }
 */
abstract class IConfigurable {
  /**
    /// Configures component by passing configuration parameters.
    /// 
    /// - [config]    configuration parameters to be set.
     */
  void configure(ConfigParams config);
}
