import '../data/AnyValueMap.dart';
import '../convert/JsonConverter.dart';
import '../reflect/RecursiveObjectReader.dart';
import '../reflect/RecursiveObjectWriter.dart';
import '../reflect/ObjectWriter.dart';
import '../config/ConfigParams.dart';

/**
 * Contains map with execution parameters.
 * 
 * In general, this map may contain non-serializable values.
 * And in contrast with other maps, its getters and setters
 * support dot notation and able to access properties
 * in the entire object graph.
 * 
 * This class is often use to pass execution and notification
 * arguments, and parameterize classes before execution.
 * 
 * @see [[IParameterized]]
 * @see [[AnyValueMap]]
 */
class Parameters extends AnyValueMap {

	/**
     * Creates a new instance of the map and assigns its value.
     * 
     * @param values     (optional) values to initialize this map.
	 */
	Parameters([values = null])
		: super(values);

	/**
     * Gets a map element specified by its key.
	 * 
	 * The key can be defined using dot notation
	 * and allows to recursively access elements of elements.
	 * 
     * @param key     a key of the element to get.
     * @returns       the value of the map element.
	 */
	get(String key) {
		if (key == null)
			return null;
		else if (key.indexOf('.') > 0)
			return RecursiveObjectReader.getProperty(this, key);
		else
			return super.get(key);
	}

	/**
     * Puts a new value into map element specified by its key.
     * 
	 * The key can be defined using dot notation
	 * and allows to recursively access elements of elements.
	 * 
     * @param key       a key of the element to put.
     * @param value     a new value for map element.
	 */
	void put(String key, value) {
		if (key == null)
			return;
		else if (key.indexOf('.') > 0)
			RecursiveObjectWriter.setProperty(this, key, value);
		else
			super.put(key, value);
  }

	/** 
     * Converts map element into an Parameters or returns null if conversion is not possible.
     * 
     * @param key       a key of element to get.
     * @returns Parameters value of the element or null if conversion is not supported. 
     */
  Parameters getAsNullableParameters(String key) {
    var value = this.getAsNullableMap(key);
    return value != null ? new Parameters(value) : null;
  }

	/** 
     * Converts map element into an Parameters or returns empty Parameters if conversion is not possible.
     * 
     * @param key       a key of element to get.
     * @returns Parameters value of the element or empty Parameters if conversion is not supported. 
     */
  Parameters getAsParameters(String key) {
    var value = this.getAsMap(key);
    return new Parameters(value);
  }

	/**
     * Converts map element into an Parameters or returns default value if conversion is not possible.
     * 
     * @param key       a key of element to get.
     * @param defaultValue  the default value
     * @returns Parameters value of the element or default value if conversion is not supported. 
     */
  Parameters getAsParametersWithDefault(String key, Parameters defaultValue) {
    var result = this.getAsNullableParameters(key);
    return result != null ? result: defaultValue;
  }

	/**
     * Checks if this map contains an element with specified key.
     * 
	 * The key can be defined using dot notation
	 * and allows to recursively access elements of elements.
	 * 
     * @param key     a key to be checked
     * @returns       true if this map contains the key or false otherwise.
	 */
	bool contains(String key) {
		return RecursiveObjectReader.hasProperty(this, key.toString());
	}
	
	/**
	 * Overrides parameters with new values from specified Parameters
	 * and returns a new Parameters object.
	 * 
	 * @param parameters		Parameters with parameters to override the current values.
	 * @param recursive			(optional) true to perform deep copy, and false for shallow copy. Default: false
	 * @returns					a new Parameters object.
	 * 
	 * @see [[setDefaults]]
	 */
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

