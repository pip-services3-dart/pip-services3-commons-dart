import 'package:pip_services3_commons/src/random/RandomText.dart';
import 'package:test/test.dart';

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
      expect(text.contains(' '), isTrue);
    });

    test('Phone', () {
      var text = RandomText.phone();
      expect(text.contains('('), isTrue);
      expect(text.contains(')'), isTrue);
      expect(text.contains('-'), isTrue);
    });

    test('Email', () {
      var text = RandomText.email();
      expect(text.contains('@'), isTrue);
      expect(text.contains('.com'), isTrue);
    });
  });
}
