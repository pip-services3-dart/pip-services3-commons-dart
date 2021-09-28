import 'package:pip_services3_commons/src/validate/validate.dart';
import 'package:test/test.dart';
import './TestObject.dart';

void main() {
  group('AtLeastOneExistsRule', () {
    test('Only One Exists Rule', () {
      var obj = TestObject();

      var schema = Schema().withRule(AtLeastOneExistsRule(
          ['missingProperty', 'stringProperty', 'nullProperty']));
      var results = schema.validate(obj);
      expect(results.length, 0);

      schema = Schema().withRule(
          AtLeastOneExistsRule(['stringProperty', 'nullProperty', 'intField']));
      results = schema.validate(obj);
      expect(results.length, 0);

      schema = Schema()
          .withRule(AtLeastOneExistsRule(['missingProperty', 'nullProperty']));
      results = schema.validate(obj);
      expect(results.length, 1);
    });
  });
}
