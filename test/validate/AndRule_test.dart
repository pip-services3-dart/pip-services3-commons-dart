import 'package:pip_services3_commons/src/validate/validate.dart';
import 'package:test/test.dart';
import './TestObject.dart';

void main() {
  group('AndRule', () {
    test('AndRule', () {
      var obj = TestObject();

      var schema = Schema().withRule(AndRule([
        AtLeastOneExistsRule(
            ['missingProperty', 'stringProperty', 'nullProperty']),
        AtLeastOneExistsRule(['stringProperty', 'nullProperty', 'intField'])
      ]));
      var results = schema.validate(obj);
      expect(results.length, 0);

      schema = Schema().withRule(AndRule([
        AtLeastOneExistsRule(
            ['missingProperty', 'stringProperty', 'nullProperty']),
        AtLeastOneExistsRule(['missingProperty', 'nullProperty'])
      ]));
      results = schema.validate(obj);
      expect(results.length, 1);
    });
  });
}
