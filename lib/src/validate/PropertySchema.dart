import './IValidationRule.dart';
import './ValidationResult.dart';
import './Schema.dart';


/// Schema to validate object properties
/// 
/// See [ObjectSchema]
/// 
/// ### Example ###
/// 
///     var schema = new ObjectSchema()
///         .withProperty(new PropertySchema("id", TypeCode.String));
///     
///     schema.validate({ id: "1", name: "ABC" });       // Result: no errors
///     schema.validate({ name: "ABC" });                // Result: no errors
///     schema.validate({ id: 1, name: "ABC" });         // Result: id type mismatch
 
class PropertySchema extends Schema {
  String _name;
  dynamic _type;

  
    /// Creates a new validation schema and sets its values.
    /// 
    /// - [name]          (optional) a property name
    /// - [type]          (optional) a property type
    /// - [required]      (optional) true to always require non-null values.
    /// - [rules]         (optional) a list with validation rules.
    /// 
    /// See [IValidationRule]
    /// See [TypeCode]
     
  PropertySchema(
      [String name, dynamic type, bool req, List<IValidationRule> rules])
      : super(req, rules) {
    this._name = name;
    this._type = type;
  }

  
    /// Gets the property name.
    /// 
    /// Returns the property name.
     
  String getName() {
    return this._name;
  }

  
    /// Sets the property name.
    /// 
    /// - [value]     a new property name.
     
  setName(String value) {
    this._name = value;
  }

  
    /// Gets the property type.
    /// 
    /// Returns the property type.
     
  dynamic getType() {
    return this._type;
  }

  
    /// Sets a new property type.
    /// The type can be defined as type, type name or [[TypeCode]]
    /// 
    /// - [value]     a new property type.
     
  setType(dynamic value) {
    this._type = value;
  }

  
    /// Validates a given value against the schema and configured validation rules.
    /// 
    /// - [path]      a dot notation path to the value.
    /// - [value]     a value to be validated.
    /// - [results]   a list with validation results to add new results.
     
  void performValidation(
      String path, dynamic value, List<ValidationResult> results) {
    path = path != "" ? path + "." + this.getName() : this.getName();

    super.performValidation(path, value, results);

    super.performTypeValidation(path, this.getType(), value, results);
  }
}
