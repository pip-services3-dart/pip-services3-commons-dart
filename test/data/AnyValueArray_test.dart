import 'package:pip_services3_commons/src/data/AnyValueArray.dart';
import 'package:test/test.dart';

void main() {
  group('AnyValueArray', () {
    test('Create', () {
      var array = AnyValueArray();
      expect(array.length, 0);

      array = AnyValueArray([1, 2, 3]);
      expect(3, array.length);
      expect('1,2,3', array.toString());

      array = AnyValueArray.fromString('Fatal,Error,Info,', ',');
      expect(4, array.length);

      array = AnyValueArray([1, 2, 3]);
      expect(3, array.length);
      expect(array.contains(1), isTrue);
    });
  });
}
