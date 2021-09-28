import 'package:pip_services3_commons/src/convert/StringConverter.dart';
import 'package:test/test.dart';

void main() {
  group('StringConverter', () {
    test('To String', () {
      expect(StringConverter.toNullableString(null), isNull);
      expect(StringConverter.toNullableString([1, 2, 3]), equals('1,2,3'));
      expect(StringConverter.toString2('xyz'), equals('xyz'));
      expect(StringConverter.toString2(123), equals('123'));
      expect(StringConverter.toString2(true), equals('true'));
      expect(StringConverter.toStringWithDefault({'prop': 'xyz'}, 'xyz'),
          equals('{prop: xyz}'));

      expect(StringConverter.toStringWithDefault(null, 'xyz'), equals('xyz'));
    });
  });
}
