import 'package:test/test.dart';
import './TestObject.dart';
import './TestSubObject.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/AtLeastOneExistsRule.dart';

void main() {
  group('AtLeastOneExistsRule', () {
    test('Only One Exists Rule', () {
      var obj = new TestObject();

      var schema = new Schema().withRule(new AtLeastOneExistsRule(
          ["missingProperty", "stringProperty", "nullProperty"]));
      var results = schema.validate(obj);
      expect(results.length, 0);

      schema = new Schema().withRule(new AtLeastOneExistsRule(
          ["stringProperty", "nullProperty", "intField"]));
      results = schema.validate(obj);
      expect(results.length, 0);

      schema = new Schema().withRule(
          new AtLeastOneExistsRule(["missingProperty", "nullProperty"]));
      results = schema.validate(obj);
      expect(results.length, 1);
    });
  });
}
