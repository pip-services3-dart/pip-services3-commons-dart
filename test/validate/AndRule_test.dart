
import 'package:test/test.dart';
import './TestObject.dart';
import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/AndRule.dart';
import  '../../lib/src/validate/AtLeastOneExistsRule.dart';

void main() {
group('AndRule', () {

    test('AndRule', () {
        var obj = new TestObject();

        var schema = new Schema().withRule(new AndRule([new AtLeastOneExistsRule(['missingProperty', 'stringProperty', 'nullProperty']), new AtLeastOneExistsRule(['stringProperty', 'nullProperty', 'intField'])]));
        var results = schema.validate(obj);
        expect(results.length, 0);

        schema = new Schema().withRule(new AndRule([new AtLeastOneExistsRule(['missingProperty', 'stringProperty', 'nullProperty']), new AtLeastOneExistsRule(['missingProperty', 'nullProperty'])]));
        results = schema.validate(obj);
        expect(results.length, 1);

    });

});
}