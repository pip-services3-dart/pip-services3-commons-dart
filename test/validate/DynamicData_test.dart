// let assert = require('chai').assert;
// let async = require('async');

// import { JsonConverter } from '../../src/convert/JsonConverter';
// import { ObjectSchema } from '../../src/validate/ObjectSchema';
// import { TypeCode } from '../../src/convert/TypeCode';

// suite('DynamicData', ()=> {

//     test('Validate dynamic data', (done) => {
//         let dynamicString = '{ "string_field": "ABC", "date_field": "2019-01-01T11:30:00.00", "int_field": 123, "float_field": 123.456 }';
//         let dynamicObject = JSON.parse(dynamicString);

//         var schema = new ObjectSchema()
//             .withRequiredProperty("string_field", TypeCode.String)
//             .withRequiredProperty("date_field", TypeCode.DateTime)
//             .withRequiredProperty("int_field", TypeCode.Integer)
//             .withRequiredProperty("float_field", TypeCode.Float);
//         var results = schema.validate(dynamicObject);
//         assert.equal(results.length, 0);

//         done();
//     });

// });
