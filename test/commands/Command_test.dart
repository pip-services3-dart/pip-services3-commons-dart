// let assert = require('chai').assert;
// let async = require('async');

// import { CommandExec } from './CommandExec';
// import { Command } from '../../src/commands/Command';
// import { Parameters } from '../../src/run/Parameters';

// suite('Command', ()=> {

//     test('Get Name', (done) => {
//         var command = new Command("name", null, new CommandExec());

// 		// Check match by individual fields
//         assert.isNotNull(command);
//         assert.equal(command.getName(), 'name');

//         done();
//     });    

//     test('Execute', (done) => {
//         var command = new Command("name", null, new CommandExec());

//         var map: { [id: number] : any } = {};
//         map[8] = "title 8";
//         map[11] = "title 11";
//         var param = new Parameters(map);

//         command.execute("a", param, (err, result) => {
//             assert.equal(result, 0);

//             done();
//         });
//     });    

// });
