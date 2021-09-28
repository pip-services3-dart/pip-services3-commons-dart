import 'package:pip_services3_commons/src/reflect/reflect.dart';
import 'package:test/test.dart';

void main() {
  group('RecursiveObjectWriter', () {
    test('Set Property', () {
      var obj = {
        'value1': 123,
        'value2': {'value21': 111, 'value22': 222},
        'value3': [
          444,
          {'value311': 555, 'value312': 'XXX'}
        ]
      };

      //RecursiveObjectWriter.setProperty(obj, '', null);
      RecursiveObjectWriter.setProperty(obj, 'value1', 'AAA');
      RecursiveObjectWriter.setProperty(obj, 'value2', 'BBB');
      RecursiveObjectWriter.setProperty(obj, 'value3.1.value312', 'CCC');
      RecursiveObjectWriter.setProperty(obj, 'value3.3', 'DDD');
      RecursiveObjectWriter.setProperty(obj, 'value4.1', 'EEE');

      var values = RecursiveObjectReader.getProperties(obj);
      //assert.equal(8, values.length);
      expect(values['value1'], equals('AAA'));
      expect(values['value2'], equals('BBB'));
      expect(values['value2.value21'], isNull);
      expect(values['value3.0'], equals(444));
      expect(values['value3.1.value311'], equals(555));
      expect(values['value3.1.value312'], equals('CCC'));
      expect(values['value3.2'], isNull);
      expect(values['value3.3'], equals('DDD'));
      expect(values['value4.1'], equals('EEE'));
    });

    test('Set Properties', () {
      var obj = {
        'value1': 123,
        'value2': {'value21': 111, 'value22': 222},
        'value3': [
          444,
          {'value311': 555, 'value312': 'XXX'}
        ]
      };

      var values = <String, dynamic>{
        //'', null,
        'value1': 'AAA',
        'value2': 'BBB',
        'value3.1.value312': 'CCC',
        'value3.3': 'DDD',
        'value4.1': 'EEE'
      };
      RecursiveObjectWriter.setProperties(obj, values);

      values = RecursiveObjectReader.getProperties(obj);
      //assert.equal(8, values.length);
      expect(values['value1'], equals('AAA'));
      expect(values['value2'], equals('BBB'));
      expect(values['value2.value21'], isNull);
      expect(values['value3.0'], equals(444));
      expect(values['value3.1.value311'], equals(555));
      expect(values['value3.1.value312'], equals('CCC'));
      expect(values['value3.2'], isNull);
      expect(values['value3.3'], equals('DDD'));
      expect(values['value4.1'], equals('EEE'));
    });
  });
}
