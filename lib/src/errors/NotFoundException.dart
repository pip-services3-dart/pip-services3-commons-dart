import './ErrorCategory.dart';
import './ApplicationException.dart';

/**
 * Errors caused by attempts to access missing objects.
 */
class NotFoundException extends ApplicationException {
  /**
	 * Creates an error instance and assigns its values.
	 * 
     * @param correlation_id    (optional) a unique transaction id to trace execution through call chain.
     * @param code              (optional) a unique error code. Default: "UNKNOWN"
     * @param message           (optional) a human-readable description of the error.
	 * 
	 * @see [[ErrorCategory]]
	 */
  NotFoundException(
      [String correlation_id = null, String code = null, String message = null])
      : super(ErrorCategory.NotFound, correlation_id, code, message) {
    this.status = 404;
  }
}
