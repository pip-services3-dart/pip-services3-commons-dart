import '../convert/IntegerConverter.dart';
import '../convert/BooleanConverter.dart';

import './AnyValueMap.dart';


/// Data transfer object to pass paging parameters for queries.
/// 
/// The page is defined by two parameters:
/// - the <code>skip</code> parameter defines number of items to skip.
/// - the <code>take</code> parameter sets how many items to return in a page.
/// - additionally, the optional <code>total</code> parameter tells to return total number of items in the query.
/// 
/// Remember: not all implementations support the <code>total</code> parameter
/// because its generation may lead to severe performance implications.
/// 
/// ### Example ###
/// 
///     var filter = FilterParams.fromTuples(['type', 'Type1']);
///     var paging = new PagingParams(0, 100);
///     
///     myDataClient.getDataByFilter(filter, paging, (err, page) {...});
 
class PagingParams {
  ///The number of items to skip. 
  int skip;
  ///The number of items to return.  
  int take;
  ///The flag to return the total number of items. 
  bool total;

  
	/// Creates a new instance and sets its values.
	/// 
	/// - [skip] 		the number of items to skip.
	/// - [take] 		the number of items to return. 
	/// - [total] 	true to return the total number of items.
	 
  PagingParams(
      [dynamic skip = null, dynamic take = null, dynamic total = null]) {
    this.skip = IntegerConverter.toNullableInteger(skip);
    this.take = IntegerConverter.toNullableInteger(take);
    this.total = BooleanConverter.toBooleanWithDefault(total, false);
    // This is for correctly using PagingParams with gRPC. gRPC defaults to 0 when take is null,
    // so we have to set it back to null if we get 0 in the constructor.
    if (this.take == 0) this.take = null;
  }

  
	/// Creates a new instance from json.
	/// 
	/// - [json] 		json for initialize.
   
  factory PagingParams.fromJson(Map<String, dynamic> json) {
    return PagingParams(json['skip'], json['take'], json['total']);
  }

  
  /// Initialize this object from JSON Map object
   
  void fromJson(Map<String, dynamic> json) {
    this.skip = json['skip'];
    this.take = json['take'];
    this.total = json['total'];
  }

  
  /// Returned JSON Map object from values of this object
   
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'skip': this.skip,
      'take': this.take,
      'total': this.total
    };
  }

  
	/// Gets the number of items to skip.
	/// 
	/// - [minSkip] 	the minimum number of items to skip.
	/// Returns 		the number of items to skip.
	 
  int getSkip(int minSkip) {
    if (this.skip == null) return minSkip;
    if (this.skip < minSkip) return minSkip;
    return this.skip;
  }

  
	/// Gets the number of items to return in a page.
	/// 
	/// - [maxTake] 	the maximum number of items to return.
	/// Returns 		the number of items to return.
	 
  int getTake(int maxTake) {
    if (this.take == null) return maxTake;
    if (this.take < 0) return 0;
    if (this.take > maxTake) return maxTake;
    return this.take;
  }

  
    /// Converts specified value into PagingParams.
    /// 
    /// - [value]     value to be converted
    /// Returns         a newly created PagingParams.
	 
  static PagingParams fromValue(dynamic value) {
    if (value is PagingParams) return value;

    var map = AnyValueMap.fromValue(value);
    return PagingParams.fromMap(map);
  }

  
    /// Creates a new PagingParams from a list of key-value pairs called tuples.
    /// 
    /// - [tuples]    a list of values where odd elements are keys and the following even elements are values
    /// Returns         a newly created PagingParams.
	 
  static PagingParams fromTuples(List<dynamic> tuples) {
    var map = AnyValueMap.fromTuplesArray(tuples);
    return PagingParams.fromMap(map);
  }

  
    /// Creates a new PagingParams and sets it parameters from the specified map
    /// 
    /// - [map]    	a AnyValueMap or StringValueMap to initialize this PagingParams
    /// Returns         a newly created PagingParams.
	 
  static PagingParams fromMap(dynamic map) {
    var skip = map.getAsNullableInteger('skip');
    var take = map.getAsNullableInteger('take');
    var total = map.getAsBooleanWithDefault('total', false);
    return new PagingParams(skip, take, total);
  }
}
