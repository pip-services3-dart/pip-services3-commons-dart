import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';
import '../reflect/ObjectReader.dart';

/**
 * Validation rule that check that at exactly one of the object properties is not null.
 * 
 * See [[IValidationRule]]
 * 
 * ### Example ###
 * 
 *     let schema = new Schema()
 *         .withRule(new OnlyOneExistsRule("field1", "field2"));
 *     
 *     schema.validate({ field1: 1, field2: "A" });     // Result: only one of properties field1, field2 must exist
 *     schema.validate({ field1: 1 });                  // Result: no errors
 *     schema.validate({ });                            // Result: only one of properties field1, field2 must exist
 */
class OnlyOneExistsRule implements IValidationRule {
  final List<String> _properties;

  /**
     * Creates a new validation rule and sets its values
     * 
     * - properties    a list of property names where at only one property must exist
     */
  OnlyOneExistsRule(List<String> properties) : this._properties = properties {}

  /**
     * Validates a given value against this rule.
     * 
     * - path      a dot notation path to the value.
     * - schema    a schema this rule is called from
     * - value     a value to be validated.
     * - results   a list with validation results to add new results.
     */
  void validate(String path, Schema schema, dynamic value,
      List<ValidationResult> results) {
    var name = path != null ? path : "value";
    var found = List<String>();

    for (var i = 0; i < this._properties.length; i++) {
      var property = this._properties[i];

      var propertyValue = ObjectReader.getProperty(value, property);

      if (propertyValue != null) found.add(property);
    }

    if (found.length == 0) {
      results.add(new ValidationResult(
          path,
          ValidationResultType.Error,
          "VALUE_NULL",
          name +
              " must have at least one property from " +
              this._properties.join(","),
          this._properties,
          null));
    } else if (found.length > 1) {
      results.add(new ValidationResult(
          path,
          ValidationResultType.Error,
          "VALUE_ONLY_ONE",
          name +
              " must have only one property from " +
              this._properties.join(","),
          this._properties,
          null));
    }
  }
}
