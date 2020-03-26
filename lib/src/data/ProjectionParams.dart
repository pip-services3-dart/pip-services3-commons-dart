import 'dart:collection';
import "./AnyValueArray.dart";

/*
 * Defines projection parameters with list if fields to include into query results.
 * 
 * The parameters support two formats: dot format and nested format.
 * 
 * The dot format is the standard way to define included fields and subfields using
 * dot object notation: <code>"field1,field2.field21,field2.field22.field221"</code>.
 * 
 * As alternative the nested format offers a more compact representation:
 * <code>"field1,field2(field21,field22(field221))"</code>.
 * 
 * ### Example ###
 * 
 *     var filter = FilterParams.fromTuples("type", "Type1");
 *     var paging = new PagingParams(0, 100);
 *     var projection = ProjectionParams.fromString("field1,field2(field21,field22)")
 *     
 *     myDataClient.getDataByFilter(filter, paging, projection, (err, page) => {...});
 * 
 */
class ProjectionParams extends ListBase<String> {
  List<String> _values;
  /*
     * Creates a new instance of the projection parameters and assigns its value.
     * 
     * @param value     (optional) values to initialize this object.
     */
  ProjectionParams([List<dynamic> values = null])
      : this._values = new List<String>() {
    if (values != null) {
      for (var value in values) this._values.add("" + value);
    }
  }

  factory ProjectionParams.fromJson(Map<String, dynamic> json) {
    return new ProjectionParams(json["values"]);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"values": this._values};
  }

  void fromJson(Map<String, dynamic> json) {
    this._values = null;
    addAll(json["values"]);
  }

  /*
     * Gets a string representation of the object.
     * The result is a comma-separated list of projection fields
     * "field1,field2.field21,field2.field22.field221"
     * 
     * @returns a string representation of the object.
     */
  String toString() {
    var builder = "";

    for (var index = 0; index < this._values.length; index++) {
      if (index > 0) {
        builder += ',';
      }

      builder += this._values[index];
    }

    return builder;
  }

  static void _parseValue(
      String prefix, ProjectionParams result, String value) {
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

              if (prefix != null && prefix.length > 0) {
                prefix = prefix + "." + value.substring(0, openBracketIndex);
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

            var subValue = value.substring(0, commaIndex);

            if (subValue != null && subValue.length > 0) {
              if (prefix != null && prefix.length > 0) {
                result._values.add(prefix + "." + subValue);
              } else {
                result._values.add(subValue);
              }
            }

            subValue = value.substring(commaIndex + 1);

            if (subValue != null && subValue.length > 0) {
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
        value.length > 0 &&
        openBracketIndex == -1 &&
        commaIndex == -1) {
      if (prefix != null && prefix.length > 0) {
        result._values.add(prefix + "." + value);
      } else {
        result._values.add(value);
      }
    }
  }

  /*
     * Converts specified value into ProjectionParams.
     * 
     * @param value     value to be converted
     * @returns         a newly created ProjectionParams.
     * 
     * @see [[AnyValueArray.fromValue]]
     */
  static ProjectionParams fromValue(dynamic value) {
    if (!(value is List)) value = AnyValueArray.fromValue(value);

    return new ProjectionParams(value);
  }

  /*
     * Parses comma-separated list of projection fields.
     * 
     * @param values    one or more comma-separated lists of projection fields
     * @returns         a newly created ProjectionParams.
     */
  static fromString(List<dynamic> values) {
    //...values: string[]
    var result = new ProjectionParams();

    for (var value in values) {
      ProjectionParams._parseValue("", result, value);
    }

    return result;
  }

  @override
  void set length(int l) {
    this._values.length = l;
  }

  @override
  int get length => this._values.length;

  @override
  String operator [](int index) {
    // TODO: implement []
    return this._values[index];
  }

  @override
  void operator []=(int index, String value) {
    this._values[index] = value;
  }
}
