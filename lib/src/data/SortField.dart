/*
 * Defines a field name and order used to sort query results.
 * 
 * @see [[SortParams]]
 * 
 * ### Example ###
 * 
 *     let filter = FilterParams.fromTuples("type", "Type1");
 *     let paging = new PagingParams(0, 100);
 *     let sorting = new SortingParams(new SortField("create_time", true));
 *     
 *     myDataClient.getDataByFilter(filter, paging, sorting, (err, page) => {...});
 */
class SortField {	
	/* The field name to sort by */
	String name;
	/* The flag to define sorting order. True to sort ascending, false to sort descending */
	bool ascending;

	/*
	 * Creates a new instance and assigns its values.
	 * 
	 * @param name 			the name of the field to sort by.
	 * @param ascending 	true to sort in ascending order, and false to sort in descending order. 
	 */
	SortField([String name= null, bool ascending = true]) {
		this.name = name;
		this.ascending = ascending;
	}
}
