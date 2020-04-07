import './IValidationRule.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';
import './ValidationException.dart';
import '../reflect/ObjectReader.dart';
import '../reflect/TypeMatcher.dart';
import '../convert/TypeCode.dart';
import '../convert/TypeConverter.dart';

/// Basic schema that validates values against a set of validation rules.
///
/// This schema is used as a basis for specific schemas to validate
/// objects, project properties, arrays and maps.
///
/// See [ObjectSchema]
/// See [PropertySchema]
/// See [ArraySchema]
/// See [MapSchema]

class Schema {
  bool _required;
  List<IValidationRule> _rules;

  /// Creates a new instance of validation schema and sets its values.
  ///
  /// - [required]  (optional) true to always require non-null values.
  /// - [rules]     (optional) a list with validation rules.
  ///
  /// See [IValidationRule]

  Schema([bool req, List<IValidationRule> rules]) {
    _required = req;
    _required = _required ?? false;
    _rules = rules;
  }

  /// Gets a flag that always requires non-null values.
  /// For null values it raises a validation error.
  ///
  /// Returns true to always require non-null values and false to allow null values.

  bool isRequired() {
    return _required;
  }

  /// Sets a flag that always requires non-null values.
  ///
  /// - [value] true to always require non-null values and false to allow null values.

  void setRequired(bool value) {
    _required = value;
  }

  /// Gets validation rules to check values against.
  ///
  /// Returns a list with validation rules.

  List<IValidationRule> getRules() {
    return _rules;
  }

  /// Sets validation rules to check values against.
  ///
  /// - [value] a list with validation rules.

  void setRules(List<IValidationRule> value) {
    _rules = value;
  }

  /// Makes validated values always required (non-null).
  /// For null values the schema will raise errors.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// Returns this validation schema
  ///
  /// See [makeOptional]

  Schema makeRequired() {
    _required = true;
    return this;
  }

  /// Makes validated values optional.
  /// Validation for null values will be skipped.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// Returns this validation schema
  ///
  /// See [makeRequired]

  Schema makeOptional() {
    _required = false;
    return this;
  }

  /// Adds validation rule to this schema.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [rule]  a validation rule to be added.
  /// Returns this validation schema.

  Schema withRule(IValidationRule rule) {
    _rules ??= <IValidationRule>[];
    _rules.add(rule);
    return this;
  }

  /// Validates a given value against the schema and configured validation rules.
  ///
  /// - [path]      a dot notation path to the value.
  /// - [value]     a value to be validated.
  /// - [results]   a list with validation results to add new results.

  void performValidation(
      String path, dynamic value, List<ValidationResult> results) {
    var name = path ?? 'value';

    if (value == null) {
      if (isRequired()) {
        results.add(ValidationResult(path, ValidationResultType.Error,
            'VALUE_IS_NULL', name + ' must not be null', 'NOT NULL', null));
      }
    } else {
      value = ObjectReader.getValue(value);

      // Check validation rules
      if (_rules != null) {
        for (var i = 0; i < _rules.length; i++) {
          var rule = _rules[i];
          rule.validate(path, this, value, results);
        }
      }
    }
  }

  String _typeToString(dynamic type) {
    if (type == null) return 'unknown';
    if (type is num) return TypeConverter.asString(type as TypeCode);
    return type.toString();
  }

  /// Validates a given value to match specified type.
  /// The type can be defined as a Schema, type, a type name or [TypeCode]
  /// When type is a Schema, it executes validation recursively against that Schema.
  ///
  /// - [path]      a dot notation path to the value.
  /// - [type]      a type to match the value type
  /// - [value]     a value to be validated.
  /// - [results]   a list with validation results to add new results.
  ///
  /// See [performValidation]

  void performTypeValidation(String path, dynamic type, dynamic value,
      List<ValidationResult> results) {
    // If type it not defined then skip
    if (type == null) return;

    // Perform validation against the schema
    if (type is Schema) {
      var schema = type as Schema;
      schema.performValidation(path, value, results);
      return;
    }

    // If value is null then skip
    value = ObjectReader.getValue(value);
    if (value == null) return;

    var name = path ?? 'value';
    var valueType = TypeConverter.toTypeCode(value);

    // Match types
    if (TypeMatcher.matchType(type, valueType, value)) return;

    results.add(ValidationResult(
        path,
        ValidationResultType.Error,
        'TYPE_MISMATCH',
        name +
            ' type must be ' +
            _typeToString(type) +
            ' but found ' +
            _typeToString(valueType),
        type,
        valueType));
  }

  /// Validates the given value and results validation results.
  ///
  /// - [value]     a value to be validated.
  /// Returns a list with validation results.
  ///
  /// See [ValidationResult]

  List<ValidationResult> validate(dynamic value) {
    var results = <ValidationResult>[];
    performValidation('', value, results);
    return results;
  }

  /// Validates the given value and returns a [ValidationException] if errors were found.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [value]             a value to be validated.
  /// - [strict]            true to treat warnings as errors.

  ValidationException validateAndReturnException(
      String correlationId, dynamic value,
      [bool strict = false]) {
    var results = validate(value);
    return ValidationException.fromResults(correlationId, results, strict);
  }

  /// Validates the given value and throws a [ValidationException] if errors were found.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [value]             a value to be validated.
  /// - [strict]            true to treat warnings as errors.
  ///
  /// See [ValidationException.throwExceptionIfNeeded]

  void validateAndThrowException(String correlationId, dynamic value,
      [bool strict = false]) {
    var results = validate(value);
    ValidationException.throwExceptionIfNeeded(correlationId, results, strict);
  }
}
