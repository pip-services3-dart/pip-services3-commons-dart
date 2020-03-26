import "./ErrorCategory.dart";
import "./ApplicationException.dart";

/**
 * Access errors caused by missing user identity (authentication error) or incorrect security permissions (authorization error).
 */
class UnauthorizedException extends ApplicationException {
  /**
	 * Creates an error instance and assigns its values.
	 * 
     * @param correlation_id    (optional) a unique transaction id to trace execution through call chain.
     * @param code              (optional) a unique error code. Default: "UNKNOWN"
     * @param message           (optional) a human-readable description of the error.
	 * 
	 * @see [[ErrorCategory]]
	 */
  UnauthorizedException(
      [String correlation_id = null, String code = null, String message = null])
      : super(ErrorCategory.Unauthorized, correlation_id, code, message) {
    this.status = 401;
  }
}
