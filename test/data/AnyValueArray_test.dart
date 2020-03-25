// let assert = require('chai').assert;

// import { TypeCode } from '../../src/convert/TypeCode';
// import { AnyValueArray } from '../../src/data/AnyValueArray';

// suite('AnyValueArray', ()=> {
    
//     test('Create', () => {
//         let array = new AnyValueArray();
//         assert.equal(0, array.length);

//         array = new AnyValueArray([ 1, 2, 3 ]);
//         assert.equal(3, array.length);
//         assert.equal("1,2,3", array.toString());

//         array = AnyValueArray.fromString("Fatal,Error,Info,", ",");
//         assert.equal(4, array.length);

//         array = new AnyValueArray([ 1, 2, 3 ]);
//         assert.equal(3, array.length);
//         assert.isTrue(array.contains(1));
//     });    

// });