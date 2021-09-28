import 'package:pip_services3_commons/src/random/RandomArray.dart';
import 'package:test/test.dart';

void main() {
  group('RandomArray', () {
    test('Pick', () {
      var listEmpty = [];
      var value = RandomArray.pick(listEmpty);
      expect(value, isNull);

      var array = [1, 2];
      value = RandomArray.pick<int>(array);
      expect(value == 1 || value == 2, isTrue);

      var list = [];
      expect(RandomArray.pick(list), isNull);

      list = [1, 2];
      value = RandomArray.pick(array);
      expect(value == 1 || value == 2, isTrue);
    });
  });
}
