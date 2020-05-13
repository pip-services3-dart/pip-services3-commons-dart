import 'package:test/test.dart';

import '../../lib/src/random/RandomDateTime.dart';

void main() {
  group('RandomDateTime', () {
    test('Next Date', () {
      var date = RandomDateTime.nextDate(
          DateTime(2015, 1, 1).toUtc(), DateTime(2016, 1, 1).toUtc());
      expect(date.year == 2015 || date.year == 2016, isTrue);

      date = RandomDateTime.nextDate(DateTime.now().toUtc());
      var now = DateTime.now().toUtc();
      expect(date.year >= now.year - 10 && date.year <= now.year, isTrue);
    });

    test('Update Date Time', () {
      var oldDate = DateTime(2016, 10, 10, 0, 0, 0, 0).toUtc();

      var date = RandomDateTime.updateDateTime(oldDate);
      expect(
          date.millisecondsSinceEpoch >=
                  oldDate.millisecondsSinceEpoch - 10 * 24 * 3600000 ||
              date.millisecondsSinceEpoch >=
                  oldDate.millisecondsSinceEpoch + 10 * 24 * 3600000,
          isTrue);

      date = RandomDateTime.updateDateTime(oldDate, 3 * 24 * 3600000);
      expect(
          date.millisecondsSinceEpoch >=
                  oldDate.millisecondsSinceEpoch - 3 * 24 * 3600000 ||
              date.millisecondsSinceEpoch >=
                  oldDate.millisecondsSinceEpoch + 3 * 24 * 3600000,
          isTrue);

      date = RandomDateTime.updateDateTime(oldDate, -3);
      expect(date.millisecondsSinceEpoch == oldDate.millisecondsSinceEpoch,
          isTrue);
    });
  });
}
