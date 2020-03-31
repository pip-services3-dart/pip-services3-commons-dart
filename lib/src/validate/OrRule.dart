import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';

/**
/// Validation rule to combine rules with OR logical operation.
/// When one of rules returns no errors, than this rule also returns no errors.
/// When all rules return errors, than the rule returns all errors.
/// 
/// See [IValidationRule]
/// 
/// ### Example ###
/// 
///     var schema = new Schema()
///         .withRule(new OrRule(
///             new ValueComparisonRule("LT", 1),
///             new ValueComparisonRule("GT", 10)
///         ));
///     
///     schema.validate(0);          // Result: no error
///     schema.validate(5);          // Result: 5 must be less than 1 or 5 must be more than 10
///     schema.validate(20);         // Result: no error
 */
class OrRule implements IValidationRule {
  final List<IValidationRule> _rules;

  /**
    /// Creates a new validation rule and sets its values.
    /// 
    /// - [rules]     a list of rules to join with OR operator
     */
  OrRule(List<IValidationRule> rules) : this._rules = rules {}

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
    if (this._rules == null || this._rules.length == 0) return;

    var localResults = List<ValidationResult>();

    for (var i = 0; i < this._rules.length; i++) {
      var resultCount = localResults.length;

      this._rules[i].validate(path, schema, value, localResults);

      if (resultCount == localResults.length) return;
    }
    results.addAll(localResults);
  }
}
