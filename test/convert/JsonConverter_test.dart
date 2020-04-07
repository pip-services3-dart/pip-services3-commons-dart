import 'package:test/test.dart';

import '../../lib/src/convert/TypeCode.dart';
import '../../lib/src/convert/DateTimeConverter.dart';
import '../../lib/src/convert/JsonConverter.dart';

void main() {
  group('JsonConverter', () {
    test('To Json', () {
      expect(JsonConverter.toJson(null), isNull);
      expect(JsonConverter.toJson(123), equals('123'));
      expect(JsonConverter.toJson('ABC'), equals('\"ABC\"'));

      var filter = {'Key1': 123, 'Key2': 'ABC'};
      var jsonFilter = JsonConverter.toJson(filter);
      expect(jsonFilter, equals('{\"Key1\":123,\"Key2\":\"ABC\"}'));

      var array = [123, 'ABC'];
      var jsonArray = JsonConverter.toJson(array);
      expect(jsonArray, equals('[123,\"ABC\"]'));

      var date = DateTimeConverter.toDateTime('1975-04-08T00:00:00.000Z');
      var jsonDate = JsonConverter.toJson(date);
      expect(jsonDate, equals('\"1975-04-08T00:00:00.000Z\"'));
    });

    test('From Json', () {
      expect(JsonConverter.fromJson<int>(TypeCode.Integer, '123'), equals(123));
      expect(JsonConverter.fromJson<String>(TypeCode.String, '\"ABC\"'),
          equals('ABC'));

      var filter =
          JsonConverter.fromJson(null, '{\"Key2\":\"ABC\",\"Key1\":\"123\"}');
      expect(filter, isMap);

      var array = JsonConverter.fromJson<List>(TypeCode.Array, '[123,\"ABC\"]');
      expect(array.length, equals(2));

      var date = DateTimeConverter.toDateTime('1975-04-08T00:00:00.000Z');
      var jsonDate = JsonConverter.fromJson<DateTime>(
          TypeCode.DateTime, '\"1975-04-08T00:00Z\"');
      expect(date, equals(jsonDate));
    });

    test('To Json Map', () {
      // Handling simple objects
      var value = '{ \"value1\":123, \"value2\":234 }';
      var result = JsonConverter.toNullableMap(value);
      expect(result['value1'], equals(123));
      expect(result['value2'], equals(234));

      // Recursive conversion
      value =
          '{ \"value1\":123, \"value2\": { \"value1\": 111, \"value2\": 222 } }';
      result = JsonConverter.toNullableMap(value);
      expect(result, isNotNull);
      expect(result['value1'], equals(123));
      expect(result['value2'], isMap);

      // Handling arrays
      value = '{ \"value1\": [{ \"value1\": 111, \"value2\": 222 }] }';
      result = JsonConverter.toNullableMap(value);
      expect(result, isNotNull);
      expect(result['value1'], isList);
      var resultElements = result['value1'];
      var resultElement0 = resultElements[0];
      expect(resultElement0, isMap);
      expect(resultElement0['value1'], equals(111));
      expect(resultElement0['value2'], equals(222));
    });
  });
}
