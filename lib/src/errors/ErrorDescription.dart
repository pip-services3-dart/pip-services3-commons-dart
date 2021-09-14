import '../convert/StringConverter.dart';
import '../convert/IntegerConverter.dart';
import '../data/StringValueMap.dart';

/// Serializeable error description. It is use to pass information about errors
/// between microservices implemented in different languages. On the receiving side
/// [ErrorDescription] is used to recreate exception object close to its original type
/// without missing additional details.
///
/// See [ApplicationException]
/// See [ApplicationExceptionFactory]

class ErrorDescription {
  /// Data type of the original error
  String? type;

  /// Standard error category
  String? category;

  /// HTTP status code associated with this error type
  int? status;

  /// A unique error code
  String? code;

  /// A human-readable error description (usually written in English)
  String? message;

  /// A map with additional details that can be used to restore error description in other languages
  StringValueMap? details;

  /// A unique transaction id to trace execution throug call chain
  String? correlation_id;

  /// Original error wrapped by this exception
  String? cause;

  /// Stack trace of the exception
  String? stack_trace;

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    json['type'] = type;
    json['category'] = category;
    json['status'] = status;
    json['code'] = code;
    json['message'] = message;
    json['details'] = details != null ? details!.toJson() : null;
    json['correlation_id'] = correlation_id;
    json['cause'] = cause;
    json['stack_trace'] = stack_trace;
    return json;
  }

  void fromJson(Map<String, dynamic> json) {
    type = StringConverter.toNullableString(json['type']);
    category = StringConverter.toNullableString(json['category']);
    status = IntegerConverter.toNullableInteger(json['status']);
    code = StringConverter.toNullableString(json['code']);
    message = StringConverter.toNullableString(json['message']);
    details = StringValueMap.fromValue(json['details']);
    correlation_id = StringConverter.toNullableString(json['correlation_id']);
    cause = StringConverter.toNullableString(json['cause']);
    stack_trace = StringConverter.toNullableString(json['stack_trace']);
  }
}
