import 'dart:math';

/// Random generator for integer values.
///
/// ### Example ###
///
///     var value1 = RandomInteger.nextInteger(5, 10);     // Possible result: 7
///     var value2 = RandomInteger.nextInteger(10);        // Possible result: 3
///     var value3 = RandomInteger.updateInteger(10, 3);   // Possible result: 9

class RandomInteger {
  static final _random = Random();

  /// Generates a integer in the range ['min', 'max']. If 'max' is omitted, then the range will be set to [0, 'min'].
  ///
  /// - [min]   minimum value of the integer that will be generated.
  ///              If 'max' is omitted, then 'max' is set to 'min' and 'min' is set to 0.
  /// - [max]   (optional) maximum value of the float that will be generated. Defaults to 'min' if omitted.
  /// Returns     generated random integer value.

  static int nextInteger(int min, [int? max]) {
    if (max == null) {
      max = min;
      min = 0;
    }

    if (max - min <= 0) return min;

    return (min + _random.nextDouble() * (max - min)).floor();
  }

  /// Updates (drifts) a integer value within specified range defined
  ///
  /// - [value]     a integer value to drift.
  /// - [range]     (optional) a range. Default: 10% of the value

  static int updateInteger(int value, [int? range]) {
    range ??= 0;
    range = range == 0 ? (0.1 * value).floor() : range;
    var minValue = value - range;
    var maxValue = value + range;
    return RandomInteger.nextInteger(minValue, maxValue);
  }

  /// Generates a random sequence of integers starting from 0 like: [0,1,2,3...??]
  ///
  /// - [min]   minimum value of the integer that will be generated.
  ///              If 'max' is omitted, then 'max' is set to 'min' and 'min' is set to 0.
  /// - [max]   (optional) maximum value of the float that will be generated. Defaults to 'min' if omitted.
  /// Returns     generated array of integers.

  static List<int> sequence(int min, [int? max]) {
    max = max ?? min;
    var count = RandomInteger.nextInteger(min, max);

    var result = <int>[];
    for (var i = 0; i < count; i++) {
      result.add(i);
    }

    return result;
  }
}
