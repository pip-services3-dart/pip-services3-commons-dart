import 'package:test/test.dart';

import '../../lib/src/convert/TypeCode.dart';
import '../../lib/src/reflect/TypeMatcher.dart' as reflect;

void main() {
  group('TypeMatcher', () {
    test('Match Integer', () {
      expect(reflect.TypeMatcher.matchValueTypeByName("int", 123), isTrue);
      expect(reflect.TypeMatcher.matchValueTypeByName("Integer", 123), isTrue);
      expect(reflect.TypeMatcher.matchValueType(TypeCode.Long, 123), isTrue);
    });

    test('Match Boolean', () {
      expect(reflect.TypeMatcher.matchValueTypeByName("bool", true), isTrue);
      expect(reflect.TypeMatcher.matchValueTypeByName("Boolean", true), isTrue);
      expect(
          reflect.TypeMatcher.matchValueType(TypeCode.Boolean, true), isTrue);
    });

    test('Match Double', () {
      expect(
          reflect.TypeMatcher.matchValueTypeByName("double", 123.456), isTrue);
      expect(
          reflect.TypeMatcher.matchValueTypeByName("Double", 123.456), isTrue);
      expect(
          reflect.TypeMatcher.matchValueType(TypeCode.Double, 123.456), isTrue);
    });

    test('Match String', () {
      expect(reflect.TypeMatcher.matchValueTypeByName("string", "ABC"), isTrue);
      expect(
          reflect.TypeMatcher.matchValueType(TypeCode.String, "ABC"), isTrue);
    });

    test('Match DateTime', () {
      expect(reflect.TypeMatcher.matchValueTypeByName("date", DateTime.now()),
          isTrue);
      expect(
          reflect.TypeMatcher.matchValueTypeByName("DateTime", DateTime.now()),
          isTrue);
      expect(
          reflect.TypeMatcher.matchValueType(TypeCode.DateTime, DateTime.now()),
          isTrue);
    });

    test('Match Duration', () {
      expect(
          reflect.TypeMatcher.matchValueTypeByName("timespan", new Duration()),
          isTrue);
      expect(
          reflect.TypeMatcher.matchValueTypeByName("Duration", new Duration()),
          isTrue);
      expect(
          reflect.TypeMatcher.matchValueType(TypeCode.Duration, new Duration()),
          isTrue);
    });

    test('Match Map', () {
      var map = {};
      expect(reflect.TypeMatcher.matchValueTypeByName("map", map), isTrue);
      expect(reflect.TypeMatcher.matchValueTypeByName("dict", map), isTrue);
      expect(
          reflect.TypeMatcher.matchValueTypeByName("Dictionary", map), isTrue);
      expect(reflect.TypeMatcher.matchValueType(TypeCode.Map, map), isTrue);
    });

    test('Match Array', () {
      var array = [];
      expect(reflect.TypeMatcher.matchValueTypeByName("list", array), isTrue);
      expect(reflect.TypeMatcher.matchValueTypeByName("array", array), isTrue);
      expect(
          reflect.TypeMatcher.matchValueTypeByName("object[]", array), isTrue);
      expect(reflect.TypeMatcher.matchValueType(TypeCode.Array, array), isTrue);
    });
  });
}
