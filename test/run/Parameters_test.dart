// let assert = require('chai').assert;

// import { TestClass } from './TestClass';
// import { ConfigParams } from '../../src/config/ConfigParams';
// import { Parameters } from '../../src/run/Parameters';

// suite('Parameters', ()=> {
    
//     test('Defaults', () => {
//         var result = Parameters.fromTuples(
//             "value1", 123,
//             "value2", 234
//         );
//         var defaults = Parameters.fromTuples(
//             "value2", 432,
//             "value3", 345
//         );
//         result = result.setDefaults(defaults, false);
//         assert.equal(3, result.length());
//         assert.equal(123, result["value1"]);
//         assert.equal(234, result["value2"]);
//         assert.equal(345, result["value3"]);
//     });

//     test('Override Recursive', () => {
//         var result = Parameters.fromJson(
//             "{ \"value1\": 123, \"value2\": { \"value21\": 111, \"value22\": 222 } }"
//         );
//         var defaults = Parameters.fromJson(
//             "{ \"value2\": { \"value22\": 777, \"value23\": 333 }, \"value3\": 345 }"
//         );
//         result = result.setDefaults(defaults, true);

//         assert.equal(3, result.length());
//         assert.equal(123, result.get("value1"));
//         assert.equal(345, result.get("value3"));

//         var deepResult = result.getAsMap("value2");
//         assert.equal(3, deepResult.length());
//         assert.equal(111, deepResult.getAsInteger("value21"));
//         assert.equal(222, deepResult.getAsInteger("value22"));
//         assert.equal(333, deepResult.getAsInteger("value23"));
//     });

//     test('Override With Nulls', () => {
//         var result = Parameters.fromJson(
//             "{ \"value1\": 123, \"value2\": 234 }"
//         );
//         result = result.override(null, true);

//         assert.equal(2, result.length());
//         assert.equal(123, result.get("value1"));
//         assert.equal(234, result.get("value2"));
//     });

//     test('Assign To', () => {
//         var value = new TestClass(null, null);
//         var newValues = Parameters.fromJson(
//             "{ \"value1\": 123, \"value2\": \"ABC\", \"value3\": 456 }"
//         );

//         newValues.assignTo(value);
//         assert.isNotNull(value.value1);
//         assert.equal(123, value.value1);
//         assert.isNotNull(value.value2);
//         assert.equal("ABC", value.value2);
//     });

//     test('Get', () => {
//         var config = Parameters.fromJson(
//             "{ \"value1\": 123, \"value2\": { \"value21\": 111, \"value22\": 222 } }"
//         );

//         var value = config.get("");
//         assert.isNull(value);

//         value = config.getAsInteger("value1");
//         assert.isNotNull(value);
//         assert.equal(123, value);

//         value = config.get("value2");
//         assert.isNotNull(value);

//         var boolVal = config.containsKey("value3");
//         assert.isFalse(boolVal);

//         value = config.getAsInteger("value2.value21");
//         assert.isNotNull(value);
//         assert.equal(111, value);

//         boolVal = config.containsKey("value2.value31");
//         assert.isFalse(boolVal);

//         boolVal = config.containsKey("value2.value21.value211");
//         assert.isFalse(boolVal);

//         boolVal = config.containsKey("valueA.valueB.valueC");
//         assert.isFalse(boolVal);
//     });    

//     test('Contains', () => {
//         var config = Parameters.fromJson(
//             "{ \"value1\": 123, \"value2\": { \"value21\": 111, \"value22\": 222 } }"
//         );

//         var has = config.containsKey("");
//         assert.isFalse(has);

//         has = config.containsKey("value1");
//         assert.isTrue(has);

//         has = config.containsKey("value2");
//         assert.isTrue(has);

//         has = config.containsKey("value3");
//         assert.isFalse(has);

//         has = config.containsKey("value2.value21");
//         assert.isTrue(has);

//         has = config.containsKey("value2.value31");
//         assert.isFalse(has);

//         has = config.containsKey("value2.value21.value211");
//         assert.isFalse(has);

//         has = config.containsKey("valueA.valueB.valueC");
//         assert.isFalse(has);
//     });

//     test('Set', () => {
//         let config: Parameters = new Parameters();

//         config.put(null, 123);
//         assert.equal(0, config.length());

//         config.put("field1", 123);
//         assert.equal(1, config.length());
//         assert.equal(123, config.getAsInteger("field1"));

//         config.put("field2", "ABC");
//         assert.equal(2, config.length());
//         assert.equal("ABC", config.get("field2"));

//         config.put("field2.field1", 123);
//         assert.equal("ABC", config.get("field2"));

//         config.put("field3.field31", 456);
//         assert.equal(3, config.length());
//         var subConfig = config.getAsMap("field3");
//         assert.isNotNull(subConfig);
//         assert.equal(456, subConfig.getAsInteger("field31"));

//         config.put("field3.field32", "XYZ");
//         assert.equal("XYZ", config.get("field3.field32"));
//     });

//     test('From Config', () => {
//         var config = ConfigParams.fromTuples(
//             "field1.field11", 123,
//             "field2", "ABC",
//             "field1.field12", "XYZ"
//         );

//         var parameters = Parameters.fromConfig(config);
//         assert.equal(2, parameters.length());
//         assert.equal("ABC", parameters.get("field2"));

//         var value = parameters.getAsMap("field1");
//         assert.equal(2, value.length());
//         assert.equal("123", value.get("field11"));
//         assert.equal("XYZ", value.get("field12"));
//     });

// });