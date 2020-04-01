import 'package:test/test.dart';

import './TestObject.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/OnlyOneExistsRule.dart';

void main() {
  group('OnlyOneExistsRule', () {
    test('OnlyOneExistsRule', () {
      var obj = new TestObject();

      var schema = new Schema().withRule(new OnlyOneExistsRule(
          ['missingProperty', 'stringProperty', 'nullProperty']));
      var results = schema.validate(obj);
      expect(results.length, 0);

      schema = new Schema().withRule(new OnlyOneExistsRule(
          ['stringProperty', 'nullProperty', 'intField']));
      results = schema.validate(obj);
      expect(results.length, 1);
    });
  });
}
