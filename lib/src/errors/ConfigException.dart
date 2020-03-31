import './ErrorCategory.dart';
import './ApplicationException.dart';

/**
 * Errors related to mistakes in the microservice's user-defined configurations.
 */
class ConfigException extends ApplicationException {
  /**
	 * Creates an error instance and assigns its values.
	 * 
     * - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
     * - [code]              (optional) a unique error code. Default: "UNKNOWN"
     * - [message]           (optional) a human-readable description of the error.
	 * 
	 * See [ErrorCategory]
	 */
  ConfigException(
      [String correlation_id = null, String code = null, String message = null])
      : super(ErrorCategory.Misconfiguration, correlation_id, code, message) {
    this.status = 500;
  }
}
