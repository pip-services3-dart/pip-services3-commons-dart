import "package:test/test.dart";

import "../../lib/src/convert/RecursiveMapConverter.dart";

void main() {
  group('RecursiveMapConverter', () {
    test('ToNullableMap leave as is Null', () {
      expect(RecursiveMapConverter.toNullableMap(null), isNull);
    });

    test('ToNullableMap leave as is primitive types', () {
      expect(RecursiveMapConverter.toNullableMap(5), equals(5));
      expect(RecursiveMapConverter.toNullableMap("ABC"), equals("ABC"));
    });

    test('Array of Map to Map', () {
      var array = [
        {"field1": 1, "field2": 2},
        [7, 8]
      ];
      var map = RecursiveMapConverter.toNullableMap(array);
      expect(map, isNotNull);

      var map0 = map["0"];
      var map1 = map["1"];

      expect(map0, isNotNull);
      expect(map1, isNotNull);

      expect(map0["field1"], equals(1));
      expect(map0["field2"], equals(2));

      expect(map1["0"], equals(7));
      expect(map1["1"], equals(8));
    });
  });
}
