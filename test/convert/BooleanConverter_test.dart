import 'package:pip_services3_commons/src/convert/convert.dart';
import 'package:test/test.dart';

void main() {
  group('BooleanConverter', () {
    test('To Boolean', () {
      expect(BooleanConverter.toBoolean(true), isTrue);
      expect(BooleanConverter.toBoolean(1), isTrue);
      expect(BooleanConverter.toBoolean(123), isTrue);
      expect(BooleanConverter.toBoolean('True'), isTrue);
      expect(BooleanConverter.toBoolean('yes'), isTrue);
      expect(BooleanConverter.toBoolean('1'), isTrue);
      expect(BooleanConverter.toBoolean('Y'), isTrue);

      expect(BooleanConverter.toBoolean(false), isFalse);
      expect(BooleanConverter.toBoolean(0), isFalse);
      expect(BooleanConverter.toBoolean('False'), isFalse);
      expect(BooleanConverter.toBoolean('no'), isFalse);
      expect(BooleanConverter.toBoolean('0'), isFalse);
      expect(BooleanConverter.toBoolean('N'), isFalse);

      expect(BooleanConverter.toBooleanWithDefault('XYZ', true), isTrue);
    });
  });
}
