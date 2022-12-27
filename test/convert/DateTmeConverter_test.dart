import 'package:pip_services3_commons/src/convert/convert.dart';
import 'package:test/test.dart';

void main() {
  group('DateTimeConverter', () {
    // Todo: Add more tests with time and conversion of ISO datetime
    test('To DateTime', () {
      expect(DateTimeConverter.toNullableDateTime(null), isNull);
      expect(
          DateTimeConverter.toDateTimeWithDefault(null, DateTime(1975, 4, 8)),
          equals(DateTime(1975, 4, 8)));
      expect(DateTimeConverter.toDateTime(DateTime(1975, 4, 8)),
          equals(DateTime(1975, 4, 8)));
      expect(DateTimeConverter.toDateTime(123456),
          equals(DateTime.fromMillisecondsSinceEpoch(123456).toUtc()));
      expect(DateTimeConverter.toDateTime('1975-04-08'),
          equals(DateTime(1975, 4, 8).toUtc()));
      expect(DateTimeConverter.toNullableDateTime('XYZ'), isNull);
    });
  });
}
