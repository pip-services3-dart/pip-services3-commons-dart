import 'package:test/test.dart';
import './TestClass.dart';
import '../../lib/src/config/ConfigParams.dart';
import '../../lib/src/run/Parameters.dart';
import 'dart:convert';
void main(){
group('Parameters', () {

    test('Defaults', ()  {
        var result = Parameters.fromTuples(
            ["value1", 123,
            "value2", 234]
        );
        var defaults = Parameters.fromTuples(
            ["value2", 432,
            "value3", 345]
        );
        result = result.setDefaults(defaults, false);
        expect(3, result.length);
        expect(123, result["value1"]);
        expect(234, result["value2"]);
        expect(345, result["value3"]);
    });

    test('Override Recursive', ()  {
        var result = Parameters.fromJsonString(
            "{ \"value1\": 123, \"value2\": { \"value21\": 111, \"value22\": 222 } }"
        );
        var defaults = Parameters.fromJsonString(
            "{ \"value2\": { \"value22\": 777, \"value23\": 333 }, \"value3\": 345 }"
        );
        result = result.setDefaults(defaults, true);

        expect(3, result.length);
        expect(123, result.get("value1"));
        expect(345, result.get("value3"));

        var deepResult = result.getAsMap("value2");
        expect(3, deepResult.length);
        expect(111, deepResult.getAsInteger("value21"));
        expect(222, deepResult.getAsInteger("value22"));
        expect(333, deepResult.getAsInteger("value23"));
    });

    test('Override With Nulls', ()  {
        var result = Parameters.fromJsonString(
            "{ \"value1\": 123, \"value2\": 234 }"
        );
        result = result.override(null, true);

        expect(2, result.length);
        expect(123, result.get("value1"));
        expect(234, result.get("value2"));
    });

    test('Assign To', ()  {
        var value = new TestClass(null, null);
        var newValues = Parameters.fromJsonString(
            "{ \"value1\": 123, \"value2\": \"ABC\", \"value3\": 456 }"
        );

        newValues.assignTo(value);
        expect(value.value1, isNotNull);
        expect(123, value.value1);
        expect(value.value2, isNotNull);
        expect("ABC", value.value2);
    });

    test('Get', ()  {
        var config = Parameters.fromJsonString(
            "{ \"value1\": 123, \"value2\": { \"value21\": 111, \"value22\": 222 } }"
        );

        var value = config.get("");
        expect(value, isNull);

        value = config.getAsInteger("value1");
        expect(value, isNotNull);
        expect(123, value);

        value = config.get("value2");
        expect(value, isNotNull);

        var boolVal = config.containsKey("value3");
        expect(boolVal, isFalse);

        value = config.getAsInteger("value2.value21");
        expect(value, isNotNull);
        expect(111, value);

        boolVal = config.containsKey("value2.value31");
        expect(boolVal, isFalse);

        boolVal = config.containsKey("value2.value21.value211");
        expect(boolVal, isFalse);

        boolVal = config.containsKey("valueA.valueB.valueC");
        expect(boolVal, isFalse);
    });

    test('Contains', ()  {
        var config = Parameters.fromJsonString(
            "{ \"value1\": 123, \"value2\": { \"value21\": 111, \"value22\": 222 } }"
        );

        var has = config.containsKey("");
        expect(has, isFalse);

        has = config.containsKey("value1");
        expect(has, isTrue);

        has = config.containsKey("value2");
        expect(has, isTrue);

        has = config.containsKey("value3");
        expect(has, isFalse);

        has = config.containsKey("value2.value21");
        expect(has, isTrue);

        has = config.containsKey("value2.value31");
        expect(has, isFalse);

        has = config.containsKey("value2.value21.value211");
        expect(has, isFalse);

        has = config.containsKey("valueA.valueB.valueC");
        expect(has, isFalse);
    });

    test('Set', ()  {
        var config = new Parameters();

        config.put(null, 123);
        expect(0, config.length);

        config.put("field1", 123);
        expect(1, config.length);
        expect(123, config.getAsInteger("field1"));

        config.put("field2", "ABC");
        expect(2, config.length);
        expect("ABC", config.get("field2"));

        config.put("field2.field1", 123);
        expect("ABC", config.get("field2"));

        config.put("field3.field31", 456);
        expect(3, config.length);
        var subConfig = config.getAsMap("field3");
        expect(subConfig, isNotNull);
        expect(456, subConfig.getAsInteger("field31"));

        config.put("field3.field32", "XYZ");
        expect("XYZ", config.get("field3.field32"));
    });

    test('From Config', ()  {
        var config = ConfigParams.fromTuples(
            ["field1.field11", 123,
            "field2", "ABC",
            "field1.field12", "XYZ"]
        );

        var parameters = Parameters.fromConfig(config);
        expect(2, parameters.length);
        expect("ABC", parameters.get("field2"));

        var value = parameters.getAsMap("field1");
        expect(2, value.length);
        expect("123", value.get("field11"));
        expect("XYZ", value.get("field12"));
    });

});
}