import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';
import './ObjectComparator.dart';

/**
 * Validation rule to check that value is excluded from the list of constants.
 * 
 * See [IValidationRule]
 * 
 * ### Example ###
 * 
 *     var schema = new Schema()
 *         .withRule(new ExcludedRule(1, 2, 3));
 *     
 *     schema.validate(2);      // Result: 2 must not be one of 1, 2, 3
 *     schema.validate(10);     // Result: no errors
 */
class ExcludedRule implements IValidationRule {
  final List<dynamic> _values;

  /**
     * Creates a new validation rule and sets its values.
     * 
     * - [values]    a list of constants that value must be excluded from
     */
  ExcludedRule(List<dynamic> values) : this._values = values {}

  /**
     * Validates the given value. None of the values set in this ExcludedRule object must exist 
     * in the value that is given for validation to pass.
     * 
     * - [path]      the dot notation path to the value that is to be validated.
     * - [schema]    (not used in this implementation).
     * - [value]     the value that is to be validated.
     * - [results]   the results of the validation.
     */
  void validate(String path, Schema schema, dynamic value,
      List<ValidationResult> results) {
    if (this._values == null) return;

    var name = path != null ? path : "value";
    var found = false;

    for (var i = 0; i < this._values.length && !found; i++) {
      var thisValue = this._values[i];

      if (ObjectComparator.compare(value, 'EQ', thisValue)) {
        found = true;
        break;
      }
    }

    if (found) {
      results.add(new ValidationResult(
          path,
          ValidationResultType.Error,
          "VALUE_INCLUDED",
          name + " must not be one of " + this._values.join(","),
          this._values,
          null));
    }
  }
}
