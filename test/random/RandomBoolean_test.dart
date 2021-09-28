import 'package:pip_services3_commons/src/random/RandomBoolean.dart';
import 'package:test/test.dart';

void main() {
  group('RandomBoolean', () {
    test('Chance', () {
      var value = RandomBoolean.chance(5, 10);
      expect(value || !value, isTrue);

      value = RandomBoolean.chance(5, 5);
      expect(value || !value, isTrue);

      value = RandomBoolean.chance(0, 0);
      expect(!value, isTrue);

      value = RandomBoolean.chance(-1, 0);
      expect(!value, isTrue);

      value = RandomBoolean.chance(-1, -1);
      expect(!value, isTrue);
    });
  });
}
