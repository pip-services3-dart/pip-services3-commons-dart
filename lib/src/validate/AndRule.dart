import './IValidationRule.dart';
import './Schema.dart';
import './ValidationResult.dart';

/// Validation rule to combine rules with AND logical operation.
/// When all rules returns no errors, than this rule also returns no errors.
/// When one of the rules return errors, than the rules returns all errors.
///
/// See [IValidationRule]
///
/// ### Example ###
///
///     var schema =  Schema()
///         .withRule( AndRule(
///              ValueComparisonRule('GTE', 1),
///              ValueComparisonRule('LTE', 10)
///         ));
///
///     schema.validate(0);          // Result: 0 must be greater or equal to 1
///     schema.validate(5);          // Result: no error
///     schema.validate(20);         // Result: 20 must be letter or equal 10

class AndRule implements IValidationRule {
  final List<IValidationRule> _rules;

  /// Creates a new validation rule and sets its values.
  ///
  /// - [rules]     a list of rules to join with AND operator

  AndRule(List<IValidationRule> rules) : _rules = rules {}

  /// Validates a given value against this rule.
  ///
  /// - [path]      a dot notation path to the value.
  /// - [schema]    a schema this rule is called from
  /// - [value]     a value to be validated.
  /// - [results]   a list with validation results to add new results.

  void validate(String path, Schema schema, dynamic value,
      List<ValidationResult> results) {
    if (_rules == null) return;

    for (var i = 0; i < _rules.length; i++) {
      var rule = _rules[i];
      rule.validate(path, schema, value, results);
    }
  }
}
