import 'package:test/test.dart';

import '../../lib/src/convert/MapConverter.dart';

void main() {
  group('MapConverter', () {
    test('To Nullable Map', () {
      expect(MapConverter.toNullableMap(null), isNull);
      expect(MapConverter.toNullableMap(5), isNull);

      var array = [1, 2];
      var map = MapConverter.toNullableMap(array);
      expect(map, isNotNull);
      expect(map['0'], equals(1));
      expect(map['1'], equals(2));

      var obj = {'field1': 'abc', 'field2': 123};
      map = MapConverter.toNullableMap(obj);
      expect(map, isNotNull);
      expect(map['field1'], equals('abc'));
      expect(map['field2'], equals(123));

      expect(MapConverter.toNullableMap(null), isNull);
      expect(MapConverter.toNullableMap('xyz'), isNull);
    });
  });
}
