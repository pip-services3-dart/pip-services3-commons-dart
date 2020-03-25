// let assert = require('chai').assert;

// import { TestClass } from './TestClass';
// import { ObjectWriter } from '../../src/reflect/ObjectWriter';

// suite('ObjectWriter', ()=> {

//    test('Set Object Property', () => {       
// 		let obj = new TestClass();

// 		ObjectWriter.setProperty(obj, "privateField", "XYZ");
		
// 		ObjectWriter.setProperty(obj, "publicField", "AAAA");
// 		assert.equal("AAAA", obj.publicField);
		
//         let now = new Date();
// 		ObjectWriter.setProperty(obj, "publicProp", now);
//         assert.equal(now, obj.publicProp);

// 		ObjectWriter.setProperty(obj, "publicProp", "BBBB");
//         //assert.equal(now, obj.publicProp);
//    });

//    test('Set Map Property', () => {       
// 		let map = {
// 			"key1": 123,
// 			"key2": "ABC"
//         };

// 		ObjectWriter.setProperty(map, "key3", "AAAA");
//         assert.equal("AAAA", map["key3"]);
		
// 		ObjectWriter.setProperty(map, "Key1", 5555);
//         assert.equal(5555, map["key1"]);
		
// 		ObjectWriter.setProperty(map, "Key2", "BBBB");
//         assert.equal("BBBB", map["key2"]);
//    });

//    test('Set Array Property', () => {       
//         let list = [123, "ABC"];

// 		ObjectWriter.setProperty(list, "3", "AAAA");
// 		assert.equal(4, list.length);
//         assert.equal("AAAA", list[3]);
		
// 		ObjectWriter.setProperty(list, "0", 1111);
//         assert.equal(1111, list[0]);
		
// 		ObjectWriter.setProperty(list, "1", "BBBB");
//         assert.equal("BBBB", list[1]);

//         let array = [ 123, "ABC" ];
		
// 		ObjectWriter.setProperty(array, "3", "AAAA");
// 		assert.equal(4, array.length);
		
// 		ObjectWriter.setProperty(array, "0", 1111);
// 		assert.equal(1111, array[0]);
		
// 		ObjectWriter.setProperty(array, "1", "BBBB");
// 		assert.equal("BBBB", array[1]);
//    });

// });
