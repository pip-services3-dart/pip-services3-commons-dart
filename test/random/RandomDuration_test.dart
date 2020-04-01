import 'package:test/test.dart';

import '../../lib/src/random/RandomDuration.dart';

void main() {
  group('RandomDuration', () {
    test('Next Duration', () {
      var interval = RandomDuration.nextDuration(
           Duration(milliseconds: 10000),  Duration(milliseconds: 15000));
      expect(
          interval.inMilliseconds >= 10000 || interval.inMilliseconds <= 15000,
          isTrue);
    });

    test('Update Duration', () {
      var oldInterval =  Duration(milliseconds: 10000);

      var interval = RandomDuration.updateDuration(oldInterval);
      expect(
          interval.inMilliseconds >= 9000 && interval.inMilliseconds <= 11000,
          isTrue);

      interval = RandomDuration.updateDuration(oldInterval, 500);
      expect(
          interval.inMilliseconds >= 9500 && interval.inMilliseconds <= 10500,
          isTrue);

      interval = RandomDuration.updateDuration(oldInterval, -3);
      expect(interval.inMilliseconds == oldInterval.inMilliseconds, isTrue);
    });
  });
}
