import './ErrorCategory.dart';
import './ApplicationException.dart';

/// Access errors caused by missing user identity (authentication error) or incorrect security permissions (authorization error).

class UnauthorizedException extends ApplicationException {
  /// Creates an error instance and assigns its values.
  ///
  /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
  /// - [code]              (optional) a unique error code. Default: 'UNKNOWN'
  /// - [message]           (optional) a human-readable description of the error.
  ///
  /// See [ErrorCategory]

  UnauthorizedException([String correlation_id, String code, String message])
      : super(ErrorCategory.Unauthorized, correlation_id, code, message) {
    status = 401;
  }
}
