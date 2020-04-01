import './StringValueMap.dart';


/// Data transfer object used to pass filter parameters as simple key-value pairs.
/// 
/// See [StringValueMap]
/// 
/// ### Example ###
/// 
///     var filter = FilterParams.fromTuples(
///         ['type', 'Type1',
///         'from_create_time', new Date(2000, 0, 1),
///         'to_create_time', new Date(),
///         'compvared', true]
///     );
///     var paging = new PagingParams(0, 100);
///     
///     myDataClient.getDataByFilter(filter, paging, (err, page) => {...});
 
class FilterParams extends StringValueMap {
  
	/// Creates a new instance and initalizes it with elements from the specified map.
	/// 
	/// - [map] 	a map to initialize this instance.
	 
  FilterParams([map = null]) : super(map);


  /// Creates a new instance and initalizes it with elements from the specified map.
  /// 
  /// - [json]    json values to initialize this object.
   
  factory FilterParams.fromJson(Map<String, dynamic> json) {
    return new FilterParams(json);
  }

  
  /// Converts specified value into FilterParams.
  /// 
  /// - [value]     value to be converted
  /// Returns         a newly created FilterParams.
	 
  static FilterParams fromValue(value) {
    return new FilterParams(value);
  }

  
   /// Creates a new FilterParams from a list of key-value pairs called tuples.
   /// 
   /// - [tuples]    a list of values where odd elements are keys and the following even elements are values
   /// Returns         a newly created FilterParams.
	 
  static FilterParams fromTuples(List tuples) {
    var map = StringValueMap.fromTuplesArray(tuples);
    return new FilterParams(map);
  }

  
   /// Parses semicolon-separated key-value pairs and returns them as a FilterParams.
   /// 
   /// - [line]      semicolon-separated key-value list to initialize FilterParams.
   /// Returns         a newly created FilterParams.
	/// 
	/// See [StringValueMap.fromString]
	 
  static FilterParams fromString(String line) {
    var map = StringValueMap.fromString(line);
    return new FilterParams(map);
  }
}
