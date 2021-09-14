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
///     var schema =  Schema()
///         .withRule( NotRule(
///              ValueComparisonRule('EQ', 1)
///         ));
///
///     schema.validate(1);          // Result: error
///     schema.validate(5);          // Result: no error

class NotRule implements IValidationRule {
  final IValidationRule? _rule;

  /// Creates a new validation rule and sets its values
  ///
  /// - [rule]     a rule to be negated.

  NotRule(IValidationRule? rule) : _rule = rule;

  /// Validates a given value against this rule.
  ///
  /// - [path]      a dot notation path to the value.
  /// - [schema]    a schema this rule is called from
  /// - [value]     a value to be validated.
  /// - [results]   a list with validation results to add new results.

  @override
  void validate(String? path, Schema schema, dynamic value,
      List<ValidationResult> results) {
    if (_rule == null) return;

    var name = path ?? 'value';
    var localResults = <ValidationResult>[];

    _rule!.validate(path, schema, value, localResults);

    if (localResults.isNotEmpty) return;

    results.add(ValidationResult(path, ValidationResultType.Error, 'NOT_FAILED',
        'Negative check for ' + name + ' failed', null, null));
  }
}
