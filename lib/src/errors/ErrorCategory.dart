/**
 * Defines standard error categories to application exceptions
 * supported by PipServices toolkit.
 */
class ErrorCategory {
	
	/**
	 * Unknown or unexpected errors.
	 */
	static final String Unknown = "Unknown";

	/**
	 * Internal errors caused by programming mistakes.
	 */
	static final String Internal = "Internal";

	/**
	 * Errors related to mistakes in user-defined configurations.
	 */
	static final String Misconfiguration = "Misconfiguration";
	
	/**
	 * Errors caused by incorrect object state.. 
	 * 
	 * For example: business calls when the component is not ready.
	 */
	static final String InvalidState = "InvalidState";
	
	/**
	 * Errors caused by remote calls timeouted and not returning results.
	 * It allows to clearly separate communication related problems
	 * from other application errors.
	 */
	static final String NoResponse = "NoResponse";

    /**
     * Errors caused by remote calls failed due to unidenfied reasons.
     */
	static final String FailedInvocation = "FailedInvocation";

	/**
	 * Errors in read/write local disk operations.
	 */
	static final String FileError = "FileError";

	/**
	 * Errors due to incorrectly specified invocation parameters.
	 * 
	 * For example: missing or incorrect parameters.
	 */
	static final String BadRequest = "BadRequest";
	
	/**
	 * Access errors caused by missing user identity (authentication error)
	 * or incorrect security permissions (authorization error).
	 */
	static final String Unauthorized = "Unauthorized";

    /**
     * Errors caused by attempts to access missing objects.
     */
	static final String NotFound = "NotFound";
	
	/**
	 * Errors raised by conflicts between object versions that were
	 * posted by the user and those that are stored on the server.
	 */
	static final String Conflict = "Conflict";	
	
	/**
	 * Errors caused by calls to unsupported or not yet implemented functionality.
	 */
	static final String Unsupported = "Unsupported";
}
