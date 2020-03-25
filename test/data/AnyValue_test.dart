// let assert = require('chai').assert;

// import { TypeCode } from '../../src/convert/TypeCode';
// import { AnyValue } from '../../src/data/AnyValue';

// suite('AnyValue', ()=> {
    
//     test('Get and Set', () => {
//         let value = new AnyValue();
//         assert.isNull(value.getAsObject());

//         value.setAsObject(1);
//         assert.equal(1, value.getAsInteger());
//         assert.isTrue(1.0 - value.getAsFloat() < 0.001);
//         assert.equal("1", value.getAsString());
//     });    

//     test('Equal', () => {
//         let value = new AnyValue(1);

//         assert.isTrue(value.equals(1));
//         assert.isTrue(value.equals(1.0));
//         assert.isTrue(value.equals("1"));
//         assert.isTrue(value.equalsAsType<number>(TypeCode.Float, "1"));
//     });    

// });