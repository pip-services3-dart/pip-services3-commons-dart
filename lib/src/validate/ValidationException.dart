import './ValidationResult.dart';
import './ValidationResultType.dart';
import '../errors/BadRequestException.dart';


/// Errors in schema validation.
/// 
/// Validation errors are usually generated based in [ValidationResult].
/// If using strict mode, warnings will also raise validation exceptions.
/// 
/// See [BadRequestException]
/// See [ValidationResult]
 
class ValidationException extends BadRequestException {
  static final int SerialVersionUid = -1459801864235223845;

  
    /// Creates a new instance of validation exception and assigns its values.
    /// 
    /// - [category]          (optional) a standard error category. Default: Unknown
    /// - [correlation_id]    (optional) a unique transaction id to trace execution through call chain.
    /// - [results]           (optional) a list of validation results
    /// - [message]           (optional) a human-readable description of the error.
    /// 
    /// See [ValidationResult]
     
  ValidationException(String correlationId,
      [String message, List<ValidationResult> results])
      : super(
            correlationId,
            "INVALID_DATA",
            message != null
                ? message
                : ValidationException.composeMessage(results)) {
    if (results != null) this.withDetails("results", results);
  }

  
    /// Composes human readable error message based on validation results.
    /// 
    /// - [results]   a list of validation results.
    /// Returns a composed error message.
    /// 
    /// See [ValidationResult]
     
  static String composeMessage(List<ValidationResult> results) {
    var builder = "Validation failed";

    if (results != null && results.length > 0) {
      var first = true;
      for (var i = 0; i < results.length; i++) {
        var result = results[i];

        if (result.getType() == ValidationResultType.Information) continue;

        builder += first ? ": " : ", ";
        builder += result.getMessage();
        first = false;
      }
    }

    return builder;
  }

  
    /// Creates a new ValidationException based on errors in validation results.
    /// If validation results have no errors, than null is returned.
    /// 
    /// - [correlationId]     (optional) transaction id to trace execution through call chain.
    /// - [results]           list of validation results that may contain errors
    /// - [strict]            true to treat warnings as errors.
    /// Returns a newly created ValidationException or null if no errors in found.
    /// 
    /// See [ValidationResult]
     
  static ValidationException fromResults(
      String correlationId, List<ValidationResult> results, bool strict) {
    var hasErrors = false;

    for (var i = 0; i < results.length; i++) {
      var result = results[i];

      if (result.getType() == ValidationResultType.Error) hasErrors = true;

      if (strict && result.getType() == ValidationResultType.Warning)
        hasErrors = true;
    }

    return hasErrors
        ? new ValidationException(correlationId, null, results)
        : null;
  }

  
    /// Throws ValidationException based on errors in validation results.
    /// If validation results have no errors, than no exception is thrown.
    /// 
    /// - [correlationId]     (optional) transaction id to trace execution through call chain.
    /// - [results]           list of validation results that may contain errors
    /// - [strict]            true to treat warnings as errors.
    /// 
    /// See [ValidationResult]
    /// See [ValidationException]
     
  static void throwExceptionIfNeeded(
      String correlationId, List<ValidationResult> results, bool strict) {
    var ex = ValidationException.fromResults(correlationId, results, strict);
    if (ex != null) throw ex;
  }
}
