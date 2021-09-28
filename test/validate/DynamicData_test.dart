import 'package:pip_services3_commons/src/convert/TypeCode.dart';
import 'package:pip_services3_commons/src/validate/ObjectSchema.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('DynamicData', () {
    test('Validate dynamic data', () {
      var dynamicString =
          '{ "string_field": "ABC", "date_field": "2019-01-01T11:30:00.00", "int_field": 123, "float_field": 123.456 }';
      var dynamicObject = json.decode(dynamicString);

      var schema = ObjectSchema()
          .withRequiredProperty('string_field', TypeCode.String)
          .withRequiredProperty('date_field', TypeCode.DateTime)
          .withRequiredProperty('int_field', TypeCode.Integer)
          .withRequiredProperty('float_field', TypeCode.Float);
      var results = schema.validate(dynamicObject);
      expect(results.length, 0);
    });
  });
}
