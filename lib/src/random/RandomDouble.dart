import 'dart:math';

/**
 * Random generator for double values.
 *
 * ### Example ###
 *
 *     let value1 = RandomDouble.nextDouble(5, 10);     // Possible result: 7.3
 *     let value2 = RandomDouble.nextDouble(10);        // Possible result: 3.7
 *     let value3 = RandomDouble.updateDouble(10, 3);   // Possible result: 9.2
 */
class RandomDouble {
  static var _random = new Random();

  /**
     * Generates a random double value in the range ['minYear', 'maxYear'].
     *
     * @param min   (optional) minimum range value
     * @param max   max range value
     * @returns     a random double value.
     */
  static double nextDouble(double min, [double max = null]) {
    if (max == null) {
      max = min;
      min = 0;
    }

    if (max - min <= 0) return min;

    return min + _random.nextDouble() * (max - min);
  }

  /**
     * Updates (drifts) a double value within specified range defined
     *
     * @param value     a double value to drift.
     * @param range     (optional) a range. Default: 10% of the value
     */
  static double updateDouble(double value, [double range = null]) {
    if (range == null) range = 0;
    range = range == 0 ? 0.1 * value : range;
    var minValue = value - range;
    var maxValue = value + range;
    return RandomDouble.nextDouble(minValue, maxValue);
  }
}
