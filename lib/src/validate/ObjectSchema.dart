import '../reflect/ObjectReader.dart';
import './IValidationRule.dart';
import './ValidationResult.dart';
import './ValidationResultType.dart';
import './ObjectComparator.dart';
import './Schema.dart';
import './PropertySchema.dart';

/**
 * Schema to validate user defined objects.
 * 
 * ### Example ###
 * 
 *     let schema = new ObjectSchema(false)
 *         .withOptionalProperty("id", TypeCode.String)
 *         .withRequiredProperty("name", TypeCode.String);
 *     
 *     schema.validate({ id: "1", name: "ABC" });       // Result: no errors
 *     schema.validate({ name: "ABC" });                // Result: no errors
 *     schema.validate({ id: 1, name: "ABC" });         // Result: id type mismatch
 *     schema.validate({ id: 1, _name: "ABC" });        // Result: name is missing, unexpected _name
 *     schema.validate("ABC");                          // Result: type mismatch
 */
class ObjectSchema extends Schema {
  List<PropertySchema> _properties;
  bool _allowUndefined;

  /**
     * Creates a new validation schema and sets its values. 
     * 
     * @param allowUndefined    true to allow properties undefines in the schema
     * @param required          (optional) true to always require non-null values.
     * @param rules             (optional) a list with validation rules.
     * 
     * @see [[IValidationRule]]
     */
  ObjectSchema([bool allowUndefined, bool req, List<IValidationRule> rules])
      : super(req, rules) {
    this._allowUndefined = allowUndefined;
  }

  /**
     * Gets validation schemas for object properties.
     * 
     * @returns the list of property validation schemas.
     * 
     * @see [[PropertySchema]]
     */
  List<PropertySchema> getProperties() {
    return this._properties;
  }

  /**
     * Sets validation schemas for object properties.
     * 
     * @param value     a list of property validation schemas.
     * 
     * @see [[PropertySchema]]
     */
  void setProperties(List<PropertySchema> value) {
    this._properties = value;
  }

  /**
     * Gets flag to allow undefined properties
     * 
     * @returns true to allow undefined properties and false to disallow.
     */
  bool get isUndefinedAllowed {
    return this._allowUndefined;
  }

  /**
     * Sets flag to allow undefined properties
     * 
     * @param value     true to allow undefined properties and false to disallow.
     */
  void set isUndefinedAllowed(bool value) {
    this._allowUndefined = value;
  }

  /**
     * Sets flag to allow undefined properties
     * 
     * This method returns reference to this exception to implement Builder pattern
     * to chain additional calls.
     * 
     * @param value     true to allow undefined properties and false to disallow.
     * @returns this validation schema.
     */
  ObjectSchema allowUndefined(bool value) {
    this.isUndefinedAllowed = value;
    return this;
  }

  /**
     * Adds a validation schema for an object property.
     * 
     * This method returns reference to this exception to implement Builder pattern
     * to chain additional calls.
     * 
     * @param schema    a property validation schema to be added.
     * @returns this validation schema.
     * 
     * @see [[PropertySchema]]
     */
  withProperty(PropertySchema schema) {
    this._properties =
        this._properties != null ? this._properties : List<PropertySchema>();
    this._properties.add(schema);
    return this;
  }

  /**
     * Adds a validation schema for a required object property.
     * 
     * @param name      a property name.
     * @param type      (optional) a property schema or type.
     * @param rules     (optional) a list of property validation rules.
     */
  ObjectSchema withRequiredProperty(String name,
      [dynamic type, List<IValidationRule> rules]) {
    var schema = new PropertySchema(name, type);
    if (rules!= null) {
      schema.setRules(List.from(rules));
    }
    
    schema.makeRequired();

    return this.withProperty(schema);
  }

  /**
     * Adds a validation schema for an optional object property.
     * 
     * @param name      a property name.
     * @param type      (optional) a property schema or type.
     * @param rules     (optional) a list of property validation rules.
     */
  ObjectSchema withOptionalProperty(String name,
      [dynamic type, List<IValidationRule> rules]) {
    var schema = new PropertySchema(name, type);
    if (rules!= null) {
      schema.setRules(List.from(rules));
    }
    schema.makeOptional();

    return this.withProperty(schema);
  }

  /**
     * Validates a given value against the schema and configured validation rules.
     * 
     * @param path      a dot notation path to the value.
     * @param value     a value to be validated.
     * @param results   a list with validation results to add new results.
     */
  void performValidation(
      String path, dynamic value, List<ValidationResult> results) {
    super.performValidation(path, value, results);

    if (value == null) return;

    var name = path != null ? path : "value";
    var properties = ObjectReader.getProperties(value);

    if (this._properties != null) {
      for (var i = 0; i < this._properties.length; i++) {
        var propertySchema = this._properties[i];
        var processedName = null;

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

        if (processedName != null)
          properties.remove(processedName);
        else
          propertySchema.performValidation(path, null, results);
      }
    }

    if (this._allowUndefined == null || this._allowUndefined == false)
      for (var key in properties.keys) {
        var propertyPath = key != null && path != "" ? path + "." + key : key;

        results.add(new ValidationResult(
            propertyPath,
            ValidationResultType.Warning,
            "UNEXPECTED_PROPERTY",
            name + " contains unexpected property " + key,
            null,
            key));
      }
  }
}
