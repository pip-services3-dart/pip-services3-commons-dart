// let assert = require('chai').assert;

// import { TestObject } from './TestObject';
// import { Schema } from '../../src/validate/Schema';
// import { ValueComparisonRule } from '../../src/validate/ValueComparisonRule';

// suite('ValueComparisonRule', ()=> {

//     test('Number Equal Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("EQ", 123));
//         var results = schema.validate(123);
//         assert.equal(results.length, 0);

//         results = schema.validate(432);
//         assert.equal(results.length, 1);

//         done();
//     });    

//     test('String Equal Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("EQ", "ABC"));
//         var results = schema.validate("ABC");
//         assert.equal(results.length, 0);

//         results = schema.validate("XYZ");
//         assert.equal(results.length, 1);

//         done();
//     });    

//     test('Number Not Equal Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("NE", 123));
//         var results = schema.validate(123);
//         assert.equal(results.length, 1);

//         results = schema.validate(432);
//         assert.equal(results.length, 0);

//         done();
//     });    

//     test('String Not Equal Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("NE", "ABC"));
//         var results = schema.validate("ABC");
//         assert.equal(results.length, 1);

//         results = schema.validate("XYZ");
//         assert.equal(results.length, 0);

//         done();
//     });    

//     test('Less Than or Equal Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("LE", 123));
//         var results = schema.validate(123);
//         assert.equal(results.length, 0);

//         results = schema.validate(432);
//         assert.equal(results.length, 1);

//         done();
//     });    

//     test('Less Than Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("LT", 123));
//         var results = schema.validate(123);
//         assert.equal(results.length, 1);

//         results = schema.validate(0);
//         assert.equal(results.length, 0);

//         done();
//     });    

//     test('More Than or Equal Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("GE", 123));
//         var results = schema.validate(123);
//         assert.equal(results.length, 0);

//         results = schema.validate(432);
//         assert.equal(results.length, 0);

//         results = schema.validate(0);
//         assert.equal(results.length, 1);

//         done();

//     });    

//     test('More Than Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("GT", 123));
//         var results = schema.validate(123);
//         assert.equal(results.length, 1);

//         results = schema.validate(432);
//         assert.equal(results.length, 0);

//         results = schema.validate(0);
//         assert.equal(results.length, 1);

//         done();
//     });    

//     test('Match Comparison', (done) => {
//         var schema = new Schema().withRule(new ValueComparisonRule("LIKE", "A.*"));
//         var results = schema.validate("ABC");
//         assert.equal(results.length, 0);

//         results = schema.validate("XYZ");
//         assert.equal(results.length, 1);

//         done();
//     });    

// });
