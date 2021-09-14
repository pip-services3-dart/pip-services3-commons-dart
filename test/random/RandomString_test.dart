import 'package:test/test.dart';

import '../../lib/src/random/RandomString.dart';

void main() {
  group('RandomString', () {
    var symbols = '_,.:-/.[].{},#-!,\$=%.+^.&*-() ';
    var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var digits = '01234956789';

    test('Pick', () {
      expect(RandomString.pickChar('') == '', isTrue);
      var charVariable = RandomString.pickChar(chars);
      expect(chars.contains(charVariable), isTrue);

      var valuesEmpty = <String>[];
      expect(RandomString.pick(valuesEmpty) == '', isTrue);

      var values = ['ab', 'cd'];
      var result = RandomString.pick(values);
      expect(result == 'ab' || result == 'cd', isTrue);
    });

    test('Distort', () {
      var value = RandomString.distort('abc');
      expect(value.length == 3 || value.length == 4, isTrue);
      expect(value.substring(0, 3) == 'Abc' || value.substring(0, 3) == 'abc',
          isTrue);

      if (value.length == 4) {
        expect(symbols.contains(value.substring(3)), isTrue);
      }
    });

    test('Next Alpha Char', () {
      expect(chars.contains(RandomString.nextAlphaChar()), isTrue);
    });

    test('Next String', () {
      var value = RandomString.nextString(3, 5);
      expect(value.length <= 5 && value.length >= 3, isTrue);

      for (var i = 0; i < value.length; i++) {
        expect(
            chars.contains(value.substring(i, i + 1)) ||
                symbols.contains(value.substring(i, i + 1)) ||
                digits.contains(value.substring(i, i + 1)),
            isTrue);
      }
    });
  });
}
