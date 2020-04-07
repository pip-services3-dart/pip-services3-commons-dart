import './RandomInteger.dart';

/// Random generator for array objects.
///
/// ### Example ###
///
///     var value1 = RandomArray.pick([1, 2, 3, 4]); // Possible result: 3

class RandomArray {
  /// Picks a random element from specified array.
  ///
  /// - [values]    an array of any type
  /// Returns         a randomly picked item.

  static T pick<T>(List<T> values) {
    if (values == null || values.isEmpty) return null;

    return values[RandomInteger.nextInteger(values.length)];
  }
}
