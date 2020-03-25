// /** @module data */

// /**
//  * Defines a field name and order used to sort query results.
//  * 
//  * @see [[SortParams]]
//  * 
//  * ### Example ###
//  * 
//  *     let filter = FilterParams.fromTuples("type", "Type1");
//  *     let paging = new PagingParams(0, 100);
//  *     let sorting = new SortingParams(new SortField("create_time", true));
//  *     
//  *     myDataClient.getDataByFilter(filter, paging, sorting, (err, page) => {...});
//  */
// export class SortField {	
// 	/** The field name to sort by */
// 	public name: string;
// 	/** The flag to define sorting order. True to sort ascending, false to sort descending */
// 	public ascending: boolean;

// 	/**
// 	 * Creates a new instance and assigns its values.
// 	 * 
// 	 * @param name 			the name of the field to sort by.
// 	 * @param ascending 	true to sort in ascending order, and false to sort in descending order. 
// 	 */
// 	public constructor(name: string = null, ascending: boolean = true) {
// 		this.name = name;
// 		this.ascending = ascending;
// 	}
// }
