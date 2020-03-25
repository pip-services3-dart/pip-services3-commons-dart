// let assert = require('chai').assert;

// import { Descriptor } from '../../src/refer/Descriptor';

// suite('Descriptor', ()=> {
    
//     test('Match', () => {
// 			let descriptor = new Descriptor("pip-dummies", "controller", "default", "default", "1.0");

// 			// Check match by individual fields
// 			assert.isTrue(descriptor.match(new Descriptor(null, null, null, null, null)));
// 			assert.isTrue(descriptor.match(new Descriptor("pip-dummies", "controller", null, null, null)));
// 			assert.isTrue(descriptor.match(new Descriptor(null, null, "default", null, null)));
// 			assert.isTrue(descriptor.match(new Descriptor(null, null, null, null, "1.0")));

// 			// Check match by individual "*" fields
// 			assert.isTrue(descriptor.match(new Descriptor("pip-dummies", "*", "*", "*", "*")));
// 			assert.isTrue(descriptor.match(new Descriptor("*", "controller", "*", "*", "*")));
// 			assert.isTrue(descriptor.match(new Descriptor("*", "*", "default", "*", "*")));
// 			assert.isTrue(descriptor.match(new Descriptor("*", "*", "*", "*", "1.0")));

// 			// Check match by all values
// 			assert.isTrue(descriptor.match(new Descriptor("pip-dummies", "controller", "default", "default", null)));
// 			assert.isTrue(descriptor.match(new Descriptor(null, "controller", "default", "default", "1.0")));
// 			assert.isTrue(descriptor.match(new Descriptor("pip-dummies", "controller", "default", "default", "1.0")));
			
// 			// Check mismatch by individual fields
// 			assert.isFalse(descriptor.match(new Descriptor(null, "cache", null, null, null)));
// 			assert.isFalse(descriptor.match(new Descriptor("pip-commons", "controller", null, null, null)));
// 			assert.isFalse(descriptor.match(new Descriptor(null, null, "special", null, null)));
// 			assert.isFalse(descriptor.match(new Descriptor(null, null, null, null, "2.0")));
//     });    

//     test('To String', () => {
// 			let descriptor1 = new Descriptor("pip-dummies", "controller", "default", "default", "1.0");		
// 			assert.equal("pip-dummies:controller:default:default:1.0", descriptor1.toString());

// 			let descriptor2 = new Descriptor(null, "controller", null, null, null);		
// 			assert.equal("*:controller:*:*:*", descriptor2.toString());
//     });    

//     test('From String', () => {
// 			let descriptor = Descriptor.fromString(null);
// 			assert.isNull(descriptor);
			
// 			descriptor = Descriptor.fromString("pip-dummies:controller:default:default:1.0");
// 			assert.isTrue(descriptor.exactMatch(new Descriptor("pip-dummies", "controller", "default", "default", "1.0")));
			
// 			try {
// 				Descriptor.fromString("xxx");
// 				assert.fail("Descriptor.fromString shall throw an exception");
// 			} catch (ex) {
// 				// Ok...
// 			}
//     });    

// });