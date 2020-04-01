import 'package:test/test.dart';

import '../../lib/src/convert/DateTimeConverter.dart';

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
          equals(DateTime.fromMillisecondsSinceEpoch(123456)));
      expect(DateTimeConverter.toDateTime('1975-04-08'),
          equals(DateTime(1975, 4, 8)));
      expect(DateTimeConverter.toNullableDateTime('XYZ'), isNull);
    });
  });
}
