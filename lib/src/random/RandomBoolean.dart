import 'dart:math';

/// Random generator for boolean values.
///
/// ### Example ###
///
///     var value1 = RandomBoolean.nextBoolean();    // Possible result: true
///     var value2 = RandomBoolean.chance(1,3);      // Possible result: false

class RandomBoolean {
  static final _random = Random();

  /// Calculates 'chance' out of 'max chances'.
  /// Example: 1 chance out of 3 chances (or 33.3%)
  ///
  /// - [chance]       a chance proportional to maxChances.
  /// - [maxChances]   a maximum number of chances

  static bool chance(double chance, double maxChances) {
    chance = chance >= 0 ? chance : 0;
    maxChances = maxChances >= 0 ? maxChances : 0;
    if (chance == 0 && maxChances == 0) return false;

    maxChances = max(maxChances, chance);
    var start = (maxChances - chance) / 2;
    var end = start + chance;
    var hit = _random.nextDouble() * maxChances;
    return hit >= start && hit <= end;
  }

  /// Generates a random boolean value.
  ///
  /// Returns a random boolean.

  static bool nextBoolean() {
    return _random.nextBool();
  }
}