	/**
	 * Set default values from specified Parameters and returns a new Parameters object.
	 * 
	 * @param defaultParameters	Parameters with default parameter values.
	 * @param recursive			(optional) true to perform deep copy, and false for shallow copy. Default: false
	 * @returns						a new Parameters object.
	 * 
	 * @see [[override]]
	 */
	Parameters setDefaults(Parameters defaultParameters, [bool recursive = false]) {
 		var result = new Parameters();
 		if (recursive) {
 			RecursiveObjectWriter.copyProperties(result, defaultParameters.innerValue());
 			RecursiveObjectWriter.copyProperties(result, this.innerValue());
 		} else {
 			ObjectWriter.setProperties(result, defaultParameters.innerValue());
 			ObjectWriter.setProperties(result, this.innerValue());
 		}
    return result;
	}

	/**
	 * Assigns (copies over) properties from the specified value to this map.
	 * 
	 * @param value 	value whose properties shall be copied over.
	 */
  void assignTo(value) {
    if (value == null) return;        
      RecursiveObjectWriter.copyProperties(value, this.innerValue());
  }
	
	/**
	 * Picks select parameters from this Parameters and returns them as a new Parameters object.
	 * 
	 * @param paths 	keys to be picked and copied over to new Parameters.
	 * @returns a new Parameters object.
	 */
  Parameters pick(List<String> paths) {
    var result = new Parameters();
    for (var index = 0; index < paths.length; index++) {
      var path = paths[index];
      if (this.containsKey(path))
          result.put(path, this.get(path));
    }
    return result;
  }

	/**
	 * Omits selected parameters from this Parameters and returns the rest as a new Parameters object.
	 * 
	 * @param paths 	keys to be omitted from copying over to new Parameters.
	 * @returns a new Parameters object.
	 */
  Parameters omit(List<String> paths) {
    var result = new Parameters(this);        
    for (var index = 0; index < paths.length; index++) {
        var path = paths[index];
        result.remove(path);
    }
    return result;
  }
	
	/**
	 * Converts this map to JSON object.
	 * 
	 * @returns	a JSON representation of this map.
	 */
	String toJsonString() {
		return JsonConverter.toJson(this.innerValue());
	}
	
	/**
	 * Creates a new Parameters object filled with key-value pairs from specified object.
	 * 
	 * @param value		an object with key-value pairs used to initialize a new Parameters.
	 * @returns			a new Parameters object.
	 */
  static Parameters fromValue(value) {
      return new Parameters(value);
  }
	
	/**
	 * Creates a new Parameters object filled with provided key-value pairs called tuples.
	 * Tuples parameters contain a sequence of key1, value1, key2, value2, ... pairs.
	 * 
	 * @param tuples	the tuples to fill a new Parameters object.
	 * @returns			a new Parameters object.
	 * 
	 * @see [[AnyValueMap.fromTuplesArray]]
	 */
	static Parameters fromTuples(List tuples) {
		var map = AnyValueMap.fromTuples(tuples);
		return new Parameters(map);
	}
		
	/**
	 * Merges two or more Parameters into one. The following Parameters override
	 * previously defined parameters.
	 * 
	 * @param configs 	a list of Parameters objects to be merged.
	 * @returns			a new Parameters object.
	 * 
	 * @see [[AnyValueMap.fromMaps]]
	 */
	static Parameters mergeParams(List<Parameters> parameters) {
		var map = AnyValueMap.fromMaps(parameters);
		return new Parameters(map);
	}
	
	/**
	 * Creates new Parameters from JSON object.
	 * 
	 * @param json 	a JSON string containing parameters.
	 * @returns a new Parameters object.
	 * 
	 * @see [[JsonConverter.toNullableMap]]
	 */
	static Parameters fromJsonString(String json) {
		var map = JsonConverter.toNullableMap(json);
		return new Parameters(map);
	}
	
	/**
	 * Creates new Parameters from ConfigMap object.
	 * 
	 * @param config 	a ConfigParams that contain parameters.
	 * @returns			a new Parameters object.
	 * 
	 * @see [[ConfigParams]]
	 */
	static Parameters fromConfig(ConfigParams config) {
		var result = new Parameters();
		
		if (config == null)
			return result;
		
		for (var key in config.getKeys()) {
      result.put(key, config.get(key));
		}
		
		return result;
	}
}
