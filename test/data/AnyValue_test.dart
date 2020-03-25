// let assert = require('chai').assert;

// import { TypeCode } from '../../src/convert/TypeCode';
// import { AnyValue } from '../../src/data/AnyValue';

import "package:test/test.dart";
import "../../lib/src/data/AnyValue.dart";
import "../../lib/src/convert/TypeCode.dart";


void main() {
  group('AnyValue', () {
      test('Get and Set', () {
        var value = new AnyValue();
        expect(value.getAsObject(), isNull);

        value.setAsObject(1);
        expect(value.getAsInteger(), 1);
        expect(1.0 - value.getAsFloat() < 0.001, isTrue);
        expect(value.getAsString(), "1");
      });

      test('Equal', () {
        var value = new AnyValue(1);

        expect(value.equals(1), isTrue);
       // expect(value.equals(1.0), isTrue);
        expect(value.equals("1"), isTrue);
        expect(value.equalsAsType<double>(TypeCode.Float, "1"), isTrue);
    });    

  });
}