import 'package:test/test.dart';

import './TestClass.dart';
import '../../lib/src/reflect/ObjectReader.dart';

void main() {
  group('ObjectReader', () {
    test('Get Object Property', () {
      var obj =  TestClass();

      var value = ObjectReader.getProperty(obj, 'privateField');
      //assert.isNull(value);

      value = ObjectReader.getProperty(obj, 'publicField');
      expect(value, equals('ABC'));

      value = ObjectReader.getProperty(obj, 'PublicProp');
      expect(value, isNotNull);
    });

    test('Get Map Property', () {
      var map = {'key1': 123, 'key2': 'ABC'};

      var value = ObjectReader.getProperty(map, 'key3');
      expect(value, isNull);

      value = ObjectReader.getProperty(map, 'Key1');
      expect(value, equals(123));

      value = ObjectReader.getProperty(map, 'KEY2');
      expect(value, equals('ABC'));
    });

    test('Get Array Property', () {
      var list = [123, 'ABC'];

      var value = ObjectReader.getProperty(list, '3');
      expect(value, isNull);

      value = ObjectReader.getProperty(list, '0');
      expect(value, equals(123));

      value = ObjectReader.getProperty(list, '1');
      expect(value, equals('ABC'));
    });

    test('Get Object Properties', () {
      var obj =  TestClass();
      var names = ObjectReader.getPropertyNames(obj);
      //assert.equal(2, names.length);
      expect(names.indexOf('publicField') >= 0, isTrue);
      expect(names.indexOf('publicProp') >= 0, isTrue);

      var map = ObjectReader.getProperties(obj);
      //assert.equals(2, map.length);
      expect(map['publicField'], equals('ABC'));
      expect(map['publicProp'], isNotNull);
    });

    test('Get Map Properties', () {
      var map = {'key1': 123, 'key2': 'ABC'};
      var names = ObjectReader.getPropertyNames(map);
      expect(names.length, equals(2));
      expect(names.indexOf('key1') >= 0, isTrue);
      expect(names.indexOf('key2') >= 0, isTrue);

      var values = ObjectReader.getProperties(map);
      //assert.equal(2, values.lemgth);
      expect(values['key1'], equals(123));
      expect(values['key2'], equals('ABC'));
    });

    test('Get Array Properties', () {
      var list = [123, 'ABC'];

      var names = ObjectReader.getPropertyNames(list);
      expect(names.length, equals(2));
      expect(names.indexOf('0') >= 0, isTrue);
      expect(names.indexOf('1') >= 0, isTrue);

      var values = ObjectReader.getProperties(list);
      //assert.equal(2, values.lenth);
      expect(values['0'], equals(123));
      expect(values['1'], equals('ABC'));

      var array = [123, 'ABC'];

      names = ObjectReader.getPropertyNames(array);
      expect(names.length, equals(2));
      expect(names.indexOf('0') >= 0, isTrue);
      expect(names.indexOf('1') >= 0, isTrue);

      values = ObjectReader.getProperties(array);
      //assert.equal(2, values.length);
      expect(values['0'], equals(123));
      expect(values['1'], equals('ABC'));
    });
  });
}
