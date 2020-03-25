// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';
// import { Schema } from './Schema';
// import { PropertySchema } from './PropertySchema';
// import { ObjectComparator } from './ObjectComparator';
// import { ObjectReader } from '../reflect/ObjectReader';

// /**
//  * Schema to validate user defined objects.
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new ObjectSchema(false)
//  *         .withOptionalProperty("id", TypeCode.String)
//  *         .withRequiredProperty("name", TypeCode.String);
//  *     
//  *     schema.validate({ id: "1", name: "ABC" });       // Result: no errors
//  *     schema.validate({ name: "ABC" });                // Result: no errors
//  *     schema.validate({ id: 1, name: "ABC" });         // Result: id type mismatch
//  *     schema.validate({ id: 1, _name: "ABC" });        // Result: name is missing, unexpected _name
//  *     schema.validate("ABC");                          // Result: type mismatch
//  */
// export class ObjectSchema extends Schema {
//     private _properties: PropertySchema[];
//     private _allowUndefined: boolean;

//     /**
//      * Creates a new validation schema and sets its values. 
//      * 
//      * @param allowUndefined    true to allow properties undefines in the schema
//      * @param required          (optional) true to always require non-null values.
//      * @param rules             (optional) a list with validation rules.
//      * 
//      * @see [[IValidationRule]]
//      */
//     public constructor(allowUndefined?: boolean, required?: boolean, rules?: IValidationRule[]) {
//         super(required, rules);
//         this._allowUndefined = allowUndefined;
//     }

//     /**
//      * Gets validation schemas for object properties.
//      * 
//      * @returns the list of property validation schemas.
//      * 
//      * @see [[PropertySchema]]
//      */
//     public getProperties(): PropertySchema[] {
//         return this._properties;
//     }

//     /**
//      * Sets validation schemas for object properties.
//      * 
//      * @param value     a list of property validation schemas.
//      * 
//      * @see [[PropertySchema]]
//      */
//     public setProperties(value: PropertySchema[]) {
//         this._properties = value;
//     }

//     /**
//      * Gets flag to allow undefined properties
//      * 
//      * @returns true to allow undefined properties and false to disallow.
//      */
//     public get isUndefinedAllowed(): boolean {
//         return this._allowUndefined;
//     }

//     /**
//      * Sets flag to allow undefined properties
//      * 
//      * @param value     true to allow undefined properties and false to disallow.
//      */
//     public set isUndefinedAllowed(value: boolean) {
//         this._allowUndefined = value;
//     }

//     /**
//      * Sets flag to allow undefined properties
//      * 
//      * This method returns reference to this exception to implement Builder pattern
//      * to chain additional calls.
//      * 
//      * @param value     true to allow undefined properties and false to disallow.
//      * @returns this validation schema.
//      */
//     public allowUndefined(value: boolean): ObjectSchema {
//         this.isUndefinedAllowed = value;
//         return this;
//     }

//     /**
//      * Adds a validation schema for an object property.
//      * 
//      * This method returns reference to this exception to implement Builder pattern
//      * to chain additional calls.
//      * 
//      * @param schema    a property validation schema to be added.
//      * @returns this validation schema.
//      * 
//      * @see [[PropertySchema]]
//      */
//     public withProperty(schema: PropertySchema): ObjectSchema {
//         this._properties = this._properties || [];
//         this._properties.push(schema);
//         return this;
//     }

//     /**
//      * Adds a validation schema for a required object property.
//      * 
//      * @param name      a property name.
//      * @param type      (optional) a property schema or type.
//      * @param rules     (optional) a list of property validation rules.
//      */
//     public withRequiredProperty(name: string, type?: any, ...rules: IValidationRule[]): ObjectSchema {
//         var schema = new PropertySchema(name, type);
//         schema.setRules(rules.slice());
//         schema.makeRequired();

//         return this.withProperty(schema);
//     }

//     /**
//      * Adds a validation schema for an optional object property.
//      * 
//      * @param name      a property name.
//      * @param type      (optional) a property schema or type.
//      * @param rules     (optional) a list of property validation rules.
//      */
//     public withOptionalProperty(name: string, type?: any, ...rules: IValidationRule[]): ObjectSchema {
//         var schema = new PropertySchema(name, type);
//         schema.setRules(rules.slice());
//         schema.makeOptional();

//         return this.withProperty(schema);
//     }

//     /**
//      * Validates a given value against the schema and configured validation rules.
//      * 
//      * @param path      a dot notation path to the value.
//      * @param value     a value to be validated.
//      * @param results   a list with validation results to add new results.
//      */
//     protected performValidation(path: string, value: any, results: ValidationResult[]): void {
//         super.performValidation(path, value, results);

//         if (!value) return;

//         let name = path || "value";
//         let properties = ObjectReader.getProperties(value);

//         if (this._properties) {
//             for (var i = 0; i < this._properties.length; i++) {
//                 var propertySchema: PropertySchema = this._properties[i];
//                 var processedName = null;

//                 for (var key in properties) {
//                     var propertyName = key;
//                     var propertyValue = properties[key];

//                     if (ObjectComparator.areEqual(propertySchema.getName(), propertyName)) {
//                         propertySchema.performValidation(path, propertyValue, results);
//                         processedName = propertyName;
//                         break;
//                     }
//                 }

//                 if (processedName)
//                     delete properties[processedName];
//                 else
//                     propertySchema.performValidation(path, null, results);
//             }
//         }

//         if (!this._allowUndefined)
//             for (var key in properties) {
//                 let propertyPath: string = key && path != "" ? path + "." + key : key;

//                 results.push(new ValidationResult(
//                     propertyPath,
//                     ValidationResultType.Warning,
//                     "UNEXPECTED_PROPERTY",
//                     name + " contains unexpected property " + key,
//                     null,
//                     key
//                 ));
//             }
//     }

// }
