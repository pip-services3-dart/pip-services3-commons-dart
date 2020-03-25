// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';
// import { ObjectComparator } from './ObjectComparator';
// import { ValidationResultType } from './ValidationResultType';

// /**
//  * Validation rule that compares value to a constant.
//  * 
//  * @see [[IValidationRule]]
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new Schema()
//  *         .withRule(new ValueComparisonRule("EQ", 1));
//  *     
//  *     schema.validate(1);          // Result: no errors
//  *     schema.validate(2);          // Result: 2 is not equal to 1
//  */
// export class ValueComparisonRule implements IValidationRule {
//     private readonly _value: any;
//     private readonly _operation: string;

//     /**
//      * Creates a new validation rule and sets its values.
//      * 
//      * @param operation    a comparison operation: "==" ("=", "EQ"), "!= " ("<>", "NE"); "<"/">" ("LT"/"GT"), "<="/">=" ("LE"/"GE"); "LIKE".
//      * @param value        a constant value to compare to
//      */
//     public constructor(operation: string, value: any) {
//         this._operation = operation;
//         this._value = value;
//     }

//     /**
//      * Validates a given value against this rule.
//      * 
//      * @param path      a dot notation path to the value.
//      * @param schema    a schema this rule is called from
//      * @param value     a value to be validated.
//      * @param results   a list with validation results to add new results.
//      */
//     public validate(path: string, schema: Schema, value: any, results: ValidationResult[]): void {
//         let name = path || "value";

//         if (!ObjectComparator.compare(value, this._operation, this._value)) {
//             results.push(
//                 new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "BAD_VALUE",
//                     name + " must " + this._operation + " " + this._value + " but found " + value,
//                     this._operation + " " + this._value,
//                     value
//                 )
//             );
//         }
//     }

// }