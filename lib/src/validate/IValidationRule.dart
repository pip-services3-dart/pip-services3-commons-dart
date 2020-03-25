// /** @module validate */
// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';

// /**
//  * Interface for validation rules.
//  * 
//  * Validation rule can validate one or multiple values
//  * against complex rules like: value is in range,
//  * one property is less than another property,
//  * enforce enumerated values and more.
//  * 
//  * This interface allows to implement custom rules.
//  */
// export interface IValidationRule {

//     /**
//      * Validates a given value against this rule.
//      * 
//      * @param path      a dot notation path to the value.
//      * @param schema    a schema this rule is called from
//      * @param value     a value to be validated.
//      * @param results   a list with validation results to add new results.
//      */
//     validate(path: string, schema: Schema, value: any, results: ValidationResult[]): void;
// }
