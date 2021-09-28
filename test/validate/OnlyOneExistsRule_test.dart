import 'package:pip_services3_commons/src/validate/validate.dart';
import 'package:test/test.dart';

import './TestObject.dart';

void main() {
  group('OnlyOneExistsRule', () {
    test('OnlyOneExistsRule', () {
      var obj = TestObject();

      var schema = Schema().withRule(OnlyOneExistsRule(
          ['missingProperty', 'stringProperty', 'nullProperty']));
      var results = schema.validate(obj);
      expect(results.length, 0);

      schema = Schema().withRule(
          OnlyOneExistsRule(['stringProperty', 'nullProperty', 'intField']));
      results = schema.validate(obj);
      expect(results.length, 1);
    });
  });
}
