// /** @module errors */

// /**
//  * Serializeable error description. It is use to pass information about errors
//  * between microservices implemented in different languages. On the receiving side
//  * [[ErrorDescription]] is used to recreate exception object close to its original type
//  * without missing additional details.
//  * 
//  * @see [[ApplicationException]]
//  * @see [[ApplicationExceptionFactory]]
//  */
// export class ErrorDescription {
// 	/** Data type of the original error */
// 	public type: string;
// 	/** Standard error category */
// 	public category: string;
//     /** HTTP status code associated with this error type */
// 	public status: number;
//     /** A unique error code */
// 	public code: string;
//     /** A human-readable error description (usually written in English) */
// 	public message: string;
//     /** A map with additional details that can be used to restore error description in other languages */
// 	public details: any;
//     /** A unique transaction id to trace execution throug call chain */   
// 	public correlation_id: string;
//     /** Original error wrapped by this exception */ 
// 	public cause: string;
//     /** Stack trace of the exception */ 
// 	public stack_trace: string;
// }
