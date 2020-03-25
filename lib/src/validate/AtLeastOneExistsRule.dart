// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';
// import { ObjectReader } from '../reflect/ObjectReader';

// /**
//  * Validation rule that check that at least one of the object properties is not null.
//  * 
//  * @see [[IValidationRule]]
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new Schema()
//  *         .withRule(new AtLeastOneExistsRule("field1", "field2"));
//  *     
//  *     schema.validate({ field1: 1, field2: "A" });     // Result: no errors
//  *     schema.validate({ field1: 1 });                  // Result: no errors
//  *     schema.validate({ });                            // Result: at least one of properties field1, field2 must exist
//  */
// export class AtLeastOneExistsRule implements IValidationRule {
//     private readonly _properties: string[];

//     /**
//      * Creates a new validation rule and sets its values
//      * 
//      * @param properties    a list of property names where at least one property must exist
//      */
//     public constructor(...properties: string[]) {
//         this._properties = properties;
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
//         let found: string[] = [];

//         for (var i = 0; i < this._properties.length; i++) {
//             var propertyValue = ObjectReader.getProperty(value, this._properties[i]);
//             if (propertyValue != null)
//                 found.push(this._properties[i]);
//         }

//         if (found.length === 0) {
//             results.push(
//                 new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "VALUE_NULL",
//                     name + " must have at least one property from " + this._properties,
//                     this._properties,
//                     null
//                 )
//             );
//         }
//     }

// }