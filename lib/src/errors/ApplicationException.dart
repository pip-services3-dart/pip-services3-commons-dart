import '../data/StringValueMap.dart';
import './ErrorCategory.dart';

/// Defines a base class to defive various application exceptions.
///
/// Most languages have own definition of base exception (error) types.
/// However, this class is implemented symmetrically in all languages
/// supported by PipServices toolkit. It allows to create portable implementations
/// and support proper error propagation in microservices calls.
///
/// Error propagation means that when microservice implemented in one language
/// calls microservice(s) implemented in a different language(s), errors are returned
/// throught the entire call chain and restored in their original (or close) type.
///
/// Since number of potential exception types is endless, PipServices toolkit
/// supports only 12 standard categories of exceptions defined in [ErrorCategory].
/// This [ApplicationException] class acts as a basis for
/// all other 12 standard exception types.
///
/// Most exceptions have just free-form message that describes occured error.
/// That may not be sufficient to create meaninful error descriptions.
/// The [ApplicationException] class proposes an extended error definition
/// that has more standard fields:
///
/// - [message]: is a human-readable error description
/// - [category]: one of 12 standard error categories of errors
/// - [status]: numeric HTTP status code for REST invocations
/// - [code]: a unique error code, usually defined as 'MY_ERROR_CODE'
/// - [correlation_id]: a unique transaction id to trace execution through a call chain
/// - [details]: map with error parameters that can help to recreate meaningful error description in other languages
/// - [stack_trace]: a stack trace
/// - [cause]: original error that is wrapped by this exception
///
/// ApplicationException class is not serializable. To pass errors through the wire
/// it is converted into [ErrorDescription] object and restored on receiving end into
/// identical exception type.
///
/// See [ErrorCategory]
/// See [ErrorDescription]

class ApplicationException implements Exception {
  /// A human-readable error description (usually written in English)
  String message;

  /// Standard error category
  String category;

  /// HTTP status code associated with this error type
  int status = 500;

  /// A unique error code
  String code = 'UNKNOWN';

  /// A map with additional details that can be used to restore error description in other languages
  // Todo: Complete implementation!
  StringValueMap details;

  /// A unique transaction id to trace execution throug call chain
  String correlation_id;

  /// Stack trace of the exception
  String stack_trace;
  // Original error wrapped by this exception
  String cause;

  /// Creates a new instance of application exception and assigns its values.
  ///
  /// - [category]          (optional) a standard error category. Default: Unknown
  /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
  /// - [code]              (optional) a unique error code. Default: 'UNKNOWN'
  /// - [message]           (optional) a human-readable description of the error.

  ApplicationException(
      [String category, String correlation_id, String code, String message]) {
    this.category = category ?? ErrorCategory.Unknown;
    this.correlation_id = correlation_id;
    this.code = code ?? 'UNKNOWN';
    if (this.message == null) this.message = message ?? 'Unknown error';
    stack_trace = StackTrace.current.toString();
  }

  factory ApplicationException.fromJson(Map<String, dynamic> json) {
    var appEx = ApplicationException();
    appEx.fromJson(json);
    return appEx;
  }

  /// Gets original error wrapped by this exception as a string message.
  ///
  /// Returns an original error message.

  String getCauseString() {
    return cause != null ? cause.toString() : null;
  }

  /// Sets original error wrapped by this exception as a string message.
  ///
  /// - [value] an original error message.

  void setCauseString(String value) {
    cause = value;
  }

  /// Gets a stack trace where this exception occured.
  ///
  /// Returns a stack trace as a string.

  String getStackTraceString() {
    return stack_trace; // ?? super.stack;
  }

  /// Sets a stack trace where this exception occured.
  ///
  /// - [value] a stack trace as a string

  void setStackTraceString(String value) {
    stack_trace = value;
  }

  /// Sets a unique error code.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [code] a unique error code
  /// Returns this exception object

  ApplicationException withCode(String code) {
    this.code = code ?? 'UNKNOWN';
    return this;
  }

  /// Sets a original error wrapped by this exception
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [cause] original error object
  /// Returns this exception object

  ApplicationException withCause(cause) {
    if (cause != null) this.cause = cause.toString();
    return this;
  }

  /// Sets a HTTP status code which shall be returned by REST calls.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [status] an HTTP error code.
  /// Returns this exception object

  ApplicationException withStatus(int status) {
    this.status = status ?? 500;
    return this;
  }

  /// Sets a parameter for additional error details.
  /// This details can be used to restore error description in other languages.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [key] a details parameter name
  /// - [value] a details parameter name
  /// Returns this exception object

  ApplicationException withDetails(String key, value) {
    details = details ?? StringValueMap();
    details.setAsObject(key, value);
    return this;
  }

  /// Sets a correlation id which can be used to trace this error through a call chain.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [correlationId] a unique transaction id to trace error through call chain
  /// Returns this exception object

  ApplicationException withCorrelationId(String correlationId) {
    correlation_id = correlationId;
    return this;
  }

  /// Sets a stack trace for this error.
  ///
  /// This method returns reference to this exception to implement Builder pattern
  /// to chain additional calls.
  ///
  /// - [stackTrace] a stack trace where this error occured
  /// Returns this exception object

  ApplicationException withStackTrace(String stackTrace) {
    stack_trace = stackTrace;
    return this;
  }

  /// Wraps another exception into an application exception object.
  ///
  /// If original exception is of ApplicationException type it is returned without changes.
  /// Otherwise a new ApplicationException is created and original error is set as its cause.
  ///
  /// - [cause]     an original error object
  /// Returns an original or newly created ApplicationException

  ApplicationException wrap(cause) {
    cause = ApplicationException.unwrapError(cause);

    if (cause is ApplicationException) return cause;

    withCause(cause);
    return this;
  }

  @override
  String toString() {
    return message ?? code;
  }

  /// Wraps another exception into specified application exception object.
  ///
  /// If original exception is of ApplicationException type it is returned without changes.
  /// Otherwise the original error is set as a cause to specified ApplicationException object.
  ///
  /// - [error]         an ApplicationException object to wrap the cause
  /// - [cause]         an original error object
  /// Returns an original or newly created ApplicationException
  ///
  /// See [wrap]

  static ApplicationException wrapError(ApplicationException error, cause) {
    cause = ApplicationException.unwrapError(cause);

    if (cause is ApplicationException) return cause;

    error.withCause(cause);
    return error;
  }

  /// Unwraps original exception through wrapped exception objects.
  ///
  /// Many frameworks like Seneca or restify wrap original exception.
  /// That may result in propagating less specific errors and can hide
  /// causes of the errors.

  /// - [error]     an error object
  /// Returns         an original error object

  static dynamic unwrapError(error) {
    if (error == null) return null;

    // // Unwrapping restify exceptions
    // if (error.body && !_.isEmpty(error.body))
    //     error = error.body;

    return error;
  }

  void fromJson(Map<String, dynamic> json) {
    message = json['message'];
    category = json['category'];
    status = json['status'] ?? 500;

    /// A unique error code
    code = json['code'] ?? 'UNKNOWN';
    details = details ?? StringValueMap();
    details.fromJson(json['details']);
    correlation_id = json['correlation_id'];
    stack_trace = json['stack_trace'];
    cause = json['cause'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'category': category,
      'status': status,
      'code': code,
      'details': details != null ? details.toJson() : null,
      'correlation_id': correlation_id,
      'stack_trace': stack_trace,
      'cause': cause
    };
  }
}
