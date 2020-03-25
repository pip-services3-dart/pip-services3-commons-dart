// /** @module validate */
// /** @hidden */ 
// let _ = require('lodash');

// import { IValidationRule } from './IValidationRule';
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';
// import { Schema } from './Schema';
// import { ObjectReader } from '../reflect/ObjectReader';
// import { TypeCode } from '../convert/TypeCode';
// import { TypeConverter } from '../convert/TypeConverter';
// import { StringConverter } from '../convert/StringConverter';

// /**
//  * Schema to validate maps.
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new MapSchema(TypeCode.String, TypeCode.Integer);
//  *     
//  *     schema.validate({ "key1": "A", "key2": "B" });       // Result: no errors
//  *     schema.validate({ "key1": 1, "key2": 2 });           // Result: element type mismatch
//  *     schema.validate([ 1, 2, 3 ]);                        // Result: type mismatch
//  */
// export class MapSchema extends Schema {
//     private _keyType: any;
//     private _valueType: any;
    
//     /**
//      * Creates a new instance of validation schema and sets its values.
//      * 
//      * @param keyType       a type of map keys. Null means that keys may have any type.
//      * @param valueType     a type of map values. Null means that values may have any type.
//      * @param required      (optional) true to always require non-null values.
//      * @param rules         (optional) a list with validation rules.
//      * 
//      * @see [[IValidationRule]]
//      * @see [[TypeCode]]
//      */
//     public constructor(keyType?: any, valueType?: any, required?: boolean, rules?: IValidationRule[]) {
//         super(required, rules);

//         this._keyType = keyType;
//         this._valueType = valueType;
//     }

//     /**
//      * Gets the type of map keys.
//      * Null means that keys may have any type.
//      * 
//      * @returns the type of map keys.
//      */
//     public getKeyType(): any {
//         return this._keyType; 
//     }

//     /**
//      * Sets the type of map keys.
//      * Null means that keys may have any type.
//      * 
//      * @param value     a type of map keys.
//      */
//     public setKeyType(value: any) {
//         this._keyType = value; 
//     }

//     /**
//      * Gets the type of map values.
//      * Null means that values may have any type.
//      * 
//      * @returns the type of map values.
//      */
//     public getValueType(): any {
//         return this._valueType; 
//     }

//     /**
//      * Sets the type of map values.
//      * Null means that values may have any type.
//      * 
//      * @param value     a type of map values.
//      */
//     public setValueType(value: any) {
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
//         value = ObjectReader.getValue(value);

//         super.performValidation(path, value, results);

//         if (!value) return;

//         let name = path || "value";
//         let valueType: TypeCode = TypeConverter.toTypeCode(value);
//         let map: any = valueType === TypeCode.Map ? value : null;

//         if (map) {
//             for (var key in map) {
//                 var elementPath = path != "" ? path + "." + key : StringConverter.toString(key);

//                 this.performTypeValidation(elementPath, this.getKeyType(), key, results);
//                 this.performTypeValidation(elementPath, this.getValueType(), map[key], results);
//             }
//         } else {
//             if (this.isRequired) {
//                 results.push(new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "VALUE_ISNOT_MAP",
//                     name + " type must be Map",
//                     TypeCode.Map,
//                     valueType
//                 ));
//             }
//         }
//     }

// }
