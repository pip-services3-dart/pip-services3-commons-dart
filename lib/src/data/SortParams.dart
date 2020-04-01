import './SortField.dart';
import 'dart:collection';


/// Defines a field name and order used to sort query results.
/// 
/// See [SortField]
/// 
/// ### Example ###
/// 
///     var filter = FilterParams.fromTuples(['type', 'Type1']);
///     var paging = new PagingParams(0, 100);
///     var sorting = new SortingParams(new SortField('create_time', true));
///     
///     myDataClient.getDataByFilter(filter, paging, sorting, (err, page) {...});
 
class SortParams extends ListBase<SortField> {
  List<SortField> _values;

  
	/// Creates a new instance and initializes it with specified sort fields.
	/// 
  /// - [fields]    a list of fields to sort by.
   
  SortParams(List<SortField> fields) : this._values = new List<SortField>() {
    if (fields != null) {
      for (var index = 0; index < fields.length; index++)
        this.add(fields[index]);
    }
  }

  
	/// Creates a new instance from json.
	/// 
	/// - [json] 		json for initialize.
   
  factory SortParams.fromJson(Map<String, dynamic> json) {
    return new SortParams(json['values']);
  }

  
  /// Initialize this object from JSON Map object
   
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'values': this._values};
  }

  
  /// Returned JSON Map object from values of this object
   
  void fromJson(Map<String, dynamic> json) {
    this._values = null;
    addAll(json['values']);
  }

  // Todo: add fromTuples factory method.
  @override
  void set length(int l) {
    this._values.length = l;
  }

  @override
  int get length => _values.length;

  SortField operator [](int index) {
    return this._values[index];
  }

  void operator []=(int index, SortField item) {
    this._values[index] = item;
  }
}
