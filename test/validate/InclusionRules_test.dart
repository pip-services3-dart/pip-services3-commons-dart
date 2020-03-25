// let assert = require('chai').assert;

// import { Schema } from '../../src/validate/Schema';
// import { IncludedRule } from '../../src/validate/IncludedRule';
// import { ExcludedRule } from '../../src/validate/ExcludedRule';

// suite('Inclusion Rules', ()=> {

//     test('IncludedRule', (done) => {
//         var schema = new Schema().withRule(new IncludedRule("AAA", "BBB", "CCC", null));

//         var results = schema.validate("AAA");
//         assert.equal(results.length, 0);

//         results = schema.validate("ABC");
//         assert.equal(results.length, 1);

//         done();
//     });    

//     test('ExcludedRule', (done) => {
//         var schema = new Schema().withRule(new ExcludedRule("AAA", "BBB", "CCC", null));

//         var results = schema.validate("AAA");
//         assert.equal(results.length, 1);

//         results = schema.validate("ABC");
//         assert.equal(results.length, 0);

//         done();
//     });    

// });
