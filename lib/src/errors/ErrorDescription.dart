/**
 * Serializeable error description. It is use to pass information about errors
 * between microservices implemented in different languages. On the receiving side
 * [[ErrorDescription]] is used to recreate exception object close to its original type
 * without missing additional details.
 * 
 * @see [[ApplicationException]]
 * @see [[ApplicationExceptionFactory]]
 */
class ErrorDescription {
	/** Data type of the original error */
	String type;
	/** Standard error category */
	String category;
    /** HTTP status code associated with this error type */
	int status;
    /** A unique error code */
	String code;
    /** A human-readable error description (usually written in English) */
	String message;
    /** A map with additional details that can be used to restore error description in other languages */
	var details;
    /** A unique transaction id to trace execution throug call chain */   
	String correlation_id;
    /** Original error wrapped by this exception */ 
	String cause;
    /** Stack trace of the exception */ 
	String stack_trace;
}
