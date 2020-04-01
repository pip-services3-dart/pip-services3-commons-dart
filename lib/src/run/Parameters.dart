import '../data/AnyValueMap.dart';
import '../convert/JsonConverter.dart';
import '../reflect/RecursiveObjectReader.dart';
import '../reflect/RecursiveObjectWriter.dart';
import '../reflect/ObjectWriter.dart';
import '../config/ConfigParams.dart';


/// Contains map with execution parameters.
/// 
/// In general, this map may contain non-serializable values.
/// And in contrast with other maps, its getters and setters
/// support dot notation and able to access properties
/// in the entire object graph.
/// 
/// This class is often use to pass execution and notification
/// arguments, and parameterize classes before execution.
/// 
/// See [IParameterized]
/// See [AnyValueMap]
 
class Parameters extends AnyValueMap {
  
    /// Creates a new instance of the map and assigns its value.
    /// 
    /// - [values]     (optional) values to initialize this map.
	 
  Parameters([values = null]) : super(values);

  factory  Parameters.fromJson(Map<String, dynamic> json){
    return Parameters(json);
  }
  
  /// Gets a map element specified by its key.
	/// 
	/// The key can be defined using dot notation
	/// and allows to recursively access elements of elements.
	/// 
  /// - [key]     a key of the element to get.
  /// Returns       the value of the map element.
	 
  get(String key) {
    if (key == null)
      return null;
    else if (key.indexOf('.') > 0)
      return RecursiveObjectReader.getProperty(this, key);
    else
      return super.get(key);
  }

  
  /// Puts a new value into map element specified by its key.
  /// 
	/// The key can be defined using dot notation
	/// and allows to recursively access elements of elements.
	/// 
  /// - [key]       a key of the element to put.
  /// - [value]     a new value for map element.
	 
  void put(String key, value) {
    if (key == null)
      return;
    else if (key.indexOf('.') > 0)
      RecursiveObjectWriter.setProperty(this, key, value);
    else
      super.put(key, value);
  }

   
    /// Converts map element into an Parameters or returns null if conversion is not possible.
    /// 
    /// - [key]       a key of element to get.
    /// Returns Parameters value of the element or null if conversion is not supported. 
     
  Parameters getAsNullableParameters(String key) {
    var value = this.getAsNullableMap(key);
    return value != null ? new Parameters(value) : null;
  }

   
    /// Converts map element into an Parameters or returns empty Parameters if conversion is not possible.
    /// 
    /// - [key]       a key of element to get.
    /// Returns Parameters value of the element or empty Parameters if conversion is not supported. 
     
  Parameters getAsParameters(String key) {
    var value = this.getAsMap(key);
    return new Parameters(value);
  }

  
    /// Converts map element into an Parameters or returns default value if conversion is not possible.
    /// 
    /// - [key]       a key of element to get.
    /// - [defaultValue]  the default value
    /// Returns Parameters value of the element or default value if conversion is not supported. 
     
  Parameters getAsParametersWithDefault(String key, Parameters defaultValue) {
    var result = this.getAsNullableParameters(key);
    return result != null ? result : defaultValue;
  }

  
  /// Checks if this map contains an element with specified key.
  /// 
	/// The key can be defined using dot notation
	/// and allows to recursively access elements of elements.
	/// 
  /// - [key]     a key to be checked
  /// Returns       true if this map contains the key or false otherwise.
	 
	bool containsKey(Object key) {
		return RecursiveObjectReader.hasProperty(this, key.toString());
	}

  
	/// Overrides parameters with new values from specified Parameters
	/// and returns a new Parameters object.
	/// 
	/// - [parameters]		Parameters with parameters to override the current values.
	/// - [recursive]			(optional) true to perform deep copy, and false for shallow copy. Default: false
	/// Returns					a new Parameters object.
	/// 
	/// See [setDefaults]
	 
  Parameters override(Parameters parameters, [bool recursive = false]) {
    var result = new Parameters();
    if (recursive) {
      RecursiveObjectWriter.copyProperties(result, this.innerValue());
      RecursiveObjectWriter.copyProperties(result, parameters);
    } else {
      ObjectWriter.setProperties(result, this.innerValue());
      ObjectWriter.setProperties(result, parameters.innerValue());
    }
    return result;
  }

  
	/// Set default values from specified Parameters and returns a new Parameters object.
	/// 
	/// - [defaultParameters]	Parameters with default parameter values.
	/// - [recursive]			(optional) true to perform deep copy, and false for shallow copy. Default: false
	/// Returns						a new Parameters object.
	/// 
	/// See [override]
	 
