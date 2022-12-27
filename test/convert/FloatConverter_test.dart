import 'package:pip_services3_commons/src/convert/FloatConverter.dart';
import 'package:test/test.dart';

void main() {
  group('FloatConverter', () {
    test('To Float', () {
      expect(FloatConverter.toFloat(123), equals(123));
      expect(FloatConverter.toFloat(123.456), equals(123.456));
      expect(FloatConverter.toFloat('123.456'), equals(123.456));
      expect(FloatConverter.toFloat(DateTime.fromMillisecondsSinceEpoch(123)),
          equals(123));
      expect(FloatConverter.toFloat(Duration(milliseconds: 123)), equals(123));

      expect(FloatConverter.toFloatWithDefault(null, 123), equals(123));
      expect(FloatConverter.toFloatWithDefault(false, 123), isZero);
      expect(FloatConverter.toFloatWithDefault('ABC', 123), equals(123));
    });
  });
}
