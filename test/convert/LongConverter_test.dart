import 'package:pip_services3_commons/src/convert/LongConverter.dart';
import 'package:test/test.dart';

void main() {
  group('LongConverter', () {
    test('To Long', () {
      expect(LongConverter.toLong(123), equals(123));
      expect(LongConverter.toLong(123.456), equals(124));
      expect(LongConverter.toLong('123'), equals(123));
      expect(LongConverter.toLong(DateTime.fromMillisecondsSinceEpoch(123)),
          equals(123));
      expect(LongConverter.toLong(Duration(milliseconds: 123)), equals(123));

      expect(LongConverter.toLongWithDefault(null, 123), equals(123));
      expect(LongConverter.toLongWithDefault(false, 123), isZero);
      expect(LongConverter.toLongWithDefault('ABC', 123), equals(123));
    });
  });
}
