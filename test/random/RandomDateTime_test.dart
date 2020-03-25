// let assert = require('chai').assert;

// import { RandomDateTime } from '../../src/random/RandomDateTime';

// suite('RandomDateTime', ()=> {

//     test('Next Date', () => {
// 		let date = RandomDateTime.nextDate(new Date(2015, 1, 1), new Date(2016, 1, 1));
//     	assert.isTrue(date.getFullYear() == 2015 || date.getFullYear() == 2016 );  

// 		date = RandomDateTime.nextDate(new Date());
//         assert.isTrue(date.getFullYear() >= new Date().getFullYear() - 10 
//             && date.getFullYear() <= new Date().getFullYear());
//    });

//     test('Update Date Time', () => {
//     	let oldDate = new Date(2016, 10, 10, 0, 0, 0, 0);
    	
//     	let date = RandomDateTime.updateDateTime(oldDate);
//         assert.isTrue(date.getTime() >= oldDate.getTime() - 10 * 24 * 3600000
// 			|| date.getTime() >= oldDate.getTime() + 10 * 24 * 3600000);  
    	
//     	date = RandomDateTime.updateDateTime(oldDate, 3 * 24 * 3600000);
//         assert.isTrue(date.getTime() >= oldDate.getTime() - 3 * 24 * 3600000
// 			|| date.getTime() >= oldDate.getTime() + 3 * 24 * 3600000);  
    	
//     	date = RandomDateTime.updateDateTime(oldDate, -3);
//     	assert.isTrue(date.getTime() == oldDate.getTime()); 
//    });

// });
