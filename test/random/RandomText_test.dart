import 'package:test/test.dart';

import '../../lib/src/random/RandomText.dart';

void main() {
  group('RandomText', () {
    test('Phrase', () {
      expect(RandomText.phrase(-1) == '', isTrue);
      expect(RandomText.phrase(-1, -2) == '', isTrue);
      expect(RandomText.phrase(-1, 0) == '', isTrue);
      expect(RandomText.phrase(-2, -1) == '', isTrue);

      var text = RandomText.phrase(4);
      expect(text.length >= 4 && text.length <= 10, isTrue);
      text = RandomText.phrase(4, 10);
      expect(text.length >= 4, isTrue);
    });

    test('FullName', () {
      var text = RandomText.fullName();
      expect(text.indexOf(' ') != -1, isTrue);
    });

    test('Phone', () {
      var text = RandomText.phone();
      expect(text.indexOf('(') != -1, isTrue);
      expect(text.indexOf(')') != -1, isTrue);
      expect(text.indexOf('-') != -1, isTrue);
    });

    test('Email', () {
      var text = RandomText.email();
      expect(text.indexOf('@') != -1, isTrue);
      expect(text.indexOf('.com') != -1, isTrue);
    });
  });
}
