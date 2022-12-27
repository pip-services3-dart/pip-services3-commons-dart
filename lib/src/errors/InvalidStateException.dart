import './ErrorCategory.dart';
import './ApplicationException.dart';

/// Errors related to calling operations, which require the component to be in a specific state.
///
/// For instance: business calls when the component is not ready.

class InvalidStateException extends ApplicationException {
  /// Creates an error instance and assigns its values.
  ///
  /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
  /// - [code]              (optional) a unique error code. Default: 'UNKNOWN'
  /// - [message]           (optional) a human-readable description of the error.
  ///
  /// See [ErrorCategory]

  InvalidStateException([String? correlation_id, String? code, String? message])
      : super(ErrorCategory.InvalidState, correlation_id, code, message) {
    status = 500;
  }
}
