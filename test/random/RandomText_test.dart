// let assert = require('chai').assert;

// import { RandomText } from '../../src/random/RandomText';

// suite('RandomText', ()=> {

//     test('Phrase', () => {
//     	assert.isTrue(RandomText.phrase(-1) == "");
//     	assert.isTrue(RandomText.phrase(-1, -2) == "");
//     	assert.isTrue(RandomText.phrase(-1, 0) == "");
//     	assert.isTrue(RandomText.phrase(-2, -1) == "");

//     	let text = RandomText.phrase(4);
//     	assert.isTrue(text.length >= 4 && text.length <= 10 );
//     	text = RandomText.phrase(4, 10);
//     	assert.isTrue(text.length >= 4);
//    });

//     test('FullName', () => {
//     	let text = RandomText.fullName();
//     	assert.isTrue(text.indexOf(" ") != -1);
//    });

//     test('Phone', () => {
//     	let text = RandomText.phone();
//     	assert.isTrue(text.indexOf("(") != -1);
//     	assert.isTrue(text.indexOf(")") != -1);
//     	assert.isTrue(text.indexOf("-") != -1);
//    });

//     test('Email', () => {
//     	let text = RandomText.email();
//     	assert.isTrue(text.indexOf("@") != -1);
//     	assert.isTrue(text.indexOf(".com") != -1);
//    });

// });
