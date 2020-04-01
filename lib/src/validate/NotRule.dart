import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';


/// Validation rule negate another rule.
/// When embedded rule returns no errors, than this rule return an error.
/// When embedded rule return errors, than the rule returns no errors.
/// 
/// See [IValidationRule]
/// 
/// ### Example ###
/// 
///     var schema = new Schema()
///         .withRule(new NotRule(
///             new ValueComparisonRule("EQ", 1)
///         ));
///     
///     schema.validate(1);          // Result: error
///     schema.validate(5);          // Result: no error
 
class NotRule implements IValidationRule {
  final IValidationRule _rule;

  
    /// Creates a new validation rule and sets its values
    /// 
    /// - [rule]     a rule to be negated.
     
  NotRule(IValidationRule rule) : this._rule = rule {}

  
    /// Validates a given value against this rule.
    /// 
    /// - [path]      a dot notation path to the value.
    /// - [schema]    a schema this rule is called from
    /// - [value]     a value to be validated.
    /// - [results]   a list with validation results to add new results.
     
  void validate(String path, Schema schema, dynamic value,
      List<ValidationResult> results) {
    if (this._rule == null) return;

    var name = path != null ? path : "value";
    var localResults = List<ValidationResult>();

    this._rule.validate(path, schema, value, localResults);

    if (localResults.length > 0) return;

    results.add(new ValidationResult(path, ValidationResultType.Error,
        "NOT_FAILED", "Negative check for " + name + " failed", null, null));
  }
}
