import './ErrorCategory.dart';
import './ApplicationException.dart';


/// Errors that occur during connections to remote services.
/// They can be related to misconfiguration, network issues, or the remote service itself.
 
class ConnectionException extends ApplicationException {
  
	/// Creates an error instance and assigns its values.
	/// 
    /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
    /// - [code]              (optional) a unique error code. Default: 'UNKNOWN'
    /// - [message]           (optional) a human-readable description of the error.
	/// 
	/// See [ErrorCategory]
	 
  ConnectionException(
      [String correlation_id = null, String code = null, String message = null])
      : super(ErrorCategory.NoResponse, correlation_id, code, message) {
    this.status = 500;
  }
}
