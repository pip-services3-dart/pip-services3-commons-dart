import "package:test/test.dart";
import './TestObject.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/PropertiesComparisonRule.dart';

void main() {
  group('PropertiesComparisonRule', () {
    test('PropertiesComparisonRule', () {
      var obj = new TestObject();
      var schema = new Schema().withRule(
          new PropertiesComparisonRule("stringProperty", "EQ", "nullProperty"));

      obj.stringProperty = "ABC";
      obj.nullProperty = "ABC";
      var results = schema.validate(obj);
      expect(results.length, 0);

      obj.nullProperty = "XYZ";
      results = schema.validate(obj);
      expect(results.length, 1);
    });
  });
}
