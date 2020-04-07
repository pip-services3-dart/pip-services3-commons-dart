import 'dart:math';

/// Random generator for float values.

/// ### Example ###

///     var value1 = RandomFloat.nextFloat(5, 10);     // Possible result: 7.3
///     var value2 = RandomFloat.nextFloat(10);        // Possible result: 3.7
///     var value3 = RandomFloat.updateFloat(10, 3);   // Possible result: 9.2

class RandomFloat {
  static final _random = Random();

  /// Generates a float in the range ['min', 'max']. If 'max' is omitted, then the range will be set to [0, 'min'].

  /// - [min]   minimum value of the float that will be generated.
  ///              If 'max' is omitted, then 'max' is set to 'min' and 'min' is set to 0.
  /// - [max]   (optional) maximum value of the float that will be generated. Defaults to 'min' if omitted.
  /// Returns     generated random float value.

  static double nextFloat(double min, [double max]) {
    if (max == null) {
      max = min;
      min = 0;
    }

    if (max - min <= 0) return min;

    return min + _random.nextDouble() * (max - min);
  }

  /// Updates (drifts) a float value within specified range defined

  /// - [value]     a float value to drift.
  /// - [range]     (optional) a range. Default: 10% of the value

  static double updateFloat(double value, [double range]) {
    range ??= 0;
    range = range == 0 ? 0.1 * value : range;
    var minValue = value - range;
    var maxValue = value + range;
    return RandomFloat.nextFloat(minValue, maxValue);
  }
}
