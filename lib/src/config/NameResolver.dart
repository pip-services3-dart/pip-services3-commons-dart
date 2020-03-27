import './ConfigParams.dart';
import '../refer/Descriptor.dart';

/**
 * A helper class that allows to extract component name from configuration parameters.
 * The name can be defined in "id", "name" parameters or inside a component descriptor.
 * 
 * ### Example ###
 * 
 *     var config = ConfigParams.fromTuples([
 *         "descriptor", "myservice:connector:aws:connector1:1.0",
 *         "param1", "ABC",
 *         "param2", 123
 *     ]);
 *     
 *     let name = NameResolver.resolve(config); // Result: connector1
 */
class NameResolver {
  /**
     * Resolves a component name from configuration parameters.
     * The name can be stored in "id", "name" fields or inside a component descriptor.
     * If name cannot be determined it returns a defaultName.
     * 
     * - [config]        configuration parameters that may contain a component name.
     * - [defaultName]   (optional) a default component name.
     * Returns             resolved name or default name if the name cannot be determined.
     */
  static String resolve(ConfigParams config, [String defaultName = null]) {
    var name =
        config.getAsNullableString("name") ?? config.getAsNullableString("id");

    if (name == null) {
      var descriptorStr = config.getAsNullableString("descriptor");
      var descriptor = Descriptor.fromString(descriptorStr);
      if (descriptor != null) name = descriptor.getName();
    }

    return name ?? defaultName;
  }
}
