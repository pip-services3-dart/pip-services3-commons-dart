// /** @module random */

// /**
//  * Random generator for float values.
//  *
//  * ### Example ###
//  *
//  *     let value1 = RandomFloat.nextFloat(5, 10);     // Possible result: 7.3
//  *     let value2 = RandomFloat.nextFloat(10);        // Possible result: 3.7
//  *     let value3 = RandomFloat.updateFloat(10, 3);   // Possible result: 9.2
//  */
// export class RandomFloat {

//     /**
//      * Generates a float in the range ['min', 'max']. If 'max' is omitted, then the range will be set to [0, 'min'].
//      *
//      * @param min   minimum value of the float that will be generated.
//      *              If 'max' is omitted, then 'max' is set to 'min' and 'min' is set to 0.
//      * @param max   (optional) maximum value of the float that will be generated. Defaults to 'min' if omitted.
//      * @returns     generated random float value.
//      */
//     public static nextFloat(min: number, max: number = null): number {
//         if (max == null) {
//             max = min;
//             min = 0;
//         }

//         if (max - min <= 0)
//             return min;

//         return min + Math.random() * (max - min);
//     }

//     /**
//      * Updates (drifts) a float value within specified range defined
//      *
//      * @param value     a float value to drift.
//      * @param range     (optional) a range. Default: 10% of the value
//      */
//     public static updateFloat(value: number, range: number = null): number {
//         if (range == null) range = 0;
//         range = range == 0 ? 0.1 * value : range;
//         let minValue = value - range;
//         let maxValue = value + range;
//         return RandomFloat.nextFloat(minValue, maxValue);
//     }
// }
