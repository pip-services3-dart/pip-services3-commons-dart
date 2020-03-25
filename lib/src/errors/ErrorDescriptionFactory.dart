// /** @module errors */
// import { ErrorCategory } from './ErrorCategory';
// import { ErrorDescription } from './ErrorDescription';
// import { ApplicationException } from './ApplicationException';

// /**
//  * Factory to create serializeable [[ErrorDescription]] from [[ApplicationException]]
//  * or from arbitrary errors.
//  * 
//  * The ErrorDescriptions are used to pass errors through the wire between microservices
//  * implemented in different languages. They allow to restore exceptions on the receiving side
//  * close to the original type and preserve additional information.
//  * 
//  * @see [[ErrorDescription]]
//  * @see [[ApplicationException]]
//  */
// export class ErrorDescriptionFactory {

// 	/**
//      * Creates a serializable ErrorDescription from error object.
//      * 
// 	 * @param error  	an error object
// 	 * @returns a serializeable ErrorDescription object that describes the error.
// 	 */
// 	public static create(error: any): ErrorDescription {        
//         let description = new ErrorDescription();

//         if (error instanceof ApplicationException) {
//             let ex = <ApplicationException>error;
//             description.category = ex.category;
//             description.status = ex.status;
//             description.code  = ex.code;
//             description.message = ex.message;
//             description.details = ex.details;
//             description.correlation_id = ex.correlation_id;
//             description.cause = ex.getCauseString();
//             description.stack_trace = ex.getStackTraceString();
//         } else {
//             error = error || {};
//             description.type = error.name;
//             description.category = ErrorCategory.Unknown;
//             description.status = 500;
//             description.code = "UNKNOWN";
//             description.message = error.message || error.toString();
//             description.stack_trace = error.stack;
//         }

//         return description;
//     }

// }
