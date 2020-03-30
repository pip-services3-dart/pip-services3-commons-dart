import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';
import './ObjectComparator.dart';
import './ValidationResultType.dart';
import '../reflect/ObjectReader.dart';

/**
 * Validation rule that compares two object properties.
 * 
 * See [IValidationRule]
 * 
 * ### Example ###
 * 
 *     var schema = new ObjectSchema()
 *         .withRule(new PropertyComparisonRule("field1", "NE", "field2"));
 *     
 *     schema.validate({ field1: 1, field2: 2 });       // Result: no errors
 *     schema.validate({ field1: 1, field2: 1 });       // Result: field1 shall not be equal to field2
 *     schema.validate({});                             // Result: no errors
 */
class PropertiesComparisonRule implements IValidationRule {
  final String _property1;
  final String _property2;
  final String _operation;

  /**
     * Creates a new validation rule and sets its arguments.
     * 
     * - [property1]    a name of the first property to compare.
     * - [operation]    a comparison operation: "==" ("=", "EQ"), "!= " ("<>", "NE"); "<"/">" ("LT"/"GT"), "<="/">=" ("LE"/"GE"); "LIKE".
     * - [property2]    a name of the second property to compare.
     * 
     * See [ObjectComparator.compare]
     */
  PropertiesComparisonRule(String property1, String operation, String property2)
      : this._property1 = property1,
        this._property2 = property2,
        this._operation = operation {}

  /**
     * Validates a given value against this rule.
     * 
     * - [path]      a dot notation path to the value.
     * - [schema]    a schema this rule is called from
     * - [value]     a value to be validated.
     * - [results]   a list with validation results to add new results.
     */
  void validate(String path, Schema schema, dynamic value,
      List<ValidationResult> results) {
    var name = path != null ? path : "value";
    var value1 = ObjectReader.getProperty(value, this._property1);
    var value2 = ObjectReader.getProperty(value, this._property2);

    if (!ObjectComparator.compare(value1, this._operation, value2)) {
      results.add(new ValidationResult(
          path,
          ValidationResultType.Error,
          "PROPERTIES_NOT_MATCH",
          name +
              " must have " +
              this._property1.toString() +
              " " +
              this._operation.toString() +
              " " +
              this._property2.toString(),
          value2,
          value1));
    }
  }
}
