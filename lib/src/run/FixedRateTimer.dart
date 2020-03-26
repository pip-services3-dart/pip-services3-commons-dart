import './IClosable.dart';
import './INotifiable.dart';
import './Parameters.dart';
import 'dart:math';
import 'dart:async';

/**
 * Timer that is triggered in equal time intervals.
 * 
 * It has summetric cross-language implementation 
 * and is often used by Pip.Services toolkit to
 * perform periodic processing and cleanup in microservices.
 * 
 * @see [[INotifiable]]
 * 
 * ### Example ###
 * 
 *     class MyComponent {
 *         timer: FixedRateTimer = new FixedRateTimer(() => { this.cleanup }, 60000);
 *         ...
 *         open(correlationId: string, callback: (err: any) => void): void {
 *             ...
 *             timer.start();
 *             ...
 *         }
 *         
 *         open(correlationId: string, callback: (err: any) => void): void {
 *             ...
 *             timer.stop();
 *             ...
 *         }
 *         
 *         cleanup(): void {
 *             ...
 *         }
 *         ...
 *     }
 */
class FixedRateTimer implements IClosable {
  INotifiable _task;
  void Function() _callback;
  int _delay;
  int _interval;
  Timer _timer;
  Timer _timeout;

  /**
     * Creates new instance of the timer and sets its values.
     * 
     * @param taskOrCallback    (optional) a Notifiable object or callback function to call when timer is triggered.
     * @param interval          (optional) an interval to trigger timer in milliseconds.
     * @param delay             (optional) a delay before the first triggering in milliseconds.
     * 
     * @see [[setTask]]
     * @see [[setCallback]]
     * @see [[setInterval]] 
     * @see [[setDelay]]
     */
  FixedRateTimer(
      [dynamic taskOrCallback = null, int interval = null, int delay = null]) {
    if (taskOrCallback.notify is Function) //
      this.setTask(taskOrCallback);
    else
      this.setCallback(taskOrCallback);

    this.setInterval(interval);
    this.setDelay(delay);
  }

  /** 
     * Gets the INotifiable object that receives notifications from this timer.
     * 
     * @returns the INotifiable object or null if it is not set.
     */
  INotifiable getTask() {
    return this._task;
  }

  /**
     * Sets a new INotifiable object to receive notifications from this timer.
     * 
     * @param value a INotifiable object to be triggered.
     */
  void setTask(INotifiable value) {
    this._task = value;
    this._callback = () {
      this._task.notify("pip-commons-timer", new Parameters());
    };
  }

  /** 
     * Gets the callback function that is called when this timer is triggered.
     * 
     * @returns the callback function or null if it is not set. 
     */
  Function() getCallback() {
    return this._callback;
  }

  /** 
     * Sets the callback function that is called when this timer is triggered.
     * 
     * @param value the callback function to be called.
     */
  setCallback(Function() value) {
    this._callback = value;
    this._task = null;
  }

  /**
     * Gets initial delay before the timer is triggered for the first time.
     * 
     * @returns the delay in milliseconds.
     */
  int getDelay() {
    return this._delay;
  }

  /** 
     * Sets initial delay before the timer is triggered for the first time.
     * 
     * @param value a delay in milliseconds. 
     */
  void setDelay(int value) {
    this._delay = value;
  }

  /**
     * Gets periodic timer triggering interval.
     * 
     * @returns the interval in milliseconds
     */
  int getInterval() {
    return this._interval;
  }

  /** 
     * Sets periodic timer triggering interval.
     * 
     * @param value an interval in milliseconds.
     */
  void setInterval(int value) {
    this._interval = value;
  }

  /** 
     * Checks if the timer is started.
     * 
     * @returns true if the timer is started and false if it is stopped.
     */
  bool isStarted() {
    return this._timer != null;
  }

  /**
     * Starts the timer.
     * 
     * Initially the timer is triggered after delay.
     * After that it is triggered after interval until it is stopped.
     * 
     * @see [[stop]]
     */
  void start() {
    // Stop previously set timer
    this.stop();

    // Exit if interval is not defined
    if (this._interval == null || this._interval <= 0) return;

    // Introducing delay
    var delay = max(0, this._delay - this._interval);

    this._timeout = Timer(new Duration(milliseconds: delay), () {
      this._timeout = null;

      // Set a new timer
      this._timer = Timer(new Duration(milliseconds: this._interval), () {
        try {
          if (this._callback != null) this._callback();
        } catch (ex) {
          // Ignore or better log!
        }
      });
    });
  }

  /**
     * Stops the timer.
     * 
     * @see [[start]]
     */
  stop() {
    if (this._timeout != null) {
      //clearTimeout(this._timeout);
      this._timeout.cancel();
      this._timeout = null;
    }

    if (this._timer != null) {
      //clearInterval(this._timer);
      this._timer.cancel();
      this._timer = null;
    }
  }

  /**
     * Closes the timer.
     * 
     * This is required by [[ICloseable]] interface,
     * but besides that it is identical to stop().
     * 
     * @param correlationId     (optional) transaction id to trace execution through call chain.
     * @param callback 			callback function that receives error or null no errors occured.
     * 
     * @see [[stop]]
     */
  close(String correlationId, [callback(dynamic err)]) {
    this.stop();

    if (callback != null) callback(null);
  }
}
