// let assert = require('chai').assert;

// import { RandomString } from '../../src/random/RandomString';

// suite('RandomString', ()=> {
//     let symbols = "_,.:-/.[].{},#-!,$=%.+^.&*-() ";
//     let chars ="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
//     let digits = "01234956789";

//     test('Pick', () => {
//     	 assert.isTrue(RandomString.pickChar("") == '');
//     	 let charVariable = RandomString.pickChar(chars);
//     	 assert.isTrue(chars.indexOf(charVariable) != -1);

//          let valuesEmpty: string[] = [];
//     	 assert.isTrue(RandomString.pick(valuesEmpty) == "");

//          let values = [ "ab", "cd" ];
//     	 let result = RandomString.pick(values);
//     	 assert.isTrue(result == "ab" || result == "cd");
//    });

//     test('Distort', () => {
//     	let value = RandomString.distort("abc");
//    	 	assert.isTrue(value.length == 3 || value.length == 4);
//    	 	assert.isTrue(value.substring(0,3) == "Abc"
//  			|| value.substring(0,3) == "abc"
// 		);

// 	   	if (value.length == 4)
// 	   		assert.isTrue(symbols.indexOf(value.substring(3)) != -1);
//    });

//     test('Next Alpha Char', () => {
//     	assert.isTrue(chars.indexOf(RandomString.nextAlphaChar()) != -1);
//    });

//     test('Next String', () => {
//     	let value = RandomString.nextString(3,5);
//     	assert.isTrue(value.length <= 5 && value.length >= 3);

//     	for (let i = 0; i < value.length; i++) {
//     		assert.isTrue(chars.indexOf(value.charAt(i)) != -1
// 				|| symbols.indexOf(value.charAt(i)) != -1
// 				|| digits.indexOf(value.charAt(i)) != -1
// 			);
//     	}
//    });

// });
