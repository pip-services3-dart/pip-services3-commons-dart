// /** @module errors */

// /**
//  * Defines standard error categories to application exceptions
//  * supported by PipServices toolkit.
//  */
// export class ErrorCategory {
	
// 	/**
// 	 * Unknown or unexpected errors.
// 	 */
// 	public static readonly Unknown: string = "Unknown";

// 	/**
// 	 * Internal errors caused by programming mistakes.
// 	 */
// 	public static readonly Internal: string = "Internal";

// 	/**
// 	 * Errors related to mistakes in user-defined configurations.
// 	 */
// 	public static readonly Misconfiguration: string = "Misconfiguration";
	
// 	/**
// 	 * Errors caused by incorrect object state.. 
// 	 * 
// 	 * For example: business calls when the component is not ready.
// 	 */
// 	public static readonly InvalidState: string = "InvalidState";
	
// 	/**
// 	 * Errors caused by remote calls timeouted and not returning results.
// 	 * It allows to clearly separate communication related problems
// 	 * from other application errors.
// 	 */
// 	public static readonly NoResponse: string = "NoResponse";

//     /**
//      * Errors caused by remote calls failed due to unidenfied reasons.
//      */
// 	public static readonly FailedInvocation: string = "FailedInvocation";

// 	/**
// 	 * Errors in read/write local disk operations.
// 	 */
// 	public static readonly FileError: string = "FileError";

// 	/**
// 	 * Errors due to incorrectly specified invocation parameters.
// 	 * 
// 	 * For example: missing or incorrect parameters.
// 	 */
// 	public static readonly BadRequest: string = "BadRequest";
	
// 	/**
// 	 * Access errors caused by missing user identity (authentication error)
// 	 * or incorrect security permissions (authorization error).
// 	 */
// 	public static readonly Unauthorized: string = "Unauthorized";

//     /**
//      * Errors caused by attempts to access missing objects.
//      */
// 	public static readonly NotFound: string = "NotFound";
	
// 	/**
// 	 * Errors raised by conflicts between object versions that were
// 	 * posted by the user and those that are stored on the server.
// 	 */
// 	public static readonly Conflict: string = "Conflict";	
	
// 	/**
// 	 * Errors caused by calls to unsupported or not yet implemented functionality.
// 	 */
// 	public static readonly Unsupported: string = "Unsupported";
// }
