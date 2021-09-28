import 'package:pip_services3_commons/src/random/RandomFloat.dart';
import 'package:test/test.dart';

void main() {
  group('RandomFloat', () {
    test('Next Float', () {
      var value = RandomFloat.nextFloat(5);
      expect(value <= 5, isTrue);

      value = RandomFloat.nextFloat(2, 5);
      expect(value <= 5 && value >= 2, isTrue);
    });

    test('Update Float', () {
      var value = RandomFloat.updateFloat(0, 5);
      expect(value <= 5 && value >= -5, isTrue);

      value = RandomFloat.updateFloat(5, 0);
      expect(value >= 4.5 && value <= 5.5, isTrue);

      value = RandomFloat.updateFloat(0);
      expect(value == 0, isTrue);
    });
  });
}
