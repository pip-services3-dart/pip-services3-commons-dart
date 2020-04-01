import 'package:test/test.dart';

import './TestObject.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/ValueComparisonRule.dart';

void main() {
  group('ValueComparisonRule', () {
    test('Number Equal Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('EQ', 123));
      var results = schema.validate(123);
      expect(results.length, 0);

      results = schema.validate(432);
      expect(results.length, 1);
    });

    test('String Equal Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('EQ', 'ABC'));
      var results = schema.validate('ABC');
      expect(results.length, 0);

      results = schema.validate('XYZ');
      expect(results.length, 1);
    });

    test('Number Not Equal Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('NE', 123));
      var results = schema.validate(123);
      expect(results.length, 1);

      results = schema.validate(432);
      expect(results.length, 0);
    });

    test('String Not Equal Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('NE', 'ABC'));
      var results = schema.validate('ABC');
      expect(results.length, 1);

      results = schema.validate('XYZ');
      expect(results.length, 0);
    });

    test('Less Than or Equal Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('LE', 123));
      var results = schema.validate(123);
      expect(results.length, 0);

      results = schema.validate(432);
      expect(results.length, 1);
    });

    test('Less Than Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('LT', 123));
      var results = schema.validate(123);
      expect(results.length, 1);

      results = schema.validate(0);
      expect(results.length, 0);
    });

    test('More Than or Equal Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('GE', 123));
      var results = schema.validate(123);
      expect(results.length, 0);

      results = schema.validate(432);
      expect(results.length, 0);

      results = schema.validate(0);
      expect(results.length, 1);
    });

    test('More Than Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('GT', 123));
      var results = schema.validate(123);
      expect(results.length, 1);

      results = schema.validate(432);
      expect(results.length, 0);

      results = schema.validate(0);
      expect(results.length, 1);
    });

    test('Match Comparison', () {
      var schema = Schema().withRule(ValueComparisonRule('LIKE', 'A.*'));
      var results = schema.validate('ABC');
      expect(results.length, 0);

      results = schema.validate('XYZ');
      expect(results.length, 1);
    });
  });
}
