import './ErrorCategory.dart';
import './ErrorDescription.dart';
import './ApplicationException.dart';
import './UnknownException.dart';
import './InternalException.dart';
import './ConfigException.dart';
import './ConnectionException.dart';
import './InvocationException.dart';
import './FileException.dart';
import './BadRequestException.dart';
import './UnauthorizedException.dart';
import './ConflictException.dart';
import './NotFoundException.dart';
import './UnsupportedException.dart';
import './InvalidStateException.dart';
import '../data/StringValueMap.dart';

/// Factory to recreate exceptions from [ErrorDescription] values passed through the wire.
///
/// See [ErrorDescription]
/// See [ApplicationException]

class ApplicationExceptionFactory {
  /// Recreates ApplicationException object from serialized ErrorDescription.
  ///
  /// It tries to restore original exception type using type or error category fields.
  ///
  /// - [description]	a serialized error description received as a result of remote call

  static ApplicationException create(ErrorDescription description) {
    if (description == null) throw Exception('Description cannot be null');

    ApplicationException error = null;
    var category = description.category;
    var code = description.code;
    var message = description.message;
    var correlationId = description.correlation_id;

    // Create well-known exception type based on error category
    if (ErrorCategory.Unknown == category)
      error = UnknownException(correlationId, code, message);
    else if (ErrorCategory.Internal == category)
      error = InternalException(correlationId, code, message);
    else if (ErrorCategory.Misconfiguration == category)
      error = ConfigException(correlationId, code, message);
    else if (ErrorCategory.NoResponse == category)
      error = ConnectionException(correlationId, code, message);
    else if (ErrorCategory.FailedInvocation == category)
      error = InvocationException(correlationId, code, message);
    else if (ErrorCategory.FileError == category)
      error = FileException(correlationId, code, message);
    else if (ErrorCategory.BadRequest == category)
      error = BadRequestException(correlationId, code, message);
    else if (ErrorCategory.Unauthorized == category)
      error = UnauthorizedException(correlationId, code, message);
    else if (ErrorCategory.Conflict == category)
      error = ConflictException(correlationId, code, message);
    else if (ErrorCategory.NotFound == category)
      error = NotFoundException(correlationId, code, message);
    else if (ErrorCategory.InvalidState == category)
      error = InvalidStateException(correlationId, code, message);
    else if (ErrorCategory.Unsupported == category)
      error = UnsupportedException(correlationId, code, message);
    else {
      error = UnknownException();
      error.category = category;
      error.status = description.status;
    }

    // Fill error with details
    error.details = StringValueMap.fromValue(description.details);
    error.setCauseString(description.cause);
    error.setStackTraceString(description.stack_trace);

    return error;
  }
}
