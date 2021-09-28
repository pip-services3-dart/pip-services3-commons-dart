import 'package:pip_services3_commons/src/reflect/RecursiveObjectReader.dart';
import 'package:test/test.dart';

void main() {
  group('RecursiveObjectReader', () {
    test('Has Property', () {
      var obj = {
        'value1': 123,
        'value2': {'value21': 111, 'value22': 222},
        'value3': [
          444,
          {'value311': 555}
        ]
      };

      var has = RecursiveObjectReader.hasProperty(obj, '');
      expect(has, isFalse);

      has = RecursiveObjectReader.hasProperty(obj, 'value1');
      expect(has, isTrue);

      has = RecursiveObjectReader.hasProperty(obj, 'value2');
      expect(has, isTrue);

      has = RecursiveObjectReader.hasProperty(obj, 'value2.value21');
      expect(has, isTrue);

      has = RecursiveObjectReader.hasProperty(obj, 'value2.value31');
      expect(has, isFalse);

      has = RecursiveObjectReader.hasProperty(obj, 'value2.value21.value211');
      expect(has, isFalse);

      has = RecursiveObjectReader.hasProperty(obj, 'valueA.valueB.valueC');
      expect(has, isFalse);

      has = RecursiveObjectReader.hasProperty(obj, 'value3');
      expect(has, isTrue);

      has = RecursiveObjectReader.hasProperty(obj, 'value3.0');
      expect(has, isTrue);

      has = RecursiveObjectReader.hasProperty(obj, 'value3.0.value311');
      expect(has, isFalse);

      has = RecursiveObjectReader.hasProperty(obj, 'value3.1');
      expect(has, isTrue);

      has = RecursiveObjectReader.hasProperty(obj, 'value3.1.value311');
      expect(has, isTrue);

      has = RecursiveObjectReader.hasProperty(obj, 'value3.2');
      expect(has, isFalse);
    });

    test('Get Property', () {
      var obj = {
        'value1': 123,
        'value2': {'value21': 111, 'value22': 222},
        'value3': [
          444,
          {'value311': 555}
        ]
      };

      var value = RecursiveObjectReader.getProperty(obj, '');
      expect(value, isNull);

      value = RecursiveObjectReader.getProperty(obj, 'value1');
      expect(value, equals(123));

      value = RecursiveObjectReader.getProperty(obj, 'value2');
      expect(value, isNotNull);

      value = RecursiveObjectReader.getProperty(obj, 'value2.value21');
      expect(value, equals(111));

      value = RecursiveObjectReader.getProperty(obj, 'value2.value31');
      expect(value, isNull);

      value = RecursiveObjectReader.getProperty(obj, 'value2.value21.value211');
      expect(value, isNull);

      value = RecursiveObjectReader.getProperty(obj, 'valueA.valueB.valueC');
      expect(value, isNull);

      value = RecursiveObjectReader.getProperty(obj, 'value3');
      expect(value, isNotNull);

      value = RecursiveObjectReader.getProperty(obj, 'value3.0');
      expect(value, equals(444));

      value = RecursiveObjectReader.getProperty(obj, 'value3.0.value311');
      expect(value, isNull);

      value = RecursiveObjectReader.getProperty(obj, 'value3.1');
      expect(value, isNotNull);

      value = RecursiveObjectReader.getProperty(obj, 'value3.1.value311');
      expect(value, equals(555));

      value = RecursiveObjectReader.getProperty(obj, 'value3.2');
      expect(value, isNull);
    });

    test('Get Property Names', () {
      var obj = {
        'value1': 123,
        'value2': {'value21': 111, 'value22': 222},
        'value3': [
          444,
          {'value311': 555}
        ]
      };

      var names = RecursiveObjectReader.getPropertyNames(obj);
      expect(names.length, equals(5));
      expect(names, contains('value1'));
      expect(names, contains('value2.value21'));
      expect(names, contains('value2.value22'));
      expect(names, contains('value3.0'));
      expect(names, contains('value3.1.value311'));
    });

    test('Get Properties', () {
      var obj = {
        'value1': 123,
        'value2': {'value21': 111, 'value22': 222},
        'value3': [
          444,
          {'value311': 555}
        ]
      };

      var values = RecursiveObjectReader.getProperties(obj);
      //assert.equal(5, values.length);
      expect(values['value1'], equals(123));
      expect(values['value2.value21'], equals(111));
      expect(values['value2.value22'], equals(222));
      expect(values['value3.0'], equals(444));
      expect(values['value3.1.value311'], equals(555));
    });
  });
}
