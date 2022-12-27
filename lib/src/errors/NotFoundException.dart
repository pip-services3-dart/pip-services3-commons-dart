import './ErrorCategory.dart';
import './ApplicationException.dart';

/// Errors caused by attempts to access missing objects.

class NotFoundException extends ApplicationException {
  /// Creates an error instance and assigns its values.
  ///
  /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
  /// - [code]              (optional) a unique error code. Default: 'UNKNOWN'
  /// - [message]           (optional) a human-readable description of the error.
  ///
  /// See [ErrorCategory]

  NotFoundException([String? correlation_id, String? code, String? message])
      : super(ErrorCategory.NotFound, correlation_id, code, message) {
    status = 404;
  }
}
