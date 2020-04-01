import './RandomInteger.dart';

/// Random generator for Duration values.

/// ### Example ###

///     var value2 = RandomDuration.nextDuration( Duration(1000));// Possible result: 532
///     var value3 = RandomDuration.updateDuration( Duration(100000));// Possible result: 53223

class RandomDuration {
  /// Generates a random Duration in the range ['min', 'max'].

  /// - [min]   (optional) minimum range value
  /// - [max]   max range value
  /// Returns     a random Date value.

  static Duration nextDuration(Duration min, [Duration max = null]) {
    if (max == null) {
      max = min;
      min = Duration(milliseconds: max.inMilliseconds - 10000);
    }

    var diff = max.inMilliseconds - min.inMilliseconds;
    if (diff <= 0) return min;

    var time = min.inMilliseconds + RandomInteger.nextInteger(0, diff);
    return Duration(milliseconds: time);
  }

  /// Updates (drifts) a Date value within specified range defined

  /// - [value]     a Date value to drift.
  /// - [range]     (optional) a range in milliseconds. Default: 10 days

  static Duration updateDuration(Duration value, [int range = null]) {
    range = range ?? (value.inMilliseconds / 10).truncate();
    if (range < 0) return value;

    var time = value.inMilliseconds + RandomInteger.nextInteger(-range, range);
    time = time > 0 ? time : 0;
    return Duration(milliseconds: time);
  }
}
