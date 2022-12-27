import 'dart:core';
import 'dart:math';
import 'package:uuid/uuid.dart';

/// Helper class to generate unique object IDs.
/// It supports two types of IDs: long and short.
///
/// Long IDs are string GUIDs. They are globally unique and 32-character long.
///
/// ShortIDs are just 9-digit random numbers. They are not guaranteed be unique.
///
/// ### Example ###
///
///     IdGenerator.nextLong();      // Possible result: '234ab342c56a2b49c2ab42bf23ff991ac'
///     IdGenerator.nextShort();     // Possible result: '23495247'
///

class IdGenerator {
  /// Generates a random 9-digit random ID (code).
  ///
  /// Remember: The returned value is not guaranteed to be unique.
  ///
  /// Returns a generated random 9-digit code

  static String nextShort() {
    return (100000000 + Random().nextDouble() * 899999999.0).ceil().toString();
  }

  /// Generates a globally unique 32-digit object ID.
  /// The value is a string representation of a GUID value.
  ///
  /// Returns a generated 32-digit object ID

  static String nextLong() {
    var uuid = Uuid();
    var id = uuid.v4();
    return id.replaceAll('-', '');
  }
}
