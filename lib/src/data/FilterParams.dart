// /** @module data */
// import { StringValueMap } from './StringValueMap';

// /**
//  * Data transfer object used to pass filter parameters as simple key-value pairs.
//  * 
//  * @see [[StringValueMap]]
//  * 
//  * ### Example ###
//  * 
//  *     let filter = FilterParams.fromTuples(
//  *         "type", "Type1",
//  *         "from_create_time", new Date(2000, 0, 1),
//  *         "to_create_time", new Date(),
//  *         "completed", true
//  *     );
//  *     let paging = new PagingParams(0, 100);
//  *     
//  *     myDataClient.getDataByFilter(filter, paging, (err, page) => {...});
//  */
// export class FilterParams extends StringValueMap {

// 	/**
// 	 * Creates a new instance and initalizes it with elements from the specified map.
// 	 * 
// 	 * @param map 	a map to initialize this instance.
// 	 */
//     public constructor(map: any = null) {
// 		super(map);
// 	}
	
// 	/**
//      * Converts specified value into FilterParams.
//      * 
//      * @param value     value to be converted
//      * @returns         a newly created FilterParams.
// 	 */
// 	public static fromValue(value: any): FilterParams {
// 		return new FilterParams(value);
// 	}
		
// 	/**
//      * Creates a new FilterParams from a list of key-value pairs called tuples.
//      * 
//      * @param tuples    a list of values where odd elements are keys and the following even elements are values
//      * @returns         a newly created FilterParams.
// 	 */
// 	public static fromTuples(...tuples: any[]): FilterParams {
// 		let map = StringValueMap.fromTuplesArray(tuples);
// 		return new FilterParams(map);
// 	}

// 	/**
//      * Parses semicolon-separated key-value pairs and returns them as a FilterParams.
//      * 
//      * @param line      semicolon-separated key-value list to initialize FilterParams.
//      * @returns         a newly created FilterParams.
// 	 * 
// 	 * @see [[StringValueMap.fromString]]
// 	 */
// 	public static fromString(line: string): FilterParams {
// 		let map = StringValueMap.fromString(line);
// 		return new FilterParams(map);
// 	}
// }
