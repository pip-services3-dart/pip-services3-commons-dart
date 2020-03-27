import 'package:test/test.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/OrRule.dart';
import '../../lib/src/validate/AndRule.dart';
import '../../lib/src/validate/ValueComparisonRule.dart';

void main() {
  group('Logical Rules', () {
    test('OrRule', () {
      var schema = new Schema().withRule(new OrRule(
          [new ValueComparisonRule("=", 1), new ValueComparisonRule("=", 2)]));

      var results = schema.validate(-100);
      expect(results.length, 2);

      results = schema.validate(1);
      expect(results.length, 0);

      results = schema.validate(200);
      expect(results.length, 2);
    });

    test('AndRule', () {
      var schema = new Schema().withRule(new AndRule([
        new ValueComparisonRule(">", 0),
        new ValueComparisonRule("<", 200)
      ]));

      var results1 = schema.validate(-100);
      expect(results1.length, 1);

      var results2 = schema.validate(100);
      expect(results2.length, 0);

      var results3 = schema.validate(200);
      expect(results3.length, 1);
    });
  });
}
