import './Schema.dart';
import './ValidationResult.dart';
import './IValidationRule.dart';
import './ValidationResultType.dart';
import '../reflect/ObjectReader.dart';
import '../convert/TypeCode.dart';
import '../convert/TypeConverter.dart';

/**
 * Schema to validate arrays.
 * 
 * ### Example ###
 * 
 *     var schema = new ArraySchema(TypeCode.String);
 *     
 *     schema.validate(["A", "B", "C"]);    // Result: no errors
 *     schema.validate([1, 2, 3]);          // Result: element type mismatch
 *     schema.validate("A");                // Result: type mismatch            
 */
class ArraySchema extends Schema {
  dynamic _valueType;

  /**
     * Creates a new instance of validation schema and sets its values.
     * 
     * - [valueType]     a type of array elements. Null means that elements may have any type.
     * - [required]      (optional) true to always require non-null values.
     * - [rules]         (optional) a list with validation rules.
     * 
     * See [TypeCode]
     */
  ArraySchema([dynamic valueType, bool req, List<IValidationRule> rules])
      : super(req, rules) {
    this._valueType = valueType;
  }

  /**
     * Gets the type of array elements.
     * Null means that elements may have any type.
     * 
     * Returns the type of array elements.
     */
  dynamic getValueType() {
    return this._valueType;
  }

  /**
     * Sets the type of array elements.
     * Null means that elements may have any type.
     * 
     * - [value]     a type of array elements.
     */
  void setValueType(dynamic value) {
    this._valueType = value;
  }

  /**
     * Validates a given value against the schema and configured validation rules.
     * 
     * - [path]      a dot notation path to the value.
     * - [value]     a value to be validated.
     * - [results]   a list with validation results to add new results.
     */
  @override
  void performValidation(
      String path, dynamic value, List<ValidationResult> results) {
    var name = path != null ? path : "value";
    value = ObjectReader.getValue(value);

    super.performValidation(path, value, results);

    if (value == null) return;

    if (value is List) {
      for (var index = 0; index < value.length; index++) {
        var elementPath =
            path != "" ? path + "." + index.toString() : index.toString();
        this.performTypeValidation(
            elementPath, this.getValueType(), value[index], results);
      }
    } else {
      results.add(new ValidationResult(
          path,
          ValidationResultType.Error,
          "VALUE_ISNOT_ARRAY",
          name + " type must to be List or Array",
          TypeCode.Array,
          TypeConverter.toTypeCode(value)));
    }
  }
}
