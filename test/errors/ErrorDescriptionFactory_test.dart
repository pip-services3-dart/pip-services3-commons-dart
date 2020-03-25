// let assert = require('chai').assert;

// import { ErrorCategory } from '../../src/errors/ErrorCategory';
// import { ErrorDescription } from '../../src/errors/ErrorDescription';
// import { ErrorDescriptionFactory } from '../../src/errors/ErrorDescriptionFactory';
// import { ApplicationException } from '../../src/errors/ApplicationException';

// suite('ErrorDescriptionFactory', ()=> {

//     test('Create From ApplicationException', () => {
//         var key = "key";
//         var details = "details";

//         var ex = new ApplicationException("category", "correlationId", "code", "message");
//         ex.status  = 777;
//         ex.cause = "cause";
//         ex.stack_trace = "stackTrace";
//         ex.withDetails(key, details);

//         var descr = ErrorDescriptionFactory.create(ex);

//         assert.isNotNull(descr);
//         assert.equal(ex.category, descr.category);
//         assert.equal(ex.correlation_id, descr.correlation_id);
//         assert.equal(ex.code, descr.code);
//         assert.equal(ex.message, descr.message);
//         assert.equal(ex.status, descr.status);
//         assert.equal(ex.cause, descr.cause);
//         assert.equal(ex.stack_trace, descr.stack_trace);
//         assert.equal(ex.details, descr.details);
//     });

//     test('Create From Error', () => {
//         var ex = new Error("message");

//         var descr = ErrorDescriptionFactory.create(ex);

//         assert.isNotNull(descr);
//         assert.equal(ErrorCategory.Unknown, descr.category);
//         assert.equal("UNKNOWN", descr.code);
//         assert.equal(ex.message, descr.message);
//         assert.equal(500, descr.status);
//         assert.equal(ex.stack, descr.stack_trace);
//     });

// });