import 'package:pip_services3_commons/src/convert/convert.dart';
import 'package:test/test.dart';

void main() {
  group('TypeConverter', () {
    test('To Type Code', () {
      // assert.equal(TypeCode.String, TypeConverter.toTypeCode(typeof('abc')));
      // assert.equal(TypeCode.Double, TypeConverter.toTypeCode(typeof(123)));
      // assert.equal(TypeCode.Double, TypeConverter.toTypeCode(typeof(123.456)));
      // assert.equal(TypeCode.Map, TypeConverter.toTypeCode(typeof( Date())));
      // assert.equal(TypeCode.Map, TypeConverter.toTypeCode(typeof([])));
      // assert.equal(TypeCode.Map, TypeConverter.toTypeCode(typeof({})));
      // assert.equal(TypeCode.Object, TypeConverter.toTypeCode(typeof(() => true)));
      // assert.equal(TypeCode.Unknown, TypeConverter.toTypeCode(null));

      expect(TypeConverter.toTypeCode('123'), equals(TypeCode.String));
      expect(TypeConverter.toTypeCode(123), equals(TypeCode.Long));
      expect(TypeConverter.toTypeCode(123.456), equals(TypeCode.Double));
      expect(TypeConverter.toTypeCode(DateTime(1975, 4, 8)),
          equals(TypeCode.DateTime));
      expect(TypeConverter.toTypeCode(Duration()), equals(TypeCode.Duration));
      //assert.equal(ConverterTypeCode.Enum, TypeConverter.toTypeCode(Enum.class));
      expect(TypeConverter.toTypeCode([]), equals(TypeCode.Array));
      expect(TypeConverter.toTypeCode({}), equals(TypeCode.Map));
      expect(TypeConverter.toTypeCode(() => true), equals(TypeCode.Object));
    });

    test('To Nullable Type', () {
      expect(TypeConverter.toNullableType<String>(TypeCode.String, 123),
          equals('123'));
      expect(TypeConverter.toNullableType<int>(TypeCode.Integer, '123'),
          equals(123));
      expect(TypeConverter.toNullableType<int>(TypeCode.Long, 123.456),
          equals(124));
      expect(TypeConverter.toNullableType<double>(TypeCode.Float, 123),
          equals(123.0));
      expect(TypeConverter.toNullableType<double>(TypeCode.Double, 123),
          equals(123.0));
      expect(
          TypeConverter.toNullableType<DateTime>(
              TypeCode.DateTime, '1975-04-08T17:30:00.00Z'),
          equals(DateTimeConverter.toDateTime('1975-04-08T17:30:00.00Z')));
      expect(TypeConverter.toNullableType<Duration>(TypeCode.Duration, '123'),
          equals(Duration(milliseconds: 123)));
      expect(TypeConverter.toNullableType<List>(TypeCode.Array, 123)!.length,
          equals(1));
      //assert.equal(1, TypeConverter.toNullableType<any>(TypeCode.Map, StringValueMap.fromString('abc=123')).length);
    });

    test('To Type', () {
      expect(TypeConverter.toType<String>(TypeCode.String, 123), equals('123'));
      expect(TypeConverter.toType<int>(TypeCode.Integer, '123'), equals(123));
      expect(TypeConverter.toType<int>(TypeCode.Long, 123.456), equals(124));
      expect(TypeConverter.toType<double>(TypeCode.Float, 123), equals(123.0));
      expect(TypeConverter.toType<double>(TypeCode.Double, 123), equals(123.0));
      expect(
          TypeConverter.toType<DateTime>(
              TypeCode.DateTime, '1975-04-08T17:30:00.00Z'),
          equals(DateTimeConverter.toDateTime('1975-04-08T17:30:00.00Z')));
      expect(TypeConverter.toType<Duration>(TypeCode.Duration, '123'),
          equals(Duration(milliseconds: 123)));
      expect(TypeConverter.toType<List>(TypeCode.Array, 123).length, equals(1));
      //assert.equal(1, TypeConverter.toType<any>(TypeCode.Map, StringValueMap.fromString('abc=123')).length);
    });

    test('To Type With Default', () {
      expect(
          TypeConverter.toTypeWithDefault<String>(TypeCode.String, null, '123'),
          equals('123'));
      expect(TypeConverter.toTypeWithDefault<int>(TypeCode.Integer, null, 123),
          equals(123));
      expect(TypeConverter.toTypeWithDefault<int>(TypeCode.Long, null, 123),
          equals(123));
      expect(TypeConverter.toTypeWithDefault<double>(TypeCode.Float, null, 123),
          equals(123.0));
      expect(
          TypeConverter.toTypeWithDefault<double>(TypeCode.Double, null, 123),
          equals(123.0));
      expect(
          TypeConverter.toTypeWithDefault<DateTime>(TypeCode.DateTime, null,
              DateTimeConverter.toDateTime('1975-04-08T17:30:00.00Z')),
          equals(DateTimeConverter.toDateTime('1975-04-08T17:30:00.00Z')));
      expect(
          TypeConverter.toTypeWithDefault<Duration>(
              TypeCode.Duration, null, Duration(milliseconds: 123)),
          equals(Duration(milliseconds: 123)));
      expect(
          TypeConverter.toTypeWithDefault<List>(TypeCode.Array, null, [123])
              .length,
          equals(1));
      //assert.equal(1, TypeConverter.toTypeWithDefault<any>(TypeCode.Map, StringValueMap.fromString('abc=123'), null)).length);
    });
  });
}
