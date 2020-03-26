// let assert = require('chai').assert;
// let async = require('async');

// import { TestObject } from './TestObject';
// import { TestSubObject } from './TestSubObject';
// import { Schema } from '../../src/validate/Schema';
// import { AtLeastOneExistsRule } from '../../src/validate/AtLeastOneExistsRule';

// suite('AtLeastOneExistsRule', ()=> {

//     test('Only One Exists Rule', (done) => {
//         var obj = new TestObject();

//         var schema = new Schema().withRule(new AtLeastOneExistsRule("missingProperty", "stringProperty", "nullProperty"));
//         var results = schema.validate(obj);
//         assert.equal(results.length, 0);

//         var schema = new Schema().withRule(new AtLeastOneExistsRule("stringProperty", "nullProperty", "intField"));
//         var results = schema.validate(obj);
//         assert.equal(results.length, 0);

//         var schema = new Schema().withRule(new AtLeastOneExistsRule("missingProperty", "nullProperty"));
//         var results = schema.validate(obj);
//         assert.equal(results.length, 1);

//         done();
//     });

// });
