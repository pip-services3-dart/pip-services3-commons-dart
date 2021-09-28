import 'package:pip_services3_commons/src/convert/IntegerConverter.dart';
import 'package:test/test.dart';

void main() {
  group('IntegerConverter', () {
    test('To Integer', () {
      expect(IntegerConverter.toInteger(123), equals(123));
      expect(IntegerConverter.toInteger(123.456), equals(124));
      expect(IntegerConverter.toInteger('123'), equals(123));
      expect(
          IntegerConverter.toInteger(DateTime.fromMillisecondsSinceEpoch(123)),
          equals(123));
      expect(
          IntegerConverter.toInteger(Duration(milliseconds: 123)), equals(123));

      expect(IntegerConverter.toIntegerWithDefault(null, 123), equals(123));
      expect(IntegerConverter.toIntegerWithDefault(false, 123), isZero);
      expect(IntegerConverter.toIntegerWithDefault('ABC', 123), equals(123));
    });
  });
}
