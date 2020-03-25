// /** @module reflect */
// /** @hidden */ 
// let _ = require('lodash');

// import { TypeCode } from '../convert/TypeCode';
// import { TypeConverter } from '../convert/TypeConverter';
// import { DateTimeConverter } from '../convert';

// /**
//  * Helper class matches value types for equality.
//  * 
//  * This class has symmetric implementation across all languages supported
//  * by Pip.Services toolkit and used to support dynamic data processing.
//  * 
//  * @see [[TypeCode]]
//  */
// export class TypeMatcher {
    
//     /**
//      * Matches expected type to a type of a value.
//      * The expected type can be specified by a type, type name or [[TypeCode]].
//      * 
//      * @param expectedType      an expected type to match.
//      * @param actualValue       a value to match its type to the expected one.
//      * @returns true if types are matching and false if they don't.
//      * 
//      * @see [[matchType]]
//      * @see [[matchValueTypeByName]] (for matching by types' string names)
//      */
//     public static matchValueType(expectedType: any, actualValue: any): boolean {
//         if (expectedType == null)
//             return true;
//         if (actualValue == null)
//         	throw new Error("Actual value cannot be null");

//         return TypeMatcher.matchType(expectedType, TypeConverter.toTypeCode(actualValue));
//     }

//     /**
//      * Matches expected type to an actual type.
//      * The types can be specified as types, type names or [[TypeCode]].
//      * 
//      * @param expectedType  an expected type to match.
//      * @param actualType    an actual type to match.
//      * @param actualValue   an optional value to match its type to the expected one.
//      * @returns true if types are matching and false if they don't.
//      * 
//      * @see [[matchTypeByName]]
//      * @see [[matchTypeByName]] (for matching by types' string names)
//      */
//     public static matchType(expectedType: any, actualType: TypeCode, actualValue: any = null): boolean {
//         if (expectedType == null)
//             return true;
//         if (actualType == null)
//         	throw new Error("Actual type cannot be null");

//         if (_.isInteger(expectedType)) {
//             if (expectedType == actualType)
//                 return true;
//             // Special provisions for dynamic data
//             if (expectedType == TypeCode.Integer 
//                 && (actualType == TypeCode.Long || actualType == TypeCode.Float || actualType == TypeCode.Double))
//                 return true;
//             if (expectedType == TypeCode.Long 
//                 && (actualType == TypeCode.Integer || actualType == TypeCode.Float || actualType == TypeCode.Double))
//                 return true;
//             if (expectedType == TypeCode.Float 
//                 && (actualType == TypeCode.Integer || actualType == TypeCode.Long || actualType == TypeCode.Double))
//                 return true;
//             if (expectedType == TypeCode.Double
//                 && (actualType == TypeCode.Integer || actualType == TypeCode.Long || actualType == TypeCode.Float))
//                 return true;
//             if (expectedType == TypeCode.DateTime
//                 && (actualType == TypeCode.String && DateTimeConverter.toNullableDateTime(actualValue) != null))
//                 return true;
//             return false;
//         }
        
//         if (_.isString(expectedType))
//             return TypeMatcher.matchTypeByName(expectedType, actualType, actualValue);

//         return false;
//     }

//     /**
//      * Matches expected type to a type of a value.
//      * 
//      * @param expectedType  an expected type name to match.
//      * @param actualValue       a value to match its type to the expected one.
//      * @returns true if types are matching and false if they don't.
//      */
//     public static matchValueTypeByName(expectedType: string, actualValue: any): boolean {
//         if (expectedType == null) 
//         	return true;
//         if (actualValue == null)
//         	throw new Error("Actual value cannot be null");

//         return TypeMatcher.matchTypeByName(expectedType, TypeConverter.toTypeCode(actualValue));
//     }

//     /**
//      * Matches expected type to an actual type.
//      * 
//      * @param expectedType  an expected type name to match.
//      * @param actualType    an actual type to match defined by type code.
//      * @param actualValue   an optional value to match its type to the expected one.
//      * @returns true if types are matching and false if they don't.
//      */
//     public static matchTypeByName(expectedType: string, actualType: TypeCode, actualValue: any = null): boolean {
//         if (expectedType == null)
//         	return true;
//         if (actualType == null)
//         	throw new Error("Actual type cannot be null");
        
//         expectedType = expectedType.toLowerCase();

//         if (expectedType == "object")
//             return true;
//         else if (expectedType == "int" || expectedType == "integer") {
//             return actualType == TypeCode.Integer
//                 // Special provisions for dynamic data
//                 || actualType == TypeCode.Long;
//         } else if (expectedType == "long") {
//             return actualType == TypeCode.Long
//                 // Special provisions for dynamic data
//                 || actualType == TypeCode.Integer;
//         } else if (expectedType == "float") {
//             return actualType == TypeCode.Float
//                 // Special provisions for dynamic data
//                 || actualType == TypeCode.Double
//                 || actualType == TypeCode.Integer
//                 || actualType == TypeCode.Long;
//         } else if (expectedType == "double") {
//             return actualType == TypeCode.Double
//                 // Special provisions fro dynamic data
//                 || actualType == TypeCode.Float;
//         } else if (expectedType == "string") {
//             return actualType == TypeCode.String;
//         } else if (expectedType == "bool" || expectedType == "boolean") {
//             return actualType == TypeCode.Boolean;
//         } else if (expectedType == "date" || expectedType == "datetime") {
//             return actualType == TypeCode.DateTime
//                 // Special provisions fro dynamic data
//                 || (actualType == TypeCode.String && DateTimeConverter.toNullableDateTime(actualValue) != null);
//         } else if (expectedType == "timespan" || expectedType == "duration") {
//             return actualType == TypeCode.Integer
//                 || actualType == TypeCode.Long
//                 || actualType == TypeCode.Float
//                 || actualType == TypeCode.Double;
//         } else if (expectedType == "enum") {
//             return actualType == TypeCode.Integer 
//                 || actualType == TypeCode.String;
//         } else if (expectedType == "map" || expectedType == "dict" || expectedType == "dictionary") {
//             return actualType == TypeCode.Map;
//         } else if (expectedType == "array" || expectedType == "list") {
//             return actualType == TypeCode.Array;
//         } else if (_.endsWith(expectedType, "[]")) {
//         	// Todo: Check subtype
//             return actualType == TypeCode.Array;
//         } else
//             return false;
//     }
// }
