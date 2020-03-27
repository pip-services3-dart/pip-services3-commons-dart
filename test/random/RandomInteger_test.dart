import 'package:test/test.dart';

import '../../lib/src/random/RandomInteger.dart';

void main() {
  group('RandomInteger', () {
    test('Next Integer', () {
      var value = RandomInteger.nextInteger(5);
      expect(value, lessThanOrEqualTo(5));

      value = RandomInteger.nextInteger(2, 5);
      expect(value <= 5 && value >= 2, isTrue);
    });

    test('Update Integer', () {
      var value = RandomInteger.updateInteger(0, 5);
      expect(value <= 5 && value >= -5, isTrue);

      value = RandomInteger.updateInteger(5, 0);
      expect(value == 5, isTrue);

      value = RandomInteger.updateInteger(0);
      expect(value == 0, isTrue);
    });

    test('Sequence', () {
      var list = RandomInteger.sequence(1, 5);
      expect(list.length <= 5 && list.length >= 1, isTrue);

      list = RandomInteger.sequence(-1, 0);
      expect(list.length == 0, isTrue);

      list = RandomInteger.sequence(-1, -4);
      expect(list.length == 0, isTrue);

      list = RandomInteger.sequence(4, 4);
      expect(list.length == 4, isTrue);

      list = RandomInteger.sequence(5);
      expect(list.length == 5, isTrue);
    });
  });
}
