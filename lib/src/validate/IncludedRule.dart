// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';
// import { ObjectComparator } from './ObjectComparator';

// /**
//  * Validation rule to check that value is included into the list of constants.
//  * 
//  * @see [[IValidationRule]]
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new Schema()
//  *         .withRule(new IncludedRule(1, 2, 3));
//  *     
//  *     schema.validate(2);      // Result: no errors
//  *     schema.validate(10);     // Result: 10 must be one of 1, 2, 3
//  */
// export class IncludedRule implements IValidationRule {
//     private readonly _values: any[];

//     /**
//      * Creates a new validation rule and sets its values.
//      * 
//      * @param values    a list of constants that value must be included to
//      */
//     public constructor(...values: any[]) {
//         this._values = values;
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
//         if (!this._values) return;

//         let name = path || "value";
//         let found: boolean = false;

//         for (var i = 0; i < this._values.length && !found; i++) {
//             let thisValue: any = this._values[i];

//             if (ObjectComparator.compare(value, 'EQ', thisValue)) {
//                 found = true;
//                 break;
//             }
//         }

//         if (!found) {
//             results.push(
//                 new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "VALUE_NOT_INCLUDED",
//                     name + " must be one of " + this._values,
//                     this._values,
//                     null
//                 )
//             );
//         }
//     }

// }