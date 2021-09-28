import 'package:pip_services3_commons/src/convert/TypeCode.dart';
import 'package:pip_services3_commons/src/data/AnyValue.dart';
import 'package:test/test.dart';

void main() {
  group('AnyValue', () {
    test('Get and Set', () {
      var value = AnyValue();
      expect(value.getAsObject(), isNull);

      value.setAsObject(1);
      expect(value.getAsInteger(), 1);
      expect(1.0 - value.getAsFloat() < 0.001, isTrue);
      expect(value.getAsString(), '1');
    });

    test('Equal', () {
      var value = AnyValue(1);

      expect(value.equals(1), isTrue);
      // expect(value.equals(1.0), isTrue);
      expect(value.equals('1'), isTrue);
      expect(value.equalsAsType<double>(TypeCode.Float, '1'), isTrue);
    });
  });
}
