import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';
import './ObjectComparator.dart';
import './ValidationResultType.dart';

/**
 * Validation rule that compares value to a constant.
 * 
 * See [IValidationRule]
 * 
 * ### Example ###
 * 
 *     var schema = new Schema()
 *         .withRule(new ValueComparisonRule("EQ", 1));
 *     
 *     schema.validate(1);          // Result: no errors
 *     schema.validate(2);          // Result: 2 is not equal to 1
 */
class ValueComparisonRule implements IValidationRule {
  final dynamic _value;
  final String _operation;

  /**
     * Creates a new validation rule and sets its values.
     * 
     * - [operation]    a comparison operation: "==" ("=", "EQ"), "!= " ("<>", "NE"); "<"/">" ("LT"/"GT"), "<="/">=" ("LE"/"GE"); "LIKE".
     * - [value]        a constant value to compare to
     */
  ValueComparisonRule(String operation, dynamic value)
      : this._operation = operation,
        this._value = value {}

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

    if (!ObjectComparator.compare(value, this._operation, this._value)) {
      results.add(new ValidationResult(
          path,
          ValidationResultType.Error,
          "BAD_VALUE",
          name +
              " must " +
              this._operation.toString() +
              " " +
              this._value.toString() +
              " but found " +
              value.toString(),
          this._operation.toString() + " " + this._value.toString(),
          value));
    }
  }
}