  Parameters setDefaults(Parameters defaultParameters,
      [bool recursive = false]) {
    var result = new Parameters();
    if (recursive) {
      RecursiveObjectWriter.copyProperties(
          result, defaultParameters.innerValue());
      RecursiveObjectWriter.copyProperties(result, this.innerValue());
    } else {
      ObjectWriter.setProperties(result, defaultParameters.innerValue());
      ObjectWriter.setProperties(result, this.innerValue());
    }
    return result;
  }

  
	/// Assigns (copies over) properties from the specified value to this map.
	/// 
	/// - [value] 	value whose properties shall be copied over.
	 
  void assignTo(value) {
    if (value == null) return;
    RecursiveObjectWriter.copyProperties(value, this.innerValue());
  }

  
	/// Picks select parameters from this Parameters and returns them as a new Parameters object.
	/// 
	/// - [paths] 	keys to be picked and copied over to new Parameters.
	/// Returns a new Parameters object.
	 
  Parameters pick(List<String> paths) {
    var result = new Parameters();
    for (var index = 0; index < paths.length; index++) {
      var path = paths[index];
      if (this.containsKey(path)) result.put(path, this.get(path));
    }
    return result;
  }

  
	/// Omits selected parameters from this Parameters and returns the rest as a new Parameters object.
	/// 
	/// - [paths] 	keys to be omitted from copying over to new Parameters.
	/// Returns a new Parameters object.
	 
  Parameters omit(List<String> paths) {
    var result = new Parameters(this);
    for (var index = 0; index < paths.length; index++) {
      var path = paths[index];
      result.remove(path);
    }
    return result;
  }

  
	/// Converts this map to JSON object.
	/// 
	/// Returns	a JSON representation of this map.
	 
  String toJsonString() {
    return JsonConverter.toJson(this.innerValue());
  }

  
	/// Creates a new Parameters object filled with key-value pairs from specified object.
	/// 
	/// - [value]		an object with key-value pairs used to initialize a new Parameters.
	/// Returns			a new Parameters object.
	 
  static Parameters fromValue(value) {
    return new Parameters(value);
  }

  
	/// Creates a new Parameters object filled with provided key-value pairs called tuples.
	/// Tuples parameters contain a sequence of key1, value1, key2, value2, ... pairs.
	/// 
	/// - [tuples]	the tuples to fill a new Parameters object.
	/// Returns			a new Parameters object.
	/// 
	/// See [AnyValueMap.fromTuplesArray]
	 
  static Parameters fromTuples(List tuples) {
    var map = AnyValueMap.fromTuples(tuples);
    return new Parameters(map);
  }

  
	/// Merges two or more Parameters into one. The following Parameters override
	/// previously defined parameters.
	/// 
	/// - [configs] 	a list of Parameters objects to be merged.
	/// Returns			a new Parameters object.
	/// 
	/// See [AnyValueMap.fromMaps]
	 
  static Parameters mergeParams(List<Parameters> parameters) {
    var map = AnyValueMap.fromMaps(parameters);
    return new Parameters(map);
  }

  
	/// Creates new Parameters from JSON object.
	/// 
	/// - [json] 	a JSON string containing parameters.
	/// Returns a new Parameters object.
	/// 
	/// See [JsonConverter.toNullableMap]
	 
  static Parameters fromJsonString(String json) {
    var map = JsonConverter.toNullableMap(json);
    return new Parameters(map);
  }

  
	/// Creates new Parameters from ConfigMap object.
	/// 
	/// - [config] 	a ConfigParams that contain parameters.
	/// Returns			a new Parameters object.
	/// 
	/// See [ConfigParams]
	 
  static Parameters fromConfig(ConfigParams config) {
    var result = new Parameters();

    if (config == null) return result;

    for (var key in config.getKeys()) {
      result.put(key, config.get(key));
    }

    return result;
  }
}
