import 'package:pip_services3_commons/src/validate/validate.dart';
import 'package:test/test.dart';

void main() {
  group('Inclusion Rules', () {
    test('IncludedRule', () {
      var schema = Schema().withRule(IncludedRule(['AAA', 'BBB', 'CCC', null]));

      var results = schema.validate('AAA');
      expect(results.length, 0);

      results = schema.validate('ABC');
      expect(results.length, 1);
    });

    test('ExcludedRule', () {
      var schema = Schema().withRule(ExcludedRule(['AAA', 'BBB', 'CCC', null]));

      var results = schema.validate('AAA');
      expect(results.length, 1);

      results = schema.validate('ABC');
      expect(results.length, 0);
    });
  });
}
