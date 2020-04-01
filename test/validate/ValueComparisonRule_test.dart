import 'package:test/test.dart';

import './TestObject.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/ValueComparisonRule.dart';

void main() {
  group('ValueComparisonRule', () {
    test('Number Equal Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('EQ', 123));
      var results = schema.validate(123);
      expect(results.length, 0);

      results = schema.validate(432);
      expect(results.length, 1);
    });

    test('String Equal Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('EQ', 'ABC'));
      var results = schema.validate('ABC');
      expect(results.length, 0);

      results = schema.validate('XYZ');
      expect(results.length, 1);
    });

    test('Number Not Equal Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('NE', 123));
      var results = schema.validate(123);
      expect(results.length, 1);

      results = schema.validate(432);
      expect(results.length, 0);
    });

    test('String Not Equal Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('NE', 'ABC'));
      var results = schema.validate('ABC');
      expect(results.length, 1);

      results = schema.validate('XYZ');
      expect(results.length, 0);
    });

    test('Less Than or Equal Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('LE', 123));
      var results = schema.validate(123);
      expect(results.length, 0);

      results = schema.validate(432);
      expect(results.length, 1);
    });

    test('Less Than Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('LT', 123));
      var results = schema.validate(123);
      expect(results.length, 1);

      results = schema.validate(0);
      expect(results.length, 0);
    });

    test('More Than or Equal Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('GE', 123));
      var results = schema.validate(123);
      expect(results.length, 0);

      results = schema.validate(432);
      expect(results.length, 0);

      results = schema.validate(0);
      expect(results.length, 1);
    });

    test('More Than Comparison', () {
      var schema = new Schema().withRule(new ValueComparisonRule('GT', 123));
      var results = schema.validate(123);
      expect(results.length, 1);

      results = schema.validate(432);
      expect(results.length, 0);

      results = schema.validate(0);
      expect(results.length, 1);
    });

    test('Match Comparison', () {
      var schema =
          new Schema().withRule(new ValueComparisonRule('LIKE', 'A.*'));
      var results = schema.validate('ABC');
      expect(results.length, 0);

      results = schema.validate('XYZ');
      expect(results.length, 1);
    });
  });
}
