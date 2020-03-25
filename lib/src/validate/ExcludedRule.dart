// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';
// import { ObjectComparator } from './ObjectComparator';

// /**
//  * Validation rule to check that value is excluded from the list of constants.
//  * 
//  * @see [[IValidationRule]]
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new Schema()
//  *         .withRule(new ExcludedRule(1, 2, 3));
//  *     
//  *     schema.validate(2);      // Result: 2 must not be one of 1, 2, 3
//  *     schema.validate(10);     // Result: no errors
//  */
// export class ExcludedRule implements IValidationRule {
//     private readonly _values: any[];

//     /**
//      * Creates a new validation rule and sets its values.
//      * 
//      * @param values    a list of constants that value must be excluded from
//      */
//     public constructor(...values: any[]) {
//         this._values = values;
//     }

//     /**
//      * Validates the given value. None of the values set in this ExcludedRule object must exist 
//      * in the value that is given for validation to pass.
//      * 
//      * @param path      the dot notation path to the value that is to be validated.
//      * @param schema    (not used in this implementation).
//      * @param value     the value that is to be validated.
//      * @param results   the results of the validation.
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

//         if (found) {
//             results.push(
//                 new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "VALUE_INCLUDED",
//                     name + " must not be one of " + this._values,
//                     this._values,
//                     null
//                 )
//             );
//         }
//     }

// }
