import "package:test/test.dart";
import "../../lib/src/data/AnyValueArray.dart";

void main() {
  group('AnyValueArray', () {
      test('Create', () {
        var array = new AnyValueArray();
        expect(array.length, 0);

        array = new AnyValueArray([ 1, 2, 3 ]);
        expect(3, array.length);
        expect("1,2,3", array.toString());

        array = AnyValueArray.fromString("Fatal,Error,Info,", ",");
        expect(4, array.length);

        array = new AnyValueArray([ 1, 2, 3 ]);
        expect(3, array.length);
        expect(array.contains(1), isTrue);
      });
  });
}
