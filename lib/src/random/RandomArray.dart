import './RandomInteger.dart';

/**
 * Random generator for array objects.
 * 
 * ### Example ###
 * 
 *     let value1 = RandomArray.pick([1, 2, 3, 4]); // Possible result: 3
 */
class RandomArray {
  /**
     * Picks a random element from specified array.
     * 
     * @param values    an array of any type
     * @returns         a randomly picked item.
     */
  static T pick<T>(List<T> values) {
    if (values == null || values.length == 0) return null;

    return values[RandomInteger.nextInteger(values.length)];
  }
}
