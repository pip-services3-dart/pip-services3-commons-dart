import './ErrorCategory.dart';
import './ApplicationException.dart';

/**
/// Errors raised by conflicts between object versions that were
/// posted by the user and those that are stored on the server.
 */
class ConflictException extends ApplicationException {
  /**
	/// Creates an error instance and assigns its values.
	/// 
    /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
    /// - [code]              (optional) a unique error code. Default: "UNKNOWN"
    /// - [message]           (optional) a human-readable description of the error.
	/// 
	/// See [ErrorCategory]
	 */
  ConflictException(
      [String correlation_id = null, String code = null, String message = null])
      : super(ErrorCategory.Conflict, correlation_id, code, message) {
    this.status = 409;
  }
}
