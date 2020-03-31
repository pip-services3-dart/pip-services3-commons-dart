import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';
import './ObjectComparator.dart';

/**
/// Validation rule to check that value is included into the list of constants.
/// 
/// See [IValidationRule]
/// 
/// ### Example ###
/// 
///     var schema = new Schema()
///         .withRule(new IncludedRule(1, 2, 3));
///     
///     schema.validate(2);      // Result: no errors
///     schema.validate(10);     // Result: 10 must be one of 1, 2, 3
 */
class IncludedRule implements IValidationRule {
  final List<dynamic> _values;

  /**
    /// Creates a new validation rule and sets its values.
    /// 
    /// - [values]    a list of constants that value must be included to
     */
  IncludedRule(List<dynamic> values) : this._values = values {}

  /**
    /// Validates a given value against this rule.
    /// 
    /// - [path]      a dot notation path to the value.
    /// - [schema]    a schema this rule is called from
    /// - [value]     a value to be validated.
    /// - [results]   a list with validation results to add new results.
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

    if (!found) {
      results.add(new ValidationResult(
          path,
          ValidationResultType.Error,
          "VALUE_NOT_INCLUDED",
          name + " must be one of " + this._values.join(","),
          this._values,
          null));
    }
  }
}
