import '../convert/IntegerConverter.dart';
import '../convert/BooleanConverter.dart';
import '../convert/StringConverter.dart';

import './AnyValueMap.dart';

/// Data transfer object to pass tokenized paging parameters for queries.
/// It can be used for complex paging scenarios, like paging across multiple databases
/// where the previous state is encoded in a token. The token is usually retrieved from
/// the previous response. The initial request shall go with token == <code>null</code>
///
/// The page is defined by two parameters:
/// - the <code>token</code> token that defines a starting point for the search.
/// - the <code>take</code> parameter sets how many items to return in a page.
/// - additionally, the optional <code>total</code> parameter tells to return total number of items in the query.
///
/// Remember: not all implementations support the <code>total</code> parameter
/// because its generation may lead to severe performance implications.
///
/// ### Example ###
///
///     var filter = FilterParams.fromTuples(['type', 'Type1']);
///     var paging =  TokenizedPagingParams(0, 100);
///
///     myDataClient.getDataByFilter(filter, paging, (err, page) {...});

class TokenizedPagingParams {
  ///The start token.
  String? token;

  ///The number of items to return.
  int? take;

  ///The flag to return the total number of items.
  bool total;

  /// Creates a new instance and sets its values.
  ///
  /// - [token] 	token that defines a starting point for the search.
  /// - [take] 		the number of items to return.
  /// - [total] 	true to return the total number of items.

  TokenizedPagingParams([dynamic token, dynamic take, dynamic total])
      : total = BooleanConverter.toBooleanWithDefault(total, false) {
    this.token = StringConverter.toNullableString(token);
    this.take = IntegerConverter.toNullableInteger(take);
    // This is for correctly using PagingParams with gRPC. gRPC defaults to 0 when take is null,
    // so we have to set it back to null if we get 0 in the constructor.
    if (this.take == 0) this.take = null;
  }

  /// Creates a new instance from json.
  ///
  /// - [json] 		json for initialize.

  factory TokenizedPagingParams.fromJson(Map<String, dynamic> json) {
    return TokenizedPagingParams(json['token'], json['take'], json['total']);
  }

  /// Initialize this object from JSON Map object

  void fromJson(Map<String, dynamic> json) {
    token = json['token'];
    take = json['take'];
    total = json['total'];
  }

  /// Returned JSON Map object from values of this object

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'token': token, 'take': take, 'total': total};
  }

  /// Gets the number of items to return in a page.
  ///
  /// - [maxTake] 	the maximum number of items to return.
  /// Returns 		the number of items to return.

  int getTake(int maxTake) {
    if (take == null) return maxTake;
    if (take! < 0) return 0;
    if (take! > maxTake) return maxTake;
    return take!;
  }

  /// Converts specified value into TokenizedPagingParams.
  ///
  /// - [value]     value to be converted
  /// Returns         a newly created TokenizedPagingParams.

  static TokenizedPagingParams fromValue(dynamic value) {
    if (value is TokenizedPagingParams) return value;

    var map = AnyValueMap.fromValue(value);
    return TokenizedPagingParams.fromMap(map);
  }

  /// Creates a new TokenizedPagingParams from a list of key-value pairs called tuples.
  ///
  /// - [tuples]    a list of values where odd elements are keys and the following even elements are values
  /// Returns         a newly created TokenizedPagingParams.

  static TokenizedPagingParams fromTuples(List<dynamic> tuples) {
    var map = AnyValueMap.fromTuplesArray(tuples);
    return TokenizedPagingParams.fromMap(map);
  }

  /// Creates a new TokenizedPagingParams and sets it parameters from the specified map
  ///
  /// - [map]    	a AnyValueMap or StringValueMap to initialize this TokenizedPagingParams
  /// Returns         a newly created TokenizedPagingParams.

  static TokenizedPagingParams fromMap(dynamic map) {
    var token = map.getAsNullableString('token');
    var take = map.getAsNullableInteger('take');
    var total = map.getAsBooleanWithDefault('total', false);
    return TokenizedPagingParams(token, take, total);
  }
}
