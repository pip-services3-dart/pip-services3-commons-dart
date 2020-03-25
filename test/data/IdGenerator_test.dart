// let assert = require('chai').assert;

// import { IdGenerator } from '../../src/data/IdGenerator';

// suite('IdGenerator', ()=> {
    
//     test('Short Id', () => {
// 			let id1 = IdGenerator.nextShort();
// 			assert.isNotNull(id1);
// 			assert.isTrue(id1.length >= 9);
			
// 			let id2 = IdGenerator.nextShort();
// 			assert.isNotNull(id2);
// 			assert.isTrue(id2.length >= 9);
// 			assert.isFalse(id1 == id2);
//     });    

//     test('Long Id', () => {
// 			let id1 = IdGenerator.nextLong();
// 			assert.isNotNull(id1);
// 			assert.isTrue(id1.length >= 32);
			
// 			let id2 = IdGenerator.nextLong();
// 			assert.isNotNull(id2);
// 			assert.isTrue(id2.length >= 32);
// 			assert.isFalse(id1 == id2);
//     });    

// });