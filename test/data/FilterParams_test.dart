import 'package:test/test.dart';
import '../../lib/src/data/FilterParams.dart';

void main() {
  group('FilterParams', () {
    test('Create empty FilterParams (regular)', () {
      var filter = FilterParams();

      filter['key'] = 'key1';
      filter['id'] = '1234';
      expect('key1', filter['key']);
      expect('1234', filter['id']);
    });

    test('Create FilterParams with set values', () {
      var keys = <String, dynamic>{};
      keys['key'] = 'key1';
      keys['id'] = '1234';
      var filter = FilterParams(keys);
      expect('key1', filter['key']);
      expect('1234', filter['id']);
    });

    test('JSON convert', () {
      var keys = <String, dynamic>{};
      keys['key'] = 'key1';
      keys['id'] = '1234';
      var filter = FilterParams(keys);
      expect('key1', filter['key']);
      expect('1234', filter['id']);

      var json = filter.toJson();
      var filter2 = FilterParams.fromJson(json);

      expect('key1', filter2['key']);
      expect('1234', filter2['id']);
    });
  });
}
