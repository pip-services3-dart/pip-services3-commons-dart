// /** @module validate */
// /** @hidden */ 
// let _ = require('lodash');

// import { IValidationRule } from './IValidationRule';
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';
// import { ValidationException } from './ValidationException';
// import { ObjectReader } from '../reflect/ObjectReader';
// import { TypeMatcher } from '../reflect/TypeMatcher';
// import { TypeCode } from '../convert/TypeCode';
// import { TypeConverter } from '../convert/TypeConverter';

// /**
//  * Basic schema that validates values against a set of validation rules.
//  * 
//  * This schema is used as a basis for specific schemas to validate 
//  * objects, project properties, arrays and maps.
//  * 
//  * @see [[ObjectSchema]]
//  * @see [[PropertySchema]]
//  * @see [[ArraySchema]]
//  * @see [[MapSchema]]
//  */
// export class Schema {
//     private _required: boolean;
//     private _rules: IValidationRule[];

//     /**
//      * Creates a new instance of validation schema and sets its values.
//      * 
//      * @param required  (optional) true to always require non-null values.
//      * @param rules     (optional) a list with validation rules.
//      * 
//      * @see [[IValidationRule]]
//      */
//     public constructor(required?: boolean, rules?: IValidationRule[]) {
//         this._required = required;
//         this._rules = rules;
//     }
    
//     /**
//      * Gets a flag that always requires non-null values.
//      * For null values it raises a validation error.
//      * 
//      * @returns true to always require non-null values and false to allow null values.
//      */
//     public isRequired(): boolean {
//         return this._required;
//     }

//     /**
//      * Sets a flag that always requires non-null values.
//      * 
//      * @param value true to always require non-null values and false to allow null values.
//      */
//     public setRequired(value: boolean) {
//         this._required = value;
//     }

//     /**
//      * Gets validation rules to check values against.
//      * 
//      * @returns a list with validation rules.
//      */
//     public getRules(): IValidationRule[] {
//         return this._rules;
//     }

//     /**
//      * Sets validation rules to check values against.
//      * 
//      * @param value a list with validation rules.
//      */
//     public setRules(value: IValidationRule[]) {
//         this._rules = value;
//     }

//     /**
//      * Makes validated values always required (non-null).
//      * For null values the schema will raise errors.
//      * 
//      * This method returns reference to this exception to implement Builder pattern
//      * to chain additional calls.
//      * 
//      * @returns this validation schema
//      * 
//      * @see [[makeOptional]]
//      */
//     public makeRequired(): Schema {
//         this._required = true;
//         return this;
//     }

//     /**
//      * Makes validated values optional.
//      * Validation for null values will be skipped.
//      * 
//      * This method returns reference to this exception to implement Builder pattern
//      * to chain additional calls.
//      * 
//      * @returns this validation schema
//      * 
//      * @see [[makeRequired]]
//      */
//     public makeOptional(): Schema {
//         this._required = false;
//         return this;
//     }

//     /**
//      * Adds validation rule to this schema.
//      * 
//      * This method returns reference to this exception to implement Builder pattern
//      * to chain additional calls.
//      * 
//      * @param rule  a validation rule to be added.
//      * @returns this validation schema.
//      */
//     public withRule(rule: IValidationRule): Schema {
//         this._rules = this._rules || [];
//         this._rules.push(rule);
//         return this;
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

//         if (value == null) {
//             if (this.isRequired()) {
//                 results.push(new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "VALUE_IS_NULL",
//                     name + " must not be null",
//                     "NOT NULL",
//                     null
//                 ));
//             }
//         } else {
//             value = ObjectReader.getValue(value);

//             // Check validation rules
//             if (this._rules != null) {
//                 for (var i = 0; i < this._rules.length; i++) {
//                     let rule: IValidationRule = this._rules[i];
//                     rule.validate(path, this, value, results);
//                 }
//             }
//         }
//     }

//     private typeToString(type: any): string {
//         if (type == null)
//             return "unknown";
//         if (_.isNumber(type))
//             return TypeConverter.toString(type);
//         return type.toString();
//     }

//     /**
//      * Validates a given value to match specified type.
//      * The type can be defined as a Schema, type, a type name or [[TypeCode]]
//      * When type is a Schema, it executes validation recursively against that Schema.
//      * 
//      * @param path      a dot notation path to the value.
//      * @param type      a type to match the value type
//      * @param value     a value to be validated.
//      * @param results   a list with validation results to add new results.
//      * 
//      * @see [[performValidation]]
//      */
//     protected performTypeValidation(path: string, type: any, value: any, results: ValidationResult[]): void {
//         // If type it not defined then skip
//         if (type == null) return;

//         // Perform validation against the schema
//         if (type instanceof Schema) {
//             let schema: Schema = type as Schema;
//             schema.performValidation(path, value, results);
//             return;
//         }

//         // If value is null then skip
//         value = ObjectReader.getValue(value);
//         if (value == null) return;

//         let name = path || "value";
//         let valueType: TypeCode = TypeConverter.toTypeCode(value);

//         // Match types
//         if (TypeMatcher.matchType(type, valueType, value))
//             return;

//         results.push(
//             new ValidationResult(
//                 path,
//                 ValidationResultType.Error,
//                 "TYPE_MISMATCH",
//                 name + " type must be " + this.typeToString(type) + " but found " + this.typeToString(valueType),
//                 type,
//                 valueType.toString()
//             )
//         );
//     }

//     /**
//      * Validates the given value and results validation results.
//      * 
//      * @param value     a value to be validated.
//      * @returns a list with validation results.
//      * 
//      * @see [[ValidationResult]]
//      */
//     public validate(value: any): ValidationResult[] {
//         let results: ValidationResult[] = [];
//         this.performValidation("", value, results);
//         return results;
//     }

//     /**
//      * Validates the given value and returns a [[ValidationException]] if errors were found.
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param value             a value to be validated.
//      * @param strict            true to treat warnings as errors.
//      */
//     public validateAndReturnException(correlationId: string, value: any, strict: boolean = false): ValidationException {
//         let results: ValidationResult[] = this.validate(value);
//         return ValidationException.fromResults(correlationId, results, strict);
//     }

//     /**
//      * Validates the given value and throws a [[ValidationException]] if errors were found.
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param value             a value to be validated.
//      * @param strict            true to treat warnings as errors.
//      * 
//      * @see [[ValidationException.throwExceptionIfNeeded]]
//      */
//     public validateAndThrowException(correlationId: string, value: any, strict: boolean = false): void {
//         let results: ValidationResult[] = this.validate(value);
//         ValidationException.throwExceptionIfNeeded(correlationId, results, strict);
//     }

// }
