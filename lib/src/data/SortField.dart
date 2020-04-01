
/// Defines a field name and order used to sort query results.
/// 
/// See [SortParams]
/// 
/// ### Example ###
/// 
///     var filter = FilterParams.fromTuples(['type', 'Type1']);
///     var paging =  PagingParams(0, 100);
///     var sorting =  SortingParams( SortField('create_time', true));
///     
///     myDataClient.getDataByFilter(filter, paging, sorting, (err, page) {...});
 
class SortField {
  ///The field name to sort by 
  String name;
  ///The flag to define sorting order. True to sort ascending, false to sort descending 
  bool ascending;

  
	/// Creates a new instance and assigns its values.
	/// 
	/// - [name] 			the name of the field to sort by.
	/// - [ascending] 	true to sort in ascending order, and false to sort in descending order. 
	 
  SortField([String name = null, bool ascending = true]) {
    this.name = name;
    this.ascending = ascending;
  }

  
	/// Creates a new instance from json.
	/// 
	/// - [json] 		json for initialize.
   
  factory SortField.fromJson(Map<String, dynamic> json) {
    return  SortField(json['name'], json['ascending']);
  }

  
  /// Initialize this object from JSON Map object
   
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': this.name, 'ascending': this.ascending};
  }

  
  /// Returned JSON Map object from values of this object
   
  void fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.ascending = json['ascending'];
  }
}
