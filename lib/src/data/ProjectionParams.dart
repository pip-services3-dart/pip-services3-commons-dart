import 'dart:collection';
import './AnyValueArray.dart';

/// Defines projection parameters with list if fields to include into query results.
///
/// The parameters support two formats: dot format and nested format.
///
/// The dot format is the standard way to define included fields and subfields using
/// dot object notation: <code>'field1,field2.field21,field2.field22.field221'</code>.
///
/// As alternative the nested format offers a more compact representation:
/// <code>'field1,field2(field21,field22(field221))'</code>.
///
/// ### Example ###
///
///     var filter = FilterParams.fromTuples(['type', 'Type1']);
///     var paging = new PagingParams(0, 100);
///     var projection = ProjectionParams.fromString('field1,field2(field21,field22)')
///
///     myDataClient.getDataByFilter(filter, paging, projection, (err, page) {...});
///

class ProjectionParams extends ListBase<String> {
  List<String> _values;

  /// Creates a new instance of the projection parameters and assigns its value.
  ///
  /// - [value]     (optional) values to initialize this object.

  ProjectionParams([List<dynamic>? values]) : _values = <String>[] {
    if (values != null) {
      for (var value in values) {
        _values.add('' + value);
      }
    }
  }

  /// Creates a new instance from json.
  ///
  /// - [json] 		json for initialize.

  factory ProjectionParams.fromJson(Map<String, dynamic> json) {
    return ProjectionParams(json['values']);
  }

  /// Initialize this object from JSON Map object

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'values': _values};
  }

  /// Returned JSON Map object from values of this object

  void fromJson(Map<String, dynamic> json) {
    _values = <String>[];
    addAll(json['values']);
  }

  /// Gets a string representation of the object.
  /// The result is a comma-separated list of projection fields
  /// 'field1,field2.field21,field2.field22.field221'
  ///
  /// Returns a string representation of the object.

  @override
  String toString() {
    var builder = '';

    for (var index = 0; index < _values.length; index++) {
      if (index > 0) {
        builder += ',';
      }

      builder += _values[index];
    }

    return builder;
  }

  static void _parseValue(
      String? prefix, ProjectionParams result, String value) {
    value = value.trim();

    var openBracket = 0;
    var openBracketIndex = -1;
    var closeBracketIndex = -1;
    var commaIndex = -1;

    var breakCycleRequired = false;
    for (var index = 0; index < value.length; index++) {
      switch (value[index]) {
        case '(':
          if (openBracket == 0) {
            openBracketIndex = index;
          }

          openBracket++;
          break;
        case ')':
          openBracket--;

          if (openBracket == 0) {
            closeBracketIndex = index;

            if (openBracketIndex >= 0 && closeBracketIndex > 0) {
              var previousPrefix = prefix;

              if (prefix != null && prefix.isNotEmpty) {
                prefix = prefix + '.' + value.substring(0, openBracketIndex);
              } else {
                prefix = value.substring(0, openBracketIndex);
              }

              var subValue =
                  value.substring(openBracketIndex + 1, closeBracketIndex);
              ProjectionParams._parseValue(prefix, result, subValue);

              subValue = value.substring(closeBracketIndex + 1);
              ProjectionParams._parseValue(previousPrefix, result, subValue);
              breakCycleRequired = true;
            }
          }
          break;
        case ',':
          if (openBracket == 0) {
            commaIndex = index;

            var subValue = commaIndex <= value.length
                ? value.substring(0, commaIndex)
                : null;

            if (subValue != null && subValue.isNotEmpty) {
              if (prefix != null && prefix.isNotEmpty) {
                result._values.add(prefix + '.' + subValue);
              } else {
                result._values.add(subValue);
              }
            }

            subValue = commaIndex < value.length
                ? value.substring(commaIndex + 1)
                : null;

            if (subValue != null && subValue.isNotEmpty) {
              ProjectionParams._parseValue(prefix, result, subValue);
              breakCycleRequired = true;
            }
          }
          break;
      }

      if (breakCycleRequired) {
        break;
      }
    }

    if (value != null &&
        value.isNotEmpty &&
        openBracketIndex == -1 &&
        commaIndex == -1) {
      if (prefix != null && prefix.isNotEmpty) {
        result._values.add(prefix + '.' + value);
      } else {
        result._values.add(value);
      }
    }
  }

  /// Converts specified value into ProjectionParams.
  ///
  /// - value     value to be converted
  /// Returns         a newly created ProjectionParams.
  ///
  /// See [AnyValueArray.fromValue]

  static ProjectionParams fromValue(dynamic value) {
    if (!(value is List)) value = AnyValueArray.fromValue(value);

    return ProjectionParams(value);
  }

  /// Parses comma-separated list of projection fields.
  ///
  /// - values    one or more comma-separated lists of projection fields
  /// Returns         a newly created ProjectionParams.

  static ProjectionParams fromString(List<dynamic> values) {
    var result = ProjectionParams();

    for (var value in values) {
      ProjectionParams._parseValue('', result, value);
    }

    return result;
  }

  @override
  set length(int l) {
    _values.length = l;
  }

  @override
  int get length => _values.length;

  @override
  String operator [](int index) {
    return _values[index];
  }

  @override
  void operator []=(int index, String value) {
    _values[index] = value;
  }
}
