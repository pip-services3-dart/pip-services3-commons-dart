import 'package:test/test.dart';

import '../../lib/src/config/ConfigParams.dart';
import '../../lib/src/data/AnyValueMap.dart';
import '../../lib/src/data/AnyValueArray.dart';

void main() {
  group('ConfigParams', () {
    test('Config Sections', () {
      var config = ConfigParams.fromTuples([
        'Section1.Key1',
        'Value1',
        'Section1.Key2',
        'Value2',
        'Section1.Key3',
        'Value3'
      ]);

      expect(config.length, equals(3));
      expect(config.get('Section1.Key1'), equals('Value1'));
      expect(config.get('Section1.Key2'), equals('Value2'));
      expect(config.get('Section1.Key3'), equals('Value3'));
      expect(config.get('Section1.Key4'), isNull);

      var section2 = ConfigParams.fromTuples([
        'Key1',
        'ValueA',
        'Key2',
        'ValueB',
      ]);

      config.addSection('Section2', section2);
      expect(config.length, equals(5));
      expect(config.get('Section2.Key1'), equals('ValueA'));
      expect(config.get('Section2.Key2'), equals('ValueB'));

      var section1 = config.getSection('Section1');
      expect(section1.length, equals(3));
      expect(section1.get('Key1'), equals('Value1'));
      expect(section1.get('Key2'), equals('Value2'));
      expect(section1.get('Key3'), equals('Value3'));
    });

    test('Config From String', () {
      var config = ConfigParams.fromString(
          'Queue=TestQueue;Endpoint=sb://cvctestbus.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=K70UpCUXN1Q5RFykll6/gz4Et14iJrYFnGPlwiFBlow=');
      expect(config.length, equals(4));
      expect(config.get('Queue'), equals('TestQueue'));
    });

    test('Config From Object', () {
      var value = AnyValueMap.fromTuples([
        'field1',
        ConfigParams.fromString('field11=123;field12=ABC'),
        'field2',
        AnyValueArray.fromValues(
            [123, 'ABC', ConfigParams.fromString('field21=543;field22=XYZ')]),
        'field3',
        true
      ]);

      var config = ConfigParams.fromValue(value);
      expect(config.length, equals(7));
      expect(config.getAsInteger('field1.field11'), equals(123));
      expect(config.get('field1.field12'), equals('ABC'));
      expect(config.getAsInteger('field2.0'), equals(123));
      expect(config.get('field2.1'), equals('ABC'));
      expect(config.getAsInteger('field2.2.field21'), equals(543));
      expect(config.get('field2.2.field22'), equals('XYZ'));
      expect(config.getAsBoolean('field3'), equals(true));
    });
  });
}
