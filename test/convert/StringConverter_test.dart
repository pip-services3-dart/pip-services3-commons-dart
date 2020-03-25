import "package:test/test.dart";

import "../../lib/src/convert/StringConverter.dart";

void main() {
  group('StringConverter', () {

      test('To String', () {
          expect(StringConverter.toNullableString(null), isNull);
          expect(StringConverter.toString2('xyz'), equals('xyz'));
          expect(StringConverter.toString2(123), equals('123'));
          expect(StringConverter.toString2(true), equals('true'));
          expect(StringConverter.toStringWithDefault({ 'prop': 'xyz' }, 'xyz'), equals('{prop: xyz}'));

          expect(StringConverter.toStringWithDefault(null, 'xyz'), equals('xyz'));
      });

  });
}