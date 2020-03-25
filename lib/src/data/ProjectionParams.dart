// /** @module data */
// import { AnyValueArray } from "./AnyValueArray";
// /** @hidden */ 
// const _ = require('lodash');

// /**
//  * Defines projection parameters with list if fields to include into query results.
//  * 
//  * The parameters support two formats: dot format and nested format.
//  * 
//  * The dot format is the standard way to define included fields and subfields using
//  * dot object notation: <code>"field1,field2.field21,field2.field22.field221"</code>.
//  * 
//  * As alternative the nested format offers a more compact representation:
//  * <code>"field1,field2(field21,field22(field221))"</code>.
//  * 
//  * ### Example ###
//  * 
//  *     let filter = FilterParams.fromTuples("type", "Type1");
//  *     let paging = new PagingParams(0, 100);
//  *     let projection = ProjectionParams.fromString("field1,field2(field21,field22)")
//  *     
//  *     myDataClient.getDataByFilter(filter, paging, projection, (err, page) => {...});
//  * 
//  */
// export class ProjectionParams extends Array<string> {

//     /**
//      * Creates a new instance of the projection parameters and assigns its value.
//      * 
//      * @param value     (optional) values to initialize this object.
//      */
//     public constructor(values: any[] = null) {
//         super();

//         // Set the prototype explicitly.
//         // https://github.com/Microsoft/TypeScript-wiki/blob/master/Breaking-Changes.md#extending-built-ins-like-error-array-and-map-may-no-longer-work
//         (<any>this).__proto__ = ProjectionParams.prototype;

//         if (values != null) {
//             for (let value of values)
//                 this.push("" + value);
//         }
//     }

//     /** 
//      * Gets a string representation of the object.
//      * The result is a comma-separated list of projection fields
//      * "field1,field2.field21,field2.field22.field221"
//      * 
//      * @returns a string representation of the object.
//      */
//     public toString(): string {
//         let builder = "";

//         for (let index = 0; index < this.length; index++) {
//             if (index > 0) {
//                 builder += ',';
//             }

//             builder += this[index];
//         }

//         return builder;
//     }

//     private static parseValue(prefix: string, result: ProjectionParams, value: string): void {
//         value = value.trim();

//         let openBracket = 0;
//         let openBracketIndex = -1;
//         let closeBracketIndex = -1;
//         let commaIndex = -1;

//         let breakCycleRequired = false;
//         for (let index = 0; index < value.length; index++) {
//             switch (value[index]) {
//                 case '(':
//                     if (openBracket == 0) {
//                         openBracketIndex = index;
//                     }

//                     openBracket++;
//                     break;
//                 case ')':
//                     openBracket--;

//                     if (openBracket == 0) {
//                         closeBracketIndex = index;

//                         if (openBracketIndex >= 0 && closeBracketIndex > 0) {
//                             let previousPrefix = prefix;

//                             if (prefix && prefix.length > 0) {
//                                 prefix = prefix + "." + value.substring(0, openBracketIndex);
//                             } else {
//                                 prefix = value.substring(0, openBracketIndex);
//                             }

//                             let subValue = value.substring(openBracketIndex + 1, closeBracketIndex);
//                             this.parseValue(prefix, result, subValue);

//                             subValue = value.substring(closeBracketIndex + 1);
//                             this.parseValue(previousPrefix, result, subValue);
//                             breakCycleRequired = true;
//                         }
//                     }
//                     break;
//                 case ',':
//                     if (openBracket == 0) {
//                         commaIndex = index;

//                         let subValue = value.substring(0, commaIndex);

//                         if (subValue && subValue.length > 0) {
//                             if (prefix && prefix.length > 0) {
//                                 result.push(prefix + "." + subValue);
//                             } else {
//                                 result.push(subValue);
//                             }
//                         }

//                         subValue = value.substring(commaIndex + 1);

//                         if (subValue && subValue.length > 0) {
//                             this.parseValue(prefix, result, subValue);
//                             breakCycleRequired = true;
//                         }
//                     }
//                     break;
//             }

//             if (breakCycleRequired) {
//                 break;
//             }
//         }

//         if (value && value.length > 0 && openBracketIndex == -1 && commaIndex == -1) {
//             if (prefix && prefix.length > 0) {
//                 result.push(prefix + "." + value);
//             } else {
//                 result.push(value);
//             }
//         }
//     }

//     /**
//      * Converts specified value into ProjectionParams.
//      * 
//      * @param value     value to be converted
//      * @returns         a newly created ProjectionParams.
//      * 
//      * @see [[AnyValueArray.fromValue]]
//      */
//     public static fromValue(value: any): ProjectionParams {
//         if (!_.isArray(value))
//             value = AnyValueArray.fromValue(value);

//         return new ProjectionParams(value);
//     }

//     /**
//      * Parses comma-separated list of projection fields.
//      * 
//      * @param values    one or more comma-separated lists of projection fields
//      * @returns         a newly created ProjectionParams.
//      */
//     public static fromString(...values: string[]) {
//         let result = new ProjectionParams();

//         for (let value of values) {
//             this.parseValue("", result, value);
//         }

//         return result;    
//     }

// }