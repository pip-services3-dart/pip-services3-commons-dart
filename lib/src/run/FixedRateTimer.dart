import 'dart:math';
import 'dart:async';

import './IClosable.dart';
import './INotifiable.dart';
import './Parameters.dart';
import '../reflect/ObjectReader.dart';

/// Timer that is triggered in equal time intervals.
///
/// It has summetric cross-language implementation
/// and is often used by Pip.Services toolkit to
/// perform periodic processing and cleanup in microservices.
///
/// See [INotifiable]
///
/// ### Example ###
///
///     class MyComponent {
///         FixedRateTimer timer  = new FixedRateTimer(() { cleanup }, 60000);
///         ...
///         void open(String correlationId, callback (dynamic err)) {
///             ...
///             timer.start();
///             ...
///         }
///
///         void close(String correlationId, callback (dynamic err)) {
///             ...
///             timer.stop();
///             ...
///         }
///
///         void cleanup() {
///             ...
///         }
///         ...
///     }

class FixedRateTimer implements IClosable {
  INotifiable _task;
  void Function() _callback;
  int _delay;
  int _interval;
  Timer _timer;
  Timer _timeout;

  /// Creates new instance of the timer and sets its values.
  ///
  /// - [taskOrCallback]    (optional) a Notifiable object or callback function to call when timer is triggered.
  /// - [interval]          (optional) an interval to trigger timer in milliseconds.
  /// - [delay]             (optional) a delay before the first triggering in milliseconds.
  ///
  /// See [setTask]
  /// See [setCallback]
  /// See [setInterval]
  /// See [setDelay]

  FixedRateTimer(
      [dynamic taskOrCallback = null, int interval = null, int delay = null]) {
    if (taskOrCallback != null && (taskOrCallback is INotifiable)) //
      setTask(taskOrCallback);
    else
      setCallback(taskOrCallback);

    setInterval(interval);
    setDelay(delay);
  }

  /// Gets the INotifiable object that receives notifications from this timer.
  ///
  /// Returns the INotifiable object or null if it is not set.

  INotifiable getTask() {
    return _task;
  }

  /// Sets a new INotifiable object to receive notifications from this timer.
  ///
  /// - [value] a INotifiable object to be triggered.

  void setTask(INotifiable value) {
    _task = value;
    _callback = () {
      _task.notify('pip-commons-timer', Parameters());
    };
  }

  /// Gets the callback function that is called when this timer is triggered.
  ///
  /// Returns the callback function or null if it is not set.

  Function() getCallback() {
    return _callback;
  }

  /// Sets the callback function that is called when this timer is triggered.
  ///
  /// - [value] the callback function to be called.

  setCallback(Function() value) {
    _callback = value;
    _task = null;
  }

  /// Gets initial delay before the timer is triggered for the first time.
  ///
  /// Returns the delay in milliseconds.

  int getDelay() {
    return _delay;
  }

  /// Sets initial delay before the timer is triggered for the first time.
  ///
  /// - [value] a delay in milliseconds.

  void setDelay(int value) {
    _delay = value;
  }

  /// Gets periodic timer triggering interval.
  ///
  /// Returns the interval in milliseconds

  int getInterval() {
    return _interval;
  }

  /// Sets periodic timer triggering interval.
  ///
  /// - [value] an interval in milliseconds.

  void setInterval(int value) {
    _interval = value;
  }

  /// Checks if the timer is started.
  ///
  /// Returns true if the timer is started and false if it is stopped.

  bool isStarted() {
    return _timer != null;
  }

  /// Starts the timer.
  ///
  /// Initially the timer is triggered after delay.
  /// After that it is triggered after interval until it is stopped.
  ///
  /// See [stop]

  void start() {
    // Stop previously set timer
    stop();

    // Exit if interval is not defined
    if (_interval == null || _interval <= 0) return;

    // Introducing delay
    var delay = max(0, _delay - _interval);

    _timeout = Timer(Duration(milliseconds: delay), () {
      _timeout = null;

      // Set a new timer
      _timer =
          Timer.periodic(Duration(milliseconds: _interval), (Timer tm) {
        try {
          if (_callback != null) _callback();
        } catch (ex) {
          // Ignore or better log!
        }
      });
    });
  }

  /// Stops the timer.
  ///
  /// See [start]

  stop() {
    if (_timeout != null) {
      _timeout.cancel();
      _timeout = null;
    }

    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  /// Closes the timer.
  ///
  /// This is required by [ICloseable] interface,
  /// but besides that it is identical to stop().
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// Retrun 			      Future that receives error or null no errors occured.
  ///
  /// See [stop]

  Future close(String correlationId) {
    stop();

    return Future.delayed(Duration());
  }
}
