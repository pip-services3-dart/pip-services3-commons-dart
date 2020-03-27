import 'package:test/test.dart';

import '../../lib/src/random/RandomDouble.dart';

void main() {
  group('RandomDouble', () {
    test('Next Double', () {
      var value = RandomDouble.nextDouble(5);
      expect(value <= 5, isTrue);

      value = RandomDouble.nextDouble(2, 5);
      expect(value <= 5 && value >= 2, isTrue);
    });

    test('Update Double', () {
      var value = RandomDouble.updateDouble(0, 5);
      expect(value <= 5 && value >= -5, isTrue);

      value = RandomDouble.updateDouble(5, 0);

      value = RandomDouble.updateDouble(0);
      expect(value == 0, isTrue);
    });
  });
}
