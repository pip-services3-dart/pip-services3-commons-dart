import './RandomInteger.dart';
import './RandomBoolean.dart';

/// Random generator for string values.

/// ### Example ###

///     var value1 = RandomString.pickChar('ABC');     // Possible result: 'C'
///     var value2 = RandomString.pick(['A','B','C']); // Possible result: 'gBW'

class RandomString {
  static var _digits = '01234956789';
  static var _symbols = '_,.:-/.[].{},#-!,\$=%.+^.&*-() ';
  static var _alphaLower = 'abcdefghijklmnopqrstuvwxyz';
  static var _alphaUpper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static var _alpha = RandomString._alphaUpper + RandomString._alphaLower;
  static var _chars =
      RandomString._alpha + RandomString._digits + RandomString._symbols;

  /// Picks a random character from a string.

  /// - [values]    a string to pick a char from
  /// Returns         a randomly picked char.

  static String pickChar(String values) {
    if (values == null || values.length == 0) return '';

    var index = RandomInteger.nextInteger(values.length);
    return values.substring(index, index + 1);
  }

  /// Picks a random string from an array of string.

  /// - [values]    strings to pick from.
  /// Returns         a randomly picked string.

  static String pick(List<String> values) {
    if (values == null || values.length == 0) return '';

    var index = RandomInteger.nextInteger(values.length);
    return values[index];
  }

  /// Distorts a string by randomly replacing characters in it.

  /// - [value]    a string to distort.
  /// Returns        a distored string.

  static String distort(String value) {
    value = value.toLowerCase();

    //Capitalize the first letter of the string 'value'.
    if (RandomBoolean.chance(1, 5))
      value = value.substring(0, 1).toUpperCase() + value.substring(1);

    //Add a symbol to the end of the string 'value'
    if (RandomBoolean.chance(1, 3))
      value = value + RandomString.pickChar(RandomString._symbols);

    return value;
  }

  /// Generates random alpha characted [A-Za-z]

  /// Returns a random characted.

  static String nextAlphaChar() {
    var index = RandomInteger.nextInteger(RandomString._alpha.length);
    return RandomString._alpha.substring(index, index + 1);
  }

  /// Generates a random string, consisting of upper and lower case letters (of the English alphabet),
  /// digits (0-9), and symbols ('_,.:-/.[].{},#-!,$=%.+^.&*-() ').

  /// - [minLength]     (optional) minimum string length.
  /// - [maxLength]     maximum string length.
  /// Returns             a random string.

  static String nextString(int minLength, int maxLength) {
    var result = '';

    var length = RandomInteger.nextInteger(minLength, maxLength);
    for (var i = 0; i < length; i++) {
      var index = RandomInteger.nextInteger(RandomString._chars.length);
      result += RandomString._chars.substring(index, index + 1);
    }

    return result;
  }
}
