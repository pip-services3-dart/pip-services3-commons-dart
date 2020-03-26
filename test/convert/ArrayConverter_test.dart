import 'package:test/test.dart';

import '../../lib/src/convert/ArrayConverter.dart';

void main() {
  group('ArrayConverter', () {
    test('To Array', () {
      var value = ArrayConverter.toArray(null);
      expect(value, isList);
      expect(value.length, equals(0));

      value = ArrayConverter.toArray(123);
      expect(value, isList);
      expect(value.length, equals(1));
      expect(value[0], equals(123));

      value = ArrayConverter.toArray([123]);
      expect(value, isList);
      expect(value.length, equals(1));
      expect(value[0], equals(123));

      value = ArrayConverter.toArray('123');
      expect(value, isList);
      expect(value.length, equals(1));
      expect(value[0], equals('123'));

      value = ArrayConverter.listToArray('123,456');
      expect(value, isList);
      expect(value.length, equals(2));
      expect(value[0], equals('123'));
      expect(value[1], equals('456'));

      value = ArrayConverter.toArray({"field1": "abc", "field2": 123});
      expect(value, isList);
      expect(value.length, equals(2));
      expect(value[0], equals('abc'));
      expect(value[1], equals(123));
    });
  });
}
