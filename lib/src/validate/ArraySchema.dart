// /** @module validate */
// /** @hidden */ 
// let _ = require('lodash');

// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';
// import { IValidationRule } from './IValidationRule';
// import { ValidationResultType } from './ValidationResultType';
// import { ObjectReader } from '../reflect/ObjectReader';
// import { TypeCode } from '../convert/TypeCode';
// import { TypeConverter } from '../convert/TypeConverter';

// /**
//  * Schema to validate arrays.
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new ArraySchema(TypeCode.String);
//  *     
//  *     schema.validate(["A", "B", "C"]);    // Result: no errors
//  *     schema.validate([1, 2, 3]);          // Result: element type mismatch
//  *     schema.validate("A");                // Result: type mismatch            
//  */
// export class ArraySchema extends Schema {
//     private _valueType: any;

//     /**
//      * Creates a new instance of validation schema and sets its values.
//      * 
//      * @param valueType     a type of array elements. Null means that elements may have any type.
//      * @param required      (optional) true to always require non-null values.
//      * @param rules         (optional) a list with validation rules.
//      * 
//      * @see [[TypeCode]]
//      */
//     public constructor(valueType?: any, required?: boolean, rules?: IValidationRule[]) {
//         super(required, rules);

//         this._valueType = valueType;
//     }

//     /**
//      * Gets the type of array elements.
//      * Null means that elements may have any type.
//      * 
//      * @returns the type of array elements.
//      */
//     public getValueType(): any {
//         return this._valueType;
//     }

//     /**
//      * Sets the type of array elements.
//      * Null means that elements may have any type.
//      * 
//      * @param value     a type of array elements.
//      */
//     public setValueType(value: any): void {
//         this._valueType = value;
//     }

//     /**
//      * Validates a given value against the schema and configured validation rules.
//      * 
//      * @param path      a dot notation path to the value.
//      * @param value     a value to be validated.
//      * @param results   a list with validation results to add new results.
//      */
//     protected performValidation(path: string, value: any, results: ValidationResult[]): void {
//         let name = path || "value";
//         value = ObjectReader.getValue(value);

//         super.performValidation(path, value, results);

//         if (!value) return;

//         if (_.isArray(value)) {
//             for (let index = 0; index < value.length; index++) {
//                 let elementPath = path != "" ? path + "." + index : index.toString();
//                 this.performTypeValidation(elementPath, this.getValueType(), value[index], results);
//             }
//         } else {
//             results.push(
//                 new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "VALUE_ISNOT_ARRAY",
//                     name + " type must to be List or Array",
//                     TypeCode.Array,
//                     TypeConverter.toTypeCode(value)
//                 )
//             );
//         }
//     }

// }
