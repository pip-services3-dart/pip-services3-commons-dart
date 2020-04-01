import "package:test/test.dart";
import 'dart:async';
import '../../lib/src/run/INotifiable.dart';
import '../../lib/src/run/Parameters.dart';
import '../../lib/src/run/FixedRateTimer.dart';

class TestTimer implements INotifiable {
  int counter = 0;
  void notify(String correlationId, Parameters args){
    counter++;
  }
}

void main() {
  group('FixedRateTimer', () {
    test('Run with task', () async {
      var notifier = TestTimer();
      var timer =  FixedRateTimer(notifier, 100, 0);

      timer.start();
      
      await Future.delayed(Duration(milliseconds: 500)).then((e) {
        timer.stop();
        expect(notifier.counter > 3, isTrue);
        return null;
      });
    });

    test('Run with callback', () async {
      var counter = 0;

      var timer =  FixedRateTimer(() {
        counter++;
      }, 100, 0);

      timer.start();

      await Future.delayed(Duration(milliseconds: 500)).then((e){
        timer.stop();
        expect(counter > 3, isTrue);
        return null;
      });
    });
  });
}
