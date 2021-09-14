import 'package:test/test.dart';

import './TestClass.dart';
import '../../lib/src/reflect/ObjectWriter.dart';

void main() {
  group('ObjectWriter', () {
    test('Set Object Property', () {
      var obj = TestClass();

      ObjectWriter.setProperty(obj, 'privateField', 'XYZ');

      ObjectWriter.setProperty(obj, 'publicField', 'AAAA');
      expect(obj.publicField, equals('AAAA'));

      var now = DateTime.now().toUtc();
      ObjectWriter.setProperty(obj, 'publicProp', now);
      expect(obj.publicProp, equals(now));

      ObjectWriter.setProperty(obj, 'publicProp', 'BBBB');
      expect(obj.publicProp, equals(now));
    });

    test('Set Map Property', () {
      var map = {'key1': 123, 'key2': 'ABC'};

      ObjectWriter.setProperty(map, 'key3', 'AAAA');
      expect(map['key3'], equals('AAAA'));

      ObjectWriter.setProperty(map, 'Key1', 5555);
      expect(map['key1'], equals(5555));

      ObjectWriter.setProperty(map, 'Key2', 'BBBB');
      expect(map['key2'], equals('BBBB'));
    });

    test('Set Array Property', () {
      var list = <dynamic>[123, 'ABC'];

      ObjectWriter.setProperty(list, '3', 'AAAA');
      expect(list.length, equals(4));
      expect(list[3], equals('AAAA'));

      ObjectWriter.setProperty(list, '0', 1111);
      expect(list[0], equals(1111));

      ObjectWriter.setProperty(list, '1', 'BBBB');
      expect(list[1], equals('BBBB'));

      var array = [123, 'ABC'];

      ObjectWriter.setProperty(array, '3', 'AAAA');
      expect(list.length, equals(4));

      ObjectWriter.setProperty(array, '0', 1111);
      expect(list[0], equals(1111));

      ObjectWriter.setProperty(array, '1', 'BBBB');
      expect(list[1], equals('BBBB'));
    });
  });
}
