import './SortField.dart';
import 'dart:collection';

/**
 * Defines a field name and order used to sort query results.
 * 
 * @see [[SortField]]
 * 
 * ### Example ###
 * 
 *     let filter = FilterParams.fromTuples("type", "Type1");
 *     let paging = new PagingParams(0, 100);
 *     let sorting = new SortingParams(new SortField("create_time", true));
 *     
 *     myDataClient.getDataByFilter(filter, paging, sorting, (err, page) => {...});
 */
class SortParams extends ListBase<SortField> {
  List<SortField> _values;

  /**
	 * Creates a new instance and initializes it with specified sort fields.
	 * 
   * @param fields    a list of fields to sort by.
   */
  SortParams(List<SortField> fields) : this._values = new List<SortField>() {
    if (fields != null) {
      for (var index = 0; index < fields.length; index++)
        this.add(fields[index]);
    }
  }

  factory SortParams.fromJson(Map<String, dynamic> json) {
    return new SortParams(json["values"]);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"values": this._values};
  }

  void fromJson(Map<String, dynamic> json) {
    this._values = null;
    addAll(json["values"]);
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
