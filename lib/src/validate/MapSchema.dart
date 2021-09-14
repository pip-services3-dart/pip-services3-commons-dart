import './IValidationRule.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';
import './Schema.dart';
import '../reflect/ObjectReader.dart';
import '../convert/TypeCode.dart';
import '../convert/TypeConverter.dart';
import '../convert/StringConverter.dart';

/// Schema to validate maps.
///
/// ### Example ###
///
///     var schema =  MapSchema(TypeCode.String, TypeCode.Integer);
///
///     schema.validate({ 'key1': 'A', 'key2': 'B' });       // Result: no errors
///     schema.validate({ 'key1': 1, 'key2': 2 });           // Result: element type mismatch
///     schema.validate([ 1, 2, 3 ]);                        // Result: type mismatch

class MapSchema extends Schema {
  dynamic _keyType;
  dynamic _valueType;

  /// Creates a new instance of validation schema and sets its values.
  ///
  /// - [keyType]       a type of map keys. Null means that keys may have any type.
  /// - [valueType]     a type of map values. Null means that values may have any type.
  /// - [required]      (optional) true to always require non-null values.
  /// - [rules]         (optional) a list with validation rules.
  ///
  /// See [IValidationRule]
  /// See [TypeCode]

  MapSchema(
      [dynamic keyType,
      dynamic valueType,
      bool? req,
      List<IValidationRule>? rules])
      : super(req, rules) {
    _keyType = keyType;
    _valueType = valueType;
  }

  /// Gets the type of map keys.
  /// Null means that keys may have any type.
  ///
  /// Returns the type of map keys.

  dynamic getKeyType() {
    return _keyType;
  }

  /// Sets the type of map keys.
  /// Null means that keys may have any type.
  ///
  /// - [value]     a type of map keys.

  void setKeyType(dynamic value) {
    _keyType = value;
  }

  /// Gets the type of map values.
  /// Null means that values may have any type.
  ///
  /// Returns the type of map values.

  dynamic getValueType() {
    return _valueType;
  }

  /// Sets the type of map values.
  /// Null means that values may have any type.
  ///
  /// - [value]     a type of map values.

  void setValueType(dynamic value) {
    _valueType = value;
  }

  /// Validates a given value against the schema and configured validation rules.
  ///
  /// - [path]      a dot notation path to the value.
  /// - [value]     a value to be validated.
  /// - [results]   a list with validation results to add new results.

  @override
  void performValidation(
      String? path, dynamic value, List<ValidationResult> results) {
    value = ObjectReader.getValue(value);

    super.performValidation(path, value, results);

    if (value == null) return;

    var name = path ?? 'value';
    var valueType = TypeConverter.toTypeCode(value);
    var map = valueType == TypeCode.Map ? Map.from(value) : null;

    if (map != null) {
      for (var key in map.keys) {
        var elementPath = path != '' && path != null
            ? path + '.' + key
            : StringConverter.toString2(key);

        performTypeValidation(elementPath, getKeyType(), key, results);
        performTypeValidation(elementPath, getValueType(), map[key], results);
      }
    } else {
      if (isRequired()) {
        results.add(ValidationResult(
            path,
            ValidationResultType.Error,
            'VALUE_ISNOT_MAP',
            name + ' type must be Map',
            TypeCode.Map,
            valueType));
      }
    }
  }
}
