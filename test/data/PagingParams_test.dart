// let assert = require('chai').assert;

// import { PagingParams } from '../../src/data/PagingParams';

// suite('PagingParams', ()=> {
    
//     test('Create empty PagingParams (regular)', () => {
//         let paging = new PagingParams();
//         assert.equal(null, paging.skip);
//         assert.equal(null, paging.take);
//         assert.equal(false, paging.total);
//     });
    
//     test('Create empty PagingParams (gRPC)', () => {
//         let paging = new PagingParams(0, 0, false);
//         assert.equal(0, paging.skip);
//         assert.equal(null, paging.take);
//         assert.equal(false, paging.total);
//     });

//     test('Create PagingParams with set skip/take values', () => {
//         let paging = new PagingParams(25, 50, false);
//         assert.equal(25, paging.skip);
//         assert.equal(50, paging.take);
//         assert.equal(false, paging.total);
//     });

//     test('getSkip & getTake', () => {
//         let paging = new PagingParams(25, 50, false);
//         assert.equal(50, paging.getSkip(50));
//         assert.equal(25, paging.getSkip(10));
//         assert.equal(50, paging.getTake(100));
//         assert.equal(25, paging.getTake(25));

//         paging = new PagingParams();
//         assert.equal(10, paging.getSkip(10));
//         assert.equal(10, paging.getTake(10));
//     });
// });