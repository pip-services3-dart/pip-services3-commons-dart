import './ErrorCategory.dart';
import './ApplicationException.dart';

/// Unknown or unexpected errors.

class UnknownException extends ApplicationException {
  /// Creates an error instance and assigns its values.
  ///
  /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
  /// - [code]              (optional) a unique error code. Default: 'UNKNOWN'
  /// - [message]           (optional) a human-readable description of the error.
  ///
  /// See [ErrorCategory]

  UnknownException([String correlation_id, String code, String message])
      : super(ErrorCategory.Unknown, correlation_id, code, message) {
    status = 500;
  }
}
