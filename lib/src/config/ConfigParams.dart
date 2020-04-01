import '../data/StringValueMap.dart';
import '../reflect/RecursiveObjectReader.dart';


/// Contains a key-value map with configuration parameters. 
/// All values stored as strings and can be serialized as JSON or string forms.
/// When retrieved the values can be automatically converted on read using GetAsXXX methods.

/// The keys are case-sensitive, so it is recommended to use consistent C-style as: <code>'my_param'</code>
///  
/// Configuration parameters can be broken into sections and subsections using dot notation as:
/// <code>'section1.subsection1.param1'</code>. Using GetSection method all parameters from specified section
/// can be extracted from a ConfigMap.
/// 
/// The ConfigParams supports serialization from/to plain strings as:
/// <code>'key1=123;key2=ABC;key3=2016-09-16T00:00:00.00Z'</code>
/// 
/// ConfigParams are used to pass configurations to [IConfigurable] objects.
/// They also serve as a basis for more concrete configurations such as [https://rawgit.com/pip-services-node/pip-services-components-node/master/doc/api/classes/connect.connectionparams.html ConnectionParams]
/// or [https://rawgit.com/pip-services-node/pip-services-components-node/master/doc/api/classes/auth.credentialparams.html CredentialParams] (in the Pip.Services components package).
/// 
/// See [IConfigurable]
/// See [StringValueMap]
/// 
/// ### Example ###
/// 
///     var config = ConfigParams.fromTuples([
///         ['section1.key1', 'AAA',
///         'section1.key2', 123,
///         'section2.key1', true]
///     ]);
///             
///     config.getAsString('section1.key1'); // Result: AAA
///     config.getAsInteger('section1.key1'); // Result: 0
///     
///     section1 = config.getSection('section1');
///     section1.toString(); // Result: key1=AAA;key2=123
///  
 
class ConfigParams extends StringValueMap {
  
	/// Creates a new ConfigParams and fills it with values.
	/// 
	/// - [values] 	(optional) an object to be converted into key-value pairs to initialize this config map.
	/// 
	/// See [StringValueMap.constructor]
	 
  ConfigParams([values = null]) : super(values);

  
	/// Gets a list with all 1st level section names.
	/// 
	/// Returns a list of section names stored in this ConfigMap.
	 
  List<String> getSectionNames() {
    var sections =  List<String>();

    for (var key in this.getKeys()) {
      var pos = key.indexOf('.');
      var section = key;
      if (pos > 0) section = key.substring(0, pos);

      // Perform case sensitive search
      var found = false;
      for (var index = 0; index < sections.length; index++) {
        if (section == sections[index]) {
          found = true;
          break;
        }
      }

      if (!found) sections.add(section);
    }

    return sections;
  }

  
	/// Gets parameters from specific section stored in this ConfigMap.
	/// The section name is removed from parameter keys.
	/// 
	/// - [section]	name of the section to retrieve configuration parameters from.
	/// Returns 		all configuration parameters that belong to the section named 'section'. 
	 
  ConfigParams getSection(String section) {
    var result =  ConfigParams();
    var prefix = section + '.';

    for (var key in this.getKeys()) {
      // Prevents exception on the next line
      if (key.length < prefix.length) continue;

      // Perform case sensitive match
      var keyPrefix = key.substring(0, prefix.length);
      if (keyPrefix == prefix) {
        var name = key.substring(prefix.length);
        result.put(name, this[key]);
      }
    }

    return result;
  }

  
	/// Adds parameters into this ConfigParams under specified section.
	/// Keys for the new parameters are appended with section dot prefix.
	/// 
	/// - [section] 			name of the section where add new parameters
	/// - [sectionParams] 	new parameters to be added.
	 
  void addSection(String section, ConfigParams sectionParams) {
    if (section == null) throw  Exception('Section name cannot be null');

    if (sectionParams != null) {
      for (var key in sectionParams.getKeys()) {
        var name = key;

        if (name.length > 0 && section.length > 0)
          name = section + '.' + name;
        else if (name.length == 0) name = section;

        var value = sectionParams[key];

        this.put(name, value);
      }
    }
  }

  
	/// Overrides parameters with new values from specified ConfigParams
	/// and returns a new ConfigParams object.
	/// 
	/// - [configParams]		ConfigMap with parameters to override the current values.
	/// Returns					a new ConfigParams object.
	/// 
	/// See [setDefaults]
	 
  ConfigParams override(ConfigParams configParams) {
    var map = StringValueMap.fromMaps([this, configParams]);
    return  ConfigParams(map);
  }

  
	/// Set default values from specified ConfigParams and returns a new ConfigParams object.
	/// 
	/// - [defaultConfigParams]	ConfigMap with default parameter values.
	/// Returns						a new ConfigParams object.
	/// 
	/// See [override]
	 
  ConfigParams setDefaults(ConfigParams defaultConfigParams) {
    var map = StringValueMap.fromMaps([defaultConfigParams, this]);
    return  ConfigParams(map);
  }

  
	/// Creates a new ConfigParams object filled with key-value pairs from specified object.
	/// 
	/// - [value]		an object with key-value pairs used to initialize a new ConfigParams.
	/// Returns			a new ConfigParams object.
	 
  static ConfigParams fromValue(value) {
    var map = RecursiveObjectReader.getProperties(value);
    return  ConfigParams(map);
  }

  
	/// Creates a new ConfigParams object filled with provided key-value pairs called tuples.
	/// Tuples parameters contain a sequence of key1, value1, key2, value2, ... pairs.
	/// 
	/// - [tuples]	the tuples to fill a new ConfigParams object.
	/// Returns			a new ConfigParams object.
	/// 
	/// See [StringValueMap.fromTuplesArray]
	 
  static ConfigParams fromTuples(List tuples) {
    var map = StringValueMap.fromTuplesArray(tuples);
    return  ConfigParams(map);
  }

  
	/// Creates a new ConfigParams object filled with key-value pairs serialized as a string.
	/// 
	/// - [line] 		a string with serialized key-value pairs as 'key1=value1;key2=value2;...'
	/// 					Example: 'Key1=123;Key2=ABC;Key3=2016-09-16T00:00:00.00Z'
	/// Returns			a new ConfigParams object.
	/// 
	/// See [StringValueMap.fromString]
	 
  static ConfigParams fromString(String line) {
    var map = StringValueMap.fromString(line);
    return  ConfigParams(map);
  }

  
	/// Merges two or more ConfigParams into one. The following ConfigParams override
	/// previously defined parameters.
	/// 
	/// - [configs] 	a list of ConfigParams objects to be merged.
	/// Returns			a new ConfigParams object.
	/// 
	/// See [StringValueMap.fromMaps]
	 
  static ConfigParams mergeConfigs(List<ConfigParams> configs) {
    var map = StringValueMap.fromMaps(configs);
    return  ConfigParams(map);
  }
}
