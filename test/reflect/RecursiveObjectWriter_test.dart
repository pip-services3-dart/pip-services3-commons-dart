// let assert = require('chai').assert;

// import { TestClass } from './TestClass';
// import { RecursiveObjectReader } from '../../src/reflect/RecursiveObjectReader';
// import { RecursiveObjectWriter } from '../../src/reflect/RecursiveObjectWriter';

// suite('RecursiveObjectWriter', ()=> {

//    test('Set Property', () => {       
//         let obj = { 
//             "value1": 123, 
//             "value2": { 
//                 "value21": 111, 
//                 "value22": 222 
//             }, 
//             "value3": [ 444, { "value311": 555 } ] 
//         };

//         //RecursiveObjectWriter.setProperty(obj, "", null);
//         RecursiveObjectWriter.setProperty(obj, "value1", "AAA");
//         RecursiveObjectWriter.setProperty(obj, "value2", "BBB");
//         RecursiveObjectWriter.setProperty(obj, "value3.1.value312", "CCC");
//         RecursiveObjectWriter.setProperty(obj, "value3.3", "DDD");
//         RecursiveObjectWriter.setProperty(obj, "value4.1", "EEE");
        
//         let values = RecursiveObjectReader.getProperties(obj);
//         //assert.equal(8, values.length);
//         assert.equal("AAA", values["value1"]);
//         assert.equal("BBB", values["value2"]);
//         assert.isUndefined(values["value2.value21"]);
//         assert.equal(444, values["value3.0"]);
//         assert.equal(555, values["value3.1.value311"]);
//         assert.equal("CCC", values["value3.1.value312"]);
//         assert.isUndefined(values["value3.2"]);
//         assert.equal("DDD", values["value3.3"]);
//         assert.equal("EEE", values["value4.1"]);
//    });

//    test('Set Properties', () => {       
//         let obj = { 
//             "value1": 123, 
//             "value2": { 
//                 "value21": 111, 
//                 "value22": 222 
//             }, 
//             "value3": [ 444, { "value311": 555 } ] 
//         };

//         let values = {
//     		//"", null,
//     		"value1": "AAA",
//     		"value2": "BBB",
//     		"value3.1.value312": "CCC",
//     		"value3.3": "DDD",
//     		"value4.1": "EEE"
//         };
//         RecursiveObjectWriter.setProperties(obj, values);
        
//         values = RecursiveObjectReader.getProperties(obj);
//         //assert.equal(8, values.length);
//         assert.equal("AAA", values["value1"]);
//         assert.equal("BBB", values["value2"]);
//         assert.isUndefined(values["value2.value21"]);
//         assert.equal(444, values["value3.0"]);
//         assert.equal(555, values["value3.1.value311"]);
//         assert.equal("CCC", values["value3.1.value312"]);
//         assert.isUndefined(values["value3.2"]);
//         assert.equal("DDD", values["value3.3"]);
//         assert.equal("EEE", values["value4.1"]);
//    });

// });
