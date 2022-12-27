/// Data transfer object that is used to pass results of paginated queries.
/// It contains items of retrieved page and optional total number of items.
///
/// Most often this object type is used to send responses to paginated queries.
/// Pagination parameters are defined by [[TokenizedPagingParams]] object.
/// The <code>token</code> parameter in the TokenizedPagingParams there means where to start the searxh.
/// The <code>takes</code> parameter sets number of items to return in the page.
/// And the optional <code>total</code> parameter tells to return total number of items in the query.
///
/// The data page returns a token that shall be passed to the next search as a starting point.
///
/// Remember: not all implementations support the <code>total</code> parameter
/// because its generation may lead to severe performance implications.
///
/// See [PagingParams]
///
/// ### Example ###
///
/// page = myDataClient.getDataByFilter(
///   '123',
///   FilterParams.fromTuples('completed': true),
///   TokenizedPagingParams(0, 100, true)
/// );

/// for (item in page.Data) {
///       print(item);
///  }

class TokenizedDataPage<T> {
  /// The items of the retrieved page.
  List<T> data;

  /// The starting point for the next search.
  String? token;

  /// The total amount of items in a request.
  int? total;

  /// Creates a new instance of data page and assigns its values.
  ///
  /// - [data]      a list of items from the retrieved page.
  /// - [token]     (optional) a token to define astarting point for the next search.
  /// - [total]     (optional) a total number of objects in the result.

  TokenizedDataPage(List<T> data, [String? token, int? total]) : data = data {
    this.total = total;
    this.token = token;
  }

  /// Creates a new instance of data page and assigns its values.
  ///
  /// - [json]    json values to initialize this object.
  /// - [fromJson]  convert function for convert from json into <T>

  factory TokenizedDataPage.fromJson(
      Map<String, dynamic> json, Function fromJson) {
    //final items = json['data'].cast<Map<String, dynamic>>();
    final items = json['data'];

    return TokenizedDataPage<T>(
        List<T>.from(items.map((itemsJson) => fromJson(itemsJson))),
        json['token'],
        json['total']);
  }

  /// Returned JSON Map object from values of this object

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'total': total, 'data': data, 'token': token};
}
