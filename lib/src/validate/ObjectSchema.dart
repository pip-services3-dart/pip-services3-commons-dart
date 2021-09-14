import '../reflect/ObjectReader.dart';
import './IValidationRule.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';
import './ObjectComparator.dart';
import './Schema.dart';
import './PropertySchema.dart';

/// Schema to validate user defined objects.
///
/// ### Example ###
///
///     var schema =  ObjectSchema(false)
///         .withOptionalProperty('id', TypeCode.String)
///         .withRequiredProperty('name', TypeCode.String);
///
///     schema.validate({ id: '1', name: 'ABC' });       // Result: no errors
///     schema.validate({ name: 'ABC' });                // Result: no errors
///     schema.validate({ id: 1, name: 'ABC' });         // Result: id type mismatch
///     schema.validate({ id: 1, _name: 'ABC' });        // Result: name is missing, unexpected _name
///     schema.validate('ABC');                          // Result: type mismatch

class ObjectSchema extends Schema {
  List<PropertySchema>? _properties;
  bool? _allowUndefined;

  /// Creates a new validation schema and sets its values.
  ///
  /// - [allowUndefined]    true to allow properties undefines in the schema
  /// - [required]          (optional) true to always require non-null values.
  /// - [rules]             (optional) a list with validation rules.
  ///
  /// See [IValidationRule]

  ObjectSchema([bool? allowUndefined, bool? req, List<IValidationRule>? rules])
      : super(req, rules) {
    _allowUndefined = allowUndefined;
  }

  /// Gets validation schemas for object properties.
  ///
  /// Returns the list of property validation schemas.
  ///
  /// See [PropertySchema]

  List<PropertySchema> getProperties() {
    return _properties ?? [];
  }

  /// Sets validation schemas for object properties.
  ///
  /// - [value]     a list of property validation schemas.
  ///
  /// See [PropertySchema]

  void setProperties(List<PropertySchema> value) {
    _properties = value;
  }

  /// Gets flag to allow undefined properties
  ///
  /// Returns true to allow undefined properties and false to disallow.

  bool get isUndefinedAllowed {
    return _allowUndefined == true;
  }

  /// Sets flag to allow undefined properties
  ///
  /// - [value]     true to allow undefined properties and false to disallow.

  set isUndefinedAllowed(bool value) {
    _allowUndefined = value;
  }

  /// Sets flag to allow undefined properties
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [value]     true to allow undefined properties and false to disallow.
  /// Returns this validation schema.

  ObjectSchema allowUndefined(bool value) {
    isUndefinedAllowed = value;
    return this;
  }

  /// Adds a validation schema for an object property.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [schema]    a property validation schema to be added.
  /// Returns this validation schema.
  ///
  /// See [PropertySchema]

  dynamic withProperty(PropertySchema schema) {
    _properties = _properties ?? <PropertySchema>[];
    _properties!.add(schema);
    return this;
  }

  /// Adds a validation schema for a required object property.
  ///
  /// - [name]      a property name.
  /// - [type]      (optional) a property schema or type.
  /// - [rules]     (optional) a list of property validation rules.

  ObjectSchema withRequiredProperty(String name,
      [dynamic type, List<IValidationRule>? rules]) {
    var schema = PropertySchema(name, type);
    if (rules != null) {
      schema.setRules(List.from(rules));
    }

    schema.makeRequired();

    return withProperty(schema);
  }

  /// Adds a validation schema for an optional object property.
  ///
  /// - [name]      a property name.
  /// - [type]      (optional) a property schema or type.
  /// - [rules]     (optional) a list of property validation rules.

  ObjectSchema withOptionalProperty(String name,
      [dynamic type, List<IValidationRule>? rules]) {
    var schema = PropertySchema(name, type);
    if (rules != null) {
      schema.setRules(List.from(rules));
    }
    schema.makeOptional();

    return withProperty(schema);
  }

  /// Validates a given value against the schema and configured validation rules.
  ///
  /// - [path]      a dot notation path to the value.
  /// - [value]     a value to be validated.
  /// - [results]   a list with validation results to add new results.

  @override
  void performValidation(
      String? path, dynamic value, List<ValidationResult> results) {
    super.performValidation(path, value, results);

    if (value == null) return;

    var name = path ?? 'value';
    var properties = ObjectReader.getProperties(value);

    if (_properties != null) {
      for (var i = 0; i < _properties!.length; i++) {
        var propertySchema = _properties![i];
        var processedName;

        for (var key in properties.keys) {
          var propertyName = key;
          var propertyValue = properties[key];

          if (ObjectComparator.areEqual(
              propertySchema.getName(), propertyName)) {
            propertySchema.performValidation(path, propertyValue, results);
            processedName = propertyName;
            break;
          }
        }

        if (processedName != null) {
          properties.remove(processedName);
        } else {
          propertySchema.performValidation(path, null, results);
        }
      }
    }

    if (_allowUndefined == null || _allowUndefined == false) {
      for (var key in properties.keys) {
        var propertyPath = path != null && path != '' ? path + '.' + key : key;

        results.add(ValidationResult(
            propertyPath,
            ValidationResultType.Warning,
            'UNEXPECTED_PROPERTY',
            name + ' contains unexpected property ' + key,
            null,
            key));
      }
    }
  }
}
