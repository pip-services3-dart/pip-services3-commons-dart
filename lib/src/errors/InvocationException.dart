import './ErrorCategory.dart';
import './ApplicationException.dart';


/// Errors returned by remote services or by the network during call attempts.
 
class InvocationException extends ApplicationException {
  
	/// Creates an error instance and assigns its values.
	/// 
    /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
    /// - [code]              (optional) a unique error code. Default: 'UNKNOWN'
    /// - [message]           (optional) a human-readable description of the error.
	/// 
	/// See [ErrorCategory]
	 
  InvocationException(
      [String correlation_id = null, String code = null, String message = null])
      : super(ErrorCategory.FailedInvocation, correlation_id, code, message) {
    this.status = 500;
  }
}
