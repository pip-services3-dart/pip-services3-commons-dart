// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';

// /**
//  * Validation rule negate another rule.
//  * When embedded rule returns no errors, than this rule return an error.
//  * When embedded rule return errors, than the rule returns no errors.
//  * 
//  * @see [[IValidationRule]]
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new Schema()
//  *         .withRule(new NotRule(
//  *             new ValueComparisonRule("EQ", 1)
//  *         ));
//  *     
//  *     schema.validate(1);          // Result: error
//  *     schema.validate(5);          // Result: no error
//  */
// export class NotRule implements IValidationRule {
//     private readonly _rule: IValidationRule;

//     /**
//      * Creates a new validation rule and sets its values
//      * 
//      * @param rule     a rule to be negated.
//      */
//     public constructor(rule: IValidationRule) {
//         this._rule = rule;
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
//         if (!this._rule) return;

//         let name = path || "value";
//         let localResults: ValidationResult[] = [];

//         this._rule.validate(path, schema, value, localResults);

//         if (localResults.length > 0) return;

//         results.push(
//             new ValidationResult(
//                 path,
//                 ValidationResultType.Error,
//                 "NOT_FAILED",
//                 "Negative check for " + name + " failed",
//                 null,
//                 null
//             )
//         );
//     }

// }
