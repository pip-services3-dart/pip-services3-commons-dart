import "./ErrorCategory.dart";
import "./ApplicationException.dart";

/**
 * Errors that occur during connections to remote services.
 * They can be related to misconfiguration, network issues, or the remote service itself.
 */
class ConnectionException extends ApplicationException {

	/**
	 * Creates an error instance and assigns its values.
	 * 
     * @param correlation_id    (optional) a unique transaction id to trace execution through call chain.
     * @param code              (optional) a unique error code. Default: "UNKNOWN"
     * @param message           (optional) a human-readable description of the error.
	 * 
	 * @see [[ErrorCategory]]
	 */
	ConnectionException([String correlation_id = null, String code = null, String message = null])
		: super(ErrorCategory.NoResponse, correlation_id, code, message) {
		this.status = 500;
	}
}
