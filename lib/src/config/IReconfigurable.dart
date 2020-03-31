import './IConfigurable.dart';

/**
 * An interface to set configuration parameters to an object.
 * 
 * It is similar to [IConfigurable] interface, but emphasises the fact
 * that <code>configure()</code> method can be called more than once to change object configuration
 * in runtime.
 * 
 * See [IConfigurable]
 */
abstract class IReconfigurable implements IConfigurable {}
