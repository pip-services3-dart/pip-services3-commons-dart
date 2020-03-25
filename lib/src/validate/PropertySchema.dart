// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { ValidationResult } from './ValidationResult';
// import { Schema } from './Schema';

// /**
//  * Schema to validate object properties
//  * 
//  * @see [[ObjectSchema]]
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new ObjectSchema()
//  *         .withProperty(new PropertySchema("id", TypeCode.String));
//  *     
//  *     schema.validate({ id: "1", name: "ABC" });       // Result: no errors
//  *     schema.validate({ name: "ABC" });                // Result: no errors
//  *     schema.validate({ id: 1, name: "ABC" });         // Result: id type mismatch
//  */
// export class PropertySchema extends Schema {
//     private _name: string;
//     private _type: any;
    
//     /**
//      * Creates a new validation schema and sets its values.
//      * 
//      * @param name          (optional) a property name
//      * @param type          (optional) a property type
//      * @param required      (optional) true to always require non-null values.
//      * @param rules         (optional) a list with validation rules.
//      * 
//      * @see [[IValidationRule]]
//      * @see [[TypeCode]]
//      */
//     public constructor(name?: string, type?: any, required?: boolean, rules?: IValidationRule[]) {
//         super(required, rules);

//         this._name = name;
//         this._type = type;
//     }

//     /**
//      * Gets the property name.
//      * 
//      * @returns the property name.
//      */
//     public getName(): string {
//         return this._name; 
//     }

//     /**
//      * Sets the property name.
//      * 
//      * @param value     a new property name.
//      */
//     public setName(value: string) {
//         this._name = value; 
//     }

//     /**
//      * Gets the property type.
//      * 
//      * @returns the property type.
//      */
//     public getType(): any {
//         return this._type; 
//     }

//     /**
//      * Sets a new property type.
//      * The type can be defined as type, type name or [[TypeCode]]
//      * 
//      * @param value     a new property type.
//      */
//     public setType(value: any) {
//         this._type = value; 
//     }

//     /**
//      * Validates a given value against the schema and configured validation rules.
//      * 
//      * @param path      a dot notation path to the value.
//      * @param value     a value to be validated.
//      * @param results   a list with validation results to add new results.
//      */
//     public performValidation(path: string, value: any, results: ValidationResult[]): void {
//         path = path != "" ? path + "." + this.getName() : this.getName();

//         super.performValidation(path, value, results);

//         super.performTypeValidation(path, this.getType(), value, results);
//     }

// }
