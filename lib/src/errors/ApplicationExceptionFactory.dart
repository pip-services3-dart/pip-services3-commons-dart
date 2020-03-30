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

/**
 * Factory to recreate exceptions from [ErrorDescription] values passed through the wire.
 * 
 * See [ErrorDescription]
 * See [ApplicationException]
 */
class ApplicationExceptionFactory {
  /**
	 * Recreates ApplicationException object from serialized ErrorDescription.
	 * 
	 * It tries to restore original exception type using type or error category fields.
	 * 
	 * - [description]	a serialized error description received as a result of remote call
	 */
  static ApplicationException create(ErrorDescription description) {
    if (description == null) throw new Exception("Description cannot be null");

    ApplicationException error = null;
    var category = description.category;
    var code = description.code;
    var message = description.message;
    var correlationId = description.correlation_id;

    // Create well-known exception type based on error category
    if (ErrorCategory.Unknown == category)
      error = new UnknownException(correlationId, code, message);
    else if (ErrorCategory.Internal == category)
      error = new InternalException(correlationId, code, message);
    else if (ErrorCategory.Misconfiguration == category)
      error = new ConfigException(correlationId, code, message);
    else if (ErrorCategory.NoResponse == category)
      error = new ConnectionException(correlationId, code, message);
    else if (ErrorCategory.FailedInvocation == category)
      error = new InvocationException(correlationId, code, message);
    else if (ErrorCategory.FileError == category)
      error = new FileException(correlationId, code, message);
    else if (ErrorCategory.BadRequest == category)
      error = new BadRequestException(correlationId, code, message);
    else if (ErrorCategory.Unauthorized == category)
      error = new UnauthorizedException(correlationId, code, message);
    else if (ErrorCategory.Conflict == category)
      error = new ConflictException(correlationId, code, message);
    else if (ErrorCategory.NotFound == category)
      error = new NotFoundException(correlationId, code, message);
    else if (ErrorCategory.InvalidState == category)
      error = new InvalidStateException(correlationId, code, message);
    else if (ErrorCategory.Unsupported == category)
      error = new UnsupportedException(correlationId, code, message);
    else {
      error = new UnknownException();
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
