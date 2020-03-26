import "package:test/test.dart";

import "../../lib/src/convert/LongConverter.dart";

void main() {
  group('LongConverter', () {
    test('To Long', () {
      expect(LongConverter.toLong(123), equals(123));
      expect(LongConverter.toLong(123.456), equals(124));
      expect(LongConverter.toLong('123'), equals(123));
      expect(LongConverter.toLong(new DateTime.fromMillisecondsSinceEpoch(123)),
          equals(123));
      expect(
          LongConverter.toLong(new Duration(milliseconds: 123)), equals(123));

      expect(LongConverter.toLongWithDefault(null, 123), equals(123));
      expect(LongConverter.toLongWithDefault(false, 123), isZero);
      expect(LongConverter.toLongWithDefault('ABC', 123), equals(123));
    });
  });
}
