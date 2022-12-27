import 'package:pip_services3_commons/src/data/MultiString.dart';
import 'package:test/test.dart';

void main() {
  group('MultiString', () {
    test('Get and Set', () {
      var value = MultiString();
      expect(value.get('en'), isNull);

      value.put('ru', 'Russian');
      expect('Russian', value.get('ru'));
      expect('Russian', value.get('en'));
      expect('Russian', value.get('pt'));

      value.put('en', 'English');
      expect('Russian', value.get('ru'));
      expect('English', value.get('en'));
      expect('English', value.get('pt'));
    });
  });
}
