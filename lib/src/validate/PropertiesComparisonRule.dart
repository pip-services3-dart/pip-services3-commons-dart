// /** @module validate */
// import { IValidationRule } from './IValidationRule';
// import { Schema } from './Schema';
// import { ValidationResult } from './ValidationResult';
// import { ObjectComparator } from './ObjectComparator';
// import { ValidationResultType } from './ValidationResultType';
// import { ObjectReader } from '../reflect/ObjectReader';

// /**
//  * Validation rule that compares two object properties.
//  * 
//  * @see [[IValidationRule]]
//  * 
//  * ### Example ###
//  * 
//  *     let schema = new ObjectSchema()
//  *         .withRule(new PropertyComparisonRule("field1", "NE", "field2"));
//  *     
//  *     schema.validate({ field1: 1, field2: 2 });       // Result: no errors
//  *     schema.validate({ field1: 1, field2: 1 });       // Result: field1 shall not be equal to field2
//  *     schema.validate({});                             // Result: no errors
//  */
// export class PropertiesComparisonRule implements IValidationRule {
//     private readonly _property1: string;
//     private readonly _property2: string;
//     private readonly _operation: string;

//     /**
//      * Creates a new validation rule and sets its arguments.
//      * 
//      * @param property1    a name of the first property to compare.
//      * @param operation    a comparison operation: "==" ("=", "EQ"), "!= " ("<>", "NE"); "<"/">" ("LT"/"GT"), "<="/">=" ("LE"/"GE"); "LIKE".
//      * @param property2    a name of the second property to compare.
//      * 
//      * @see [[ObjectComparator.compare]]
//      */
//     public constructor(property1: string, operation: string, property2: string) {
//         this._property1 = property1;
//         this._property2 = property2;
//         this._operation = operation;
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
//         let value1 = ObjectReader.getProperty(value, this._property1);
//         let value2 = ObjectReader.getProperty(value, this._property2);

//         if (!ObjectComparator.compare(value1, this._operation, value2)) {
//             results.push(
//                 new ValidationResult(
//                     path,
//                     ValidationResultType.Error,
//                     "PROPERTIES_NOT_MATCH",
//                     name + " must have " + this._property1 + " " + this._operation + " " + this._property2,
//                     value2,
//                     value1
//                 )
//             );
//         }
//     }

// }
