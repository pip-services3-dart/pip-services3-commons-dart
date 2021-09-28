import 'package:pip_services3_commons/src/convert/DoubleConverter.dart';
import 'package:test/test.dart';

void main() {
  group('DoubleConverter', () {
    test('To Double', () {
      expect(DoubleConverter.toDouble(123), equals(123));
      expect(DoubleConverter.toDouble(123.456), equals(123.456));
      expect(DoubleConverter.toDouble('123.456'), equals(123.456));
      expect(DoubleConverter.toDouble(DateTime.fromMillisecondsSinceEpoch(123)),
          equals(123));
      expect(
          DoubleConverter.toDouble(Duration(milliseconds: 123)), equals(123));

      expect(DoubleConverter.toDoubleWithDefault(null, 123), equals(123));
      expect(DoubleConverter.toDoubleWithDefault(false, 123), isZero);
      expect(DoubleConverter.toDoubleWithDefault('ABC', 123), equals(123));
    });
  });
}
