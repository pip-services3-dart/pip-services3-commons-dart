// let assert = require('chai').assert;

// import { TestObject } from './TestObject';
// import { Schema } from '../../src/validate/Schema';
// import { PropertiesComparisonRule } from '../../src/validate/PropertiesComparisonRule';

// suite('PropertiesComparisonRule', ()=> {

//     test('PropertiesComparisonRule', (done) => {
//         var obj = new TestObject();
//         var schema = new Schema().withRule(new PropertiesComparisonRule("stringProperty", "EQ", "nullProperty"));

//         obj.stringProperty = "ABC";
//         obj.nullProperty = "ABC";
//         var results = schema.validate(obj);
//         assert.equal(results.length, 0);

//         obj.nullProperty = "XYZ";
//         results = schema.validate(obj);
//         assert.equal(results.length, 1);

//         done();
//     });    

// });
