import '../convert/DoubleConverter.dart';
import '../convert/StringConverter.dart';

/**
 * Helper class to perform comparison operations over arbitrary values.
 * 
 * ### Example ###
 * 
 *     ObjectComparator.compare(2, "GT", 1);        // Result: true
 *     ObjectComparator.areEqual("A", "B");         // Result: false
 */
class ObjectComparator {
  /**
     * Perform comparison operation over two arguments.
     * The operation can be performed over values of any type.
     * 
     * @param value1        the first argument to compare
     * @param operation     the comparison operation: "==" ("=", "EQ"), "!= " ("<>", "NE"); "<"/">" ("LT"/"GT"), "<="/">=" ("LE"/"GE"); "LIKE".
     * @param value2        the second argument to compare
     * @returns result of the comparison operation
     */
  static bool compare(dynamic value1, String operation, dynamic value2) {
    operation = operation.toUpperCase();

    if (operation == "=" || operation == "==" || operation == "EQ")
      return ObjectComparator.areEqual(value1, value2);
    if (operation == "!=" || operation == "<>" || operation == "NE")
      return ObjectComparator.areNotEqual(value1, value2);
    if (operation == "<" || operation == "LT")
      return ObjectComparator.isLess(value1, value2);
    if (operation == "<=" || operation == "LE" || operation == "LTE")
      return ObjectComparator.areEqual(value1, value2) ||
          ObjectComparator.isLess(value1, value2);
    if (operation == ">" || operation == "GT")
      return ObjectComparator.isGreater(value1, value2);
    if (operation == ">=" || operation == "GE" || operation == "GTE")
      return ObjectComparator.areEqual(value1, value2) ||
          ObjectComparator.isGreater(value1, value2);
    if (operation == "LIKE") return ObjectComparator.match(value1, value2);

    return false;
  }

  /**
     * Checks if two values are equal.
     * The operation can be performed over values of any type.
     * 
     * @param value1    the first value to compare
     * @param value2    the second value to compare
     * @returns true if values are equal and false otherwise
     */
  static bool areEqual(dynamic value1, dynamic value2) {
    if (value1 == null && value2 == null) return true;
    if (value1 == null || value2 == null) return false;
    // TODO: must check this code
    return value1 == value2;    
  }

  /**
     * Checks if two values are NOT equal
     * The operation can be performed over values of any type.
     * 
     * @param value1    the first value to compare
     * @param value2    the second value to compare
     * @returns true if values are NOT equal and false otherwise
     */
  static bool areNotEqual(dynamic value1, dynamic value2) {
    return !ObjectComparator.areEqual(value1, value2);
  }

  /**
     * Checks if first value is less than the second one.
     * The operation can be performed over numbers or strings.
     * 
     * @param value1    the first value to compare
     * @param value2    the second value to compare
     * @returns true if the first value is less than second and false otherwise.
     */
  static bool isLess(dynamic value1, dynamic value2) {
    var number1 = DoubleConverter.toNullableDouble(value1);
    var number2 = DoubleConverter.toNullableDouble(value2);

    if (number1 == null || number2 == null) return false;

    return number1 < number2;
  }

  /**
     * Checks if first value is greater than the second one.
     * The operation can be performed over numbers or strings.
     * 
     * @param value1    the first value to compare
     * @param value2    the second value to compare
     * @returns true if the first value is greater than second and false otherwise.
     */
  static bool isGreater(dynamic value1, dynamic value2) {
    var number1 = DoubleConverter.toNullableDouble(value1);
    var number2 = DoubleConverter.toNullableDouble(value2);

    if (number1 == null || number2 == null) return false;

    return number1 > number2;
  }

  /**
     * Checks if string matches a regular expression
     * 
     * @param value     a string value to match
     * @param regexp    a regular expression string
     * @returns true if the value matches regular expression and false otherwise.
     */
  static bool match(dynamic value, dynamic regexp) {
    if (value == null && regexp == null) return true;
    if (value == null || regexp == null) return false;

    var str1 = StringConverter.toString2(value);
    var str2 = StringConverter.toString2(regexp);
    var reg = RegExp(str2);
    return reg.hasMatch(str1);
  }
}
