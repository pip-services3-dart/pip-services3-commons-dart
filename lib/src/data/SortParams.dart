// /** @module data */
// import { SortField } from './SortField';

// /**
//  * Defines a field name and order used to sort query results.
//  * 
//  * @see [[SortField]]
//  * 
//  * ### Example ###
//  * 
//  *     let filter = FilterParams.fromTuples("type", "Type1");
//  *     let paging = new PagingParams(0, 100);
//  *     let sorting = new SortingParams(new SortField("create_time", true));
//  *     
//  *     myDataClient.getDataByFilter(filter, paging, sorting, (err, page) => {...});
//  */
// export class SortParams extends Array<SortField> {
// 	/**
// 	 * Creates a new instance and initializes it with specified sort fields.
// 	 * 
//      * @param fields    a list of fields to sort by.
//      */
// 	public constructor(...fields: SortField[]) {
//         super();

//         // Set the prototype explicitly.
//         // https://github.com/Microsoft/TypeScript-wiki/blob/master/Breaking-Changes.md#extending-built-ins-like-error-array-and-map-may-no-longer-work
//         (<any>this).__proto__ = SortParams.prototype;

// 		if (fields != null) {
// 			for (let index = 0; index < fields.length; index++)
// 				this.push(fields[index]);
// 		}
// 	}
	
// 	// Todo: add fromTuples factory method.

// }
