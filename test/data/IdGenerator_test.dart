import 'package:test/test.dart';
import '../../lib/src/data/IdGenerator.dart';

void main() {
  group('IdGenerator', () {
    test('Short Id', () {
      var id1 = IdGenerator.nextShort();
      expect(id1, isNotNull);
      expect(id1.length >= 9, isTrue);

      var id2 = IdGenerator.nextShort();
      expect(id2, isNotNull);
      expect(id2.length >= 9, isTrue);
      expect(id1 == id2, isFalse);
    });

    test('Long Id', () {
      var id1 = IdGenerator.nextLong();
      expect(id1, isNotNull);
      expect(id1.length >= 32, isTrue);

      var id2 = IdGenerator.nextLong();
      expect(id2, isNotNull);
      expect(id2.length >= 32, isTrue);
      expect(id1 == id2, isFalse);
    });
  });
}
