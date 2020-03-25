// let assert = require('chai').assert;

// import { ProjectionParams } from '../../src/data/ProjectionParams';

// suite('ProjectionParams', ()=> {

//     test('From Null', () => {
//         let parameters = new ProjectionParams(null);

//         assert.lengthOf(parameters, 0);
//     });
    
//     test('From Value', () => {
//         let parameters = ProjectionParams.fromValue([ "field1", "field2", "field3" ]);

//         assert.lengthOf(parameters, 3);
//         assert.equal("field1", parameters[0]);
//         assert.equal("field2", parameters[1]);
//         assert.equal("field3", parameters[2]);
//     });
    
//     test('Convert to string', () => {
//         let parameters = ProjectionParams.fromValue([ "field1", "field2", "field3" ]);

//         assert.equal(typeof(parameters.toString()), "string");
//         assert.equal(parameters, "field1,field2,field3");
//     });

//     test('Parse', () => {
//         let parameters = ProjectionParams.fromString("field1", "field2", "field3");

//         assert.equal(3, parameters.length);
//         assert.equal("field1", parameters[0]);
//         assert.equal("field2", parameters[1]);
//         assert.equal("field3", parameters[2]);

//         parameters = ProjectionParams.fromString("field1,field2, field3");

//         assert.equal(3, parameters.length);
//         assert.equal("field1", parameters[0]);
//         assert.equal("field2", parameters[1]);
//         assert.equal("field3", parameters[2]);

//         parameters = ProjectionParams.fromString("object1(field1)", "object2(field1, field2)", "field3");

//         assert.equal(4, parameters.length);
//         assert.equal("object1.field1", parameters[0]);
//         assert.equal("object2.field1", parameters[1]);
//         assert.equal("object2.field2", parameters[2]);
//         assert.equal("field3", parameters[3]);

//         parameters = ProjectionParams.fromString("object1(object2(field1,field2,object3(field1)))");

//         assert.equal(3, parameters.length);
//         assert.equal("object1.object2.field1", parameters[0]);
//         assert.equal("object1.object2.field2", parameters[1]);
//         assert.equal("object1.object2.object3.field1", parameters[2]);

//         parameters = ProjectionParams.fromString("object1(field1, object2(field1, field2, field3, field4), field3)", "field2");
        
//         assert.equal(7, parameters.length);
//         assert.equal("object1.field1", parameters[0]);
//         assert.equal("object1.object2.field1", parameters[1]);
//         assert.equal("object1.object2.field2", parameters[2]);
//         assert.equal("object1.object2.field3", parameters[3]);
//         assert.equal("object1.object2.field4", parameters[4]);
//         assert.equal("object1.field3", parameters[5]);
//         assert.equal("field2", parameters[6]);

//         parameters = ProjectionParams.fromString("object1(field1, object2(field1), field3)", "field2");

//         assert.equal(4, parameters.length);
//         assert.equal("object1.field1", parameters[0]);
//         assert.equal("object1.object2.field1", parameters[1]);
//         assert.equal("object1.field3", parameters[2]);
//         assert.equal("field2", parameters[3]);

//         parameters = ProjectionParams.fromString("object1(field1, object2(field1, field2, object3(field1), field4), field3)", "field2");

//         assert.equal(7, parameters.length);
//         assert.equal("object1.field1", parameters[0]);
//         assert.equal("object1.object2.field1", parameters[1]);
//         assert.equal("object1.object2.field2", parameters[2]);
//         assert.equal("object1.object2.object3.field1", parameters[3]);
//         assert.equal("object1.object2.field4", parameters[4]);
//         assert.equal("object1.field3", parameters[5]);
//         assert.equal("field2", parameters[6]);

//         parameters = ProjectionParams.fromString("object1(object2(object3(field1)), field2)", "field2");

//         assert.equal(3, parameters.length);
//         assert.equal("object1.object2.object3.field1", parameters[0]);
//         assert.equal("object1.field2", parameters[1]);
//         assert.equal("field2", parameters[2]);

//         parameters = ProjectionParams.fromString("field1,object1(field1),object2(field1,field2),object3(field1),field2,field3");

//         assert.equal(7, parameters.length);
//         assert.equal("field1", parameters[0]);
//         assert.equal("object1.field1", parameters[1]);
//         assert.equal("object2.field1", parameters[2]);
//         assert.equal("object2.field2", parameters[3]);
//         assert.equal("object3.field1", parameters[4]);
//         assert.equal("field2", parameters[5]);
//         assert.equal("field3", parameters[6]);        
//     });
    
// });