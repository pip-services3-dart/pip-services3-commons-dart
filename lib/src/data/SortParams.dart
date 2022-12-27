import './SortField.dart';
import 'dart:collection';

/// Defines a field name and order used to sort query results.
///
/// See [SortField]
///
/// ### Example ###
///
///     var filter = FilterParams.fromTuples(['type', 'Type1']);
///     var paging =  PagingParams(0, 100);
///     var sorting =  SortingParams( SortField('create_time', true));
///
///     myDataClient.getDataByFilter(filter, paging, sorting, (err, page) {...});

class SortParams extends ListBase<SortField> {
  List<SortField> _values;

  /// Creates a new instance and initializes it with specified sort fields.
  ///
  /// - [fields]    a list of fields to sort by.

  SortParams(List<SortField>? fields) : _values = <SortField>[] {
    if (fields != null) {
      for (var index = 0; index < fields.length; index++) {
        _values.add(fields[index]);
      }
    }
  }

  /// Creates a new instance from json.
  ///
  /// - [json] 		json for initialize.

  factory SortParams.fromJson(Map<String, dynamic> json) {
    return SortParams(json['values']);
  }

  /// Initialize this object from JSON Map object

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'values': _values};
  }

  /// Returned JSON Map object from values of this object

  void fromJson(Map<String, dynamic> json) {
    _values = <SortField>[];
    _values.addAll(json['values']);
  }

  @override
  void add(SortField element) {
    _values.add(element);
  }

  // Todo: add fromTuples factory method.
  @override
  set length(int l) {
    _values.length = l;
  }

  @override
  int get length => _values.length;

  @override
  SortField operator [](int index) {
    return _values[index];
  }

  @override
  void operator []=(int index, SortField item) {
    _values[index] = item;
  }
}
