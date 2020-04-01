import './RandomInteger.dart';


/// Random generator for Date time values.

/// ### Example ###

///     var value1 = RandomDateTime.nextDate( Date(2010,0,1));    // Possible result: 2008-01-03
///     var value2 = RandomDateTime.nextDateTime( Date(2017,0.1));// Possible result: 2007-03-11 11:20:32
///     var value3 = RandomDateTime.updateDateTime( Date(2010,1,2));// Possible result: 2010-02-05 11:33:23
 
class RandomDateTime {
  
    /// Generates a random Date in the range ['min', 'max'].
    /// This method generate dates without time (or time set to 00:00:00)
    
    /// - [min]   (optional) minimum range value
    /// - [max]   max range value
    /// Returns     a random Date value.
     
  static DateTime nextDate(DateTime min, [DateTime max = null]) {
    if (max == null) {
      max = min;
      min =  DateTime(max.year - 10, 1, 1);
    }

    var diff = max.millisecondsSinceEpoch - min.millisecondsSinceEpoch;
    if (diff <= 0) return min;

    var time = min.millisecondsSinceEpoch + RandomInteger.nextInteger(0, diff);
    var date = DateTime.fromMillisecondsSinceEpoch(time);

    return date;
  }

  
    /// Generates a random Date and time in the range ['min', 'max'].
    /// This method generate dates without time (or time set to 00:00:00)
    
    /// - [min]   (optional) minimum range value
    /// - [max]   max range value
    /// Returns     a random Date and time value.
     
  static DateTime nextDateTime(DateTime min, [DateTime max = null]) {
    if (max == null) {
      max = min;
      min =  DateTime(2000, 0, 1);
    }

    var diff = max.millisecondsSinceEpoch - min.millisecondsSinceEpoch;
    if (diff <= 0) return min;

    var time = min.millisecondsSinceEpoch + RandomInteger.nextInteger(0, diff);
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  
    /// Updates (drifts) a Date value within specified range defined
    
    /// - [value]     a Date value to drift.
    /// - [range]     (optional) a range in milliseconds. Default: 10 days
     
  static DateTime updateDateTime(DateTime value, [int range = null]) {
    range = range != 0 && range != null ? range : 10* 24* 3600000;
    if (range < 0) return value;

    var time =
        value.millisecondsSinceEpoch + RandomInteger.nextInteger(-range, range);
    return DateTime.fromMillisecondsSinceEpoch(time);
  }
}
