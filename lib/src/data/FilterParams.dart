
import './StringValueMap.dart';

/*
 * Data transfer object used to pass filter parameters as simple key-value pairs.
 * 
 * @see [[StringValueMap]]
 * 
 * ### Example ###
 * 
 *     var filter = FilterParams.fromTuples(
 *         "type", "Type1",
 *         "from_create_time", new Date(2000, 0, 1),
 *         "to_create_time", new Date(),
 *         "compvared", true
 *     );
 *     var paging = new PagingParams(0, 100);
 *     
 *     myDataClient.getDataByFilter(filter, paging, (err, page) => {...});
 */
class FilterParams extends StringValueMap {

	/*
	 * Creates a new instance and initalizes it with elements from the specified map.
	 * 
	 * @param map 	a map to initialize this instance.
	 */
    FilterParams([map = null]) {
		//super(map);
	}
	
	/*
     * Converts specified value into FilterParams.
     * 
     * @param value     value to be converted
     * @returns         a newly created FilterParams.
	 */
	static FilterParams fromValue(value)  {
		return new FilterParams(value);
	}
		
	/*
     * Creates a new FilterParams from a list of key-value pairs called tuples.
     * 
     * @param tuples    a list of values where odd elements are keys and the following even elements are values
     * @returns         a newly created FilterParams.
	 */
	static FilterParams fromTuples(List<dynamic> tuples) { // ...tuples: any[]
		var map = StringValueMap.fromTuplesArray(tuples);
		return new FilterParams(map);
	}

	/*
     * Parses semicolon-separated key-value pairs and returns them as a FilterParams.
     * 
     * @param line      semicolon-separated key-value list to initialize FilterParams.
     * @returns         a newly created FilterParams.
	 * 
	 * @see [[StringValueMap.fromString]]
	 */
	static FilterParams fromString(String line)  {
		var map = StringValueMap.fromString(line);
		return new FilterParams(map);
	}
}
