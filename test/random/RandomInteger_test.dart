// let assert = require('chai').assert;

// import { RandomInteger } from '../../src/random/RandomInteger';

// suite('RandomInteger', ()=> {

//     test('Next Integer', () => {
//     	let value = RandomInteger.nextInteger(5);
//         assert.isTrue(value <= 5);

//     	value = RandomInteger.nextInteger(2,5);
//     	assert.isTrue(value <= 5 && value >= 2);
//    });

//     test('Update Integer', () => {
//     	let value = RandomInteger.updateInteger(0, 5);
//         assert.isTrue(value <= 5 && value >= -5);

//         value = RandomInteger.updateInteger(5, 0);
//         assert.isTrue(value == 5);

//         value = RandomInteger.updateInteger(0);
//         assert.isTrue(value == 0);
//    });

//    test('Sequence', () => {
//         let list = RandomInteger.sequence(1,5);
//         assert.isTrue(list.length <= 5 && list.length >= 1);

//         list = RandomInteger.sequence(-1, 0);
//         assert.isTrue(list.length == 0);

//         list = RandomInteger.sequence(-1, -4);
//         assert.isTrue(list.length == 0);

//         list = RandomInteger.sequence(4, 4);
//         assert.isTrue(list.length == 4);

//         list = RandomInteger.sequence(5);
//         assert.isTrue(list.length == 5);
//     });

// });
