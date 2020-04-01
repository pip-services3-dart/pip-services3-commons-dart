import './ErrorCategory.dart';
import './ErrorDescription.dart';
import './ApplicationException.dart';

/// Factory to create serializeable [ErrorDescription] from [ApplicationException]
/// or from arbitrary errors.
///
/// The ErrorDescriptions are used to pass errors through the wire between microservices
/// implemented in different languages. They allow to restore exceptions on the receiving side
/// close to the original type and preserve additional information.
///
/// See [ErrorDescription]
/// See [ApplicationException]

class ErrorDescriptionFactory {
  /// Creates a serializable ErrorDescription from error object.
  ///
  /// - [error]  	an error object
  /// Returns a serializeable ErrorDescription object that describes the error.

  static ErrorDescription create(error) {
    var description = ErrorDescription();

    if (error is ApplicationException) {
      var ex = error;
      description.category = ex.category;
      description.status = ex.status;
      description.code = ex.code;
      description.message = ex.message;
      description.details = ex.details;
      description.correlation_id = ex.correlation_id;
      description.cause = ex.getCauseString();
      description.stack_trace = ex.getStackTraceString();
    } else {
      description.type = error != null ? error.runtimeType.toString() : null;
      description.category = ErrorCategory.Unknown;
      description.status = 500;
      description.code = 'UNKNOWN';
      description.message = error != null ? error.toString() : null;
      if (error is Error) description.stack_trace = error.stackTrace.toString();
    }

    return description;
  }
}
