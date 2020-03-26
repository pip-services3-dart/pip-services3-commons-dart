// let assert = require('chai').assert;

// import { TestObject } from './TestObject';
// import { Schema } from '../../src/validate/Schema';
// import { OnlyOneExistsRule } from '../../src/validate/OnlyOneExistsRule';

// suite('OnlyOneExistsRule', ()=> {

//     test('OnlyOneExistsRule', (done) => {
//         var obj = new TestObject();

//         var schema = new Schema().withRule(new OnlyOneExistsRule("missingProperty", "stringProperty", "nullProperty"));
//         var results = schema.validate(obj);
//         assert.equal(results.length, 0);

//         var schema = new Schema().withRule(new OnlyOneExistsRule("stringProperty", "nullProperty", "intField"));
//         var results = schema.validate(obj);
//         assert.equal(results.length, 1);

//         done();
//     });

// });
