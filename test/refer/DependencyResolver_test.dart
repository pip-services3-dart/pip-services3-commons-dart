// let assert = require('chai').assert;

// import { References } from '../../src/refer/References';
// import { DependencyResolver } from '../../src/refer/DependencyResolver';
// import { Descriptor } from '../../src/refer/Descriptor';
// import { ConfigParams } from '../../src/config/ConfigParams';

// suite('DependencyResolver', ()=> {
    
//     test('Resolve depedencies', () => {
// 		let ref1 = {};
// 		let ref2 = {};
// 		let refs = References.fromTuples(
// 			"Reference1", ref1,
// 			new Descriptor("pip-services-commons", "reference", "object", "ref2", "1.0"), ref2
// 		);
		
// 		let resolver = DependencyResolver.fromTuples(
// 			"ref1", "Reference1",
// 			"ref2", new Descriptor("pip-services-commons", "reference", "*", "*", "*")
// 		);
// 		resolver.setReferences(refs);
	
// 		assert.equal(ref1, resolver.getOneRequired("ref1"));
// 		assert.equal(ref2, resolver.getOneRequired("ref2"));
// 		assert.isNull(resolver.getOneOptional("ref3"));
//     });

//     test('Configure depedencies', () => {
// 		let ref1 = {};
// 		let ref2 = {};
// 		let refs = References.fromTuples(
// 			"Reference1", ref1,
// 			new Descriptor("pip-services-commons", "reference", "object", "ref2", "1.0"), ref2
// 		);
		
// 		let config = ConfigParams.fromTuples(
// 			"dependencies.ref1", "Reference1",
// 			"dependencies.ref2", "pip-services-commons:reference:*:*:*",
// 			"dependencies.ref3", null
// 		);
		
// 		let resolver = new DependencyResolver(config);
// 		resolver.setReferences(refs);
	
// 		assert.equal(ref1, resolver.getOneRequired("ref1"));
// 		assert.equal(ref2, resolver.getOneRequired("ref2"));
// 		assert.isNull(resolver.getOneOptional("ref3"));
//     });

// });