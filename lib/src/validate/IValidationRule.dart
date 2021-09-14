import './Schema.dart';
import './ValidationResult.dart';

/// Interface for validation rules.
///
/// Validation rule can validate one or multiple values
/// against complex rules like: value is in range,
/// one property is less than another property,
/// enforce enumerated values and more.
///
/// This interface allows to implement custom rules.

abstract class IValidationRule {
  /// Validates a given value against this rule.
  ///
  /// - [path]      a dot notation path to the value.
  /// - [schema]    a schema this rule is called from
  /// - [value]     a value to be validated.
  /// - [results]   a list with validation results to add new results.

  void validate(String? path, Schema schema, dynamic value,
      List<ValidationResult> results);
}
