// /** @module random */
// import { RandomInteger } from './RandomInteger';
// import { RandomBoolean } from './RandomBoolean';

// /**
//  * Random generator for string values.
//  *
//  * ### Example ###
//  *
//  *     let value1 = RandomString.pickChar("ABC");     // Possible result: "C"
//  *     let value2 = RandomString.pick(["A","B","C"]); // Possible result: "gBW"
//  */
// export class RandomString {
//     private static readonly _digits = "01234956789";
//     private static readonly _symbols = "_,.:-/.[].{},#-!,$=%.+^.&*-() ";
//     private static readonly _alphaLower = "abcdefghijklmnopqrstuvwxyz";
//     private static readonly _alphaUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//     private static readonly _alpha = RandomString._alphaUpper + RandomString._alphaLower;
//     private static readonly _chars = RandomString._alpha + RandomString._digits + RandomString._symbols;

//     /**
//      * Picks a random character from a string.
//      *
//      * @param values    a string to pick a char from
//      * @returns         a randomly picked char.
//      */
//     public static pickChar(values: string): string {
//         if (values == null || values.length == 0)
//             return '';

//         let index = RandomInteger.nextInteger(values.length);
//         return values.charAt(index);
//     }

//     /**
//      * Picks a random string from an array of string.
//      *
//      * @param values    strings to pick from.
//      * @returns         a randomly picked string.
//      */
//     public static pick(values: string[]): string {
//         if (values == null || values.length == 0)
//             return '';

//         let index = RandomInteger.nextInteger(values.length);
//         return values[index];
//     }

//     /**
//      * Distorts a string by randomly replacing characters in it.
//      *
//      * @param value    a string to distort.
//      * @returns        a distored string.
//      */
//     public static distort(value: string): string {
//         value = value.toLowerCase();

//         //Capitalize the first letter of the string 'value'.
//         if (RandomBoolean.chance(1, 5))
//             value = value.substring(0, 1).toUpperCase() + value.substring(1);

//         //Add a symbol to the end of the string 'value'
//         if (RandomBoolean.chance(1, 3))
//             value = value + RandomString.pickChar(RandomString._symbols);

//         return value;
//     }

//     /**
//      * Generates random alpha characted [A-Za-z]
//      *
//      * @returns a random characted.
//      */
//     public static nextAlphaChar(): string {
//         let index = RandomInteger.nextInteger(RandomString._alpha.length);
//         return RandomString._alpha.charAt(index);
//     }

//     /**
//      * Generates a random string, consisting of upper and lower case letters (of the English alphabet),
//      * digits (0-9), and symbols ("_,.:-/.[].{},#-!,$=%.+^.&*-() ").
//      *
//      * @param minLength     (optional) minimum string length.
//      * @param maxLength     maximum string length.
//      * @returns             a random string.
//      */
//     public static nextString(minLength: number, maxLength: number): string {
//         let result = '';

//         let length = RandomInteger.nextInteger(minLength, maxLength);
//         for (let i = 0; i < length; i++) {
//             let index = RandomInteger.nextInteger(RandomString._chars.length);
//             result += RandomString._chars.charAt(index);
//         }

//         return result;
//     }
// }
