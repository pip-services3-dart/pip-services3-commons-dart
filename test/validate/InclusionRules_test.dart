import 'package:test/test.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/IncludedRule.dart';
import '../../lib/src/validate/ExcludedRule.dart';

void main() {
  group('Inclusion Rules', () {
    test('IncludedRule', () {
      var schema =
          new Schema().withRule(new IncludedRule(['AAA', 'BBB', 'CCC', null]));

      var results = schema.validate('AAA');
      expect(results.length, 0);

      results = schema.validate('ABC');
      expect(results.length, 1);
    });

    test('ExcludedRule', () {
      var schema =
          new Schema().withRule(new ExcludedRule(['AAA', 'BBB', 'CCC', null]));

      var results = schema.validate('AAA');
      expect(results.length, 1);

      results = schema.validate('ABC');
      expect(results.length, 0);
    });
  });
}
