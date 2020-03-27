import '../convert/StringConverter.dart';
import '../convert/IntegerConverter.dart';
import '../data/StringValueMap.dart';

/**
 * Serializeable error description. It is use to pass information about errors
 * between microservices implemented in different languages. On the receiving side
 * [[ErrorDescription]] is used to recreate exception object close to its original type
 * without missing additional details.
 * 
 * See [[ApplicationException]]
 * See [[ApplicationExceptionFactory]]
 */
class ErrorDescription {
  /** Data type of the original error */
  String type;
  /** Standard error category */
  String category;
  /** HTTP status code associated with this error type */
  int status;
  /** A unique error code */
  String code;
  /** A human-readable error description (usually written in English) */
  String message;
  /** A map with additional details that can be used to restore error description in other languages */
  StringValueMap details;
  /** A unique transaction id to trace execution throug call chain */
  String correlation_id;
  /** Original error wrapped by this exception */
  String cause;
  /** Stack trace of the exception */
  String stack_trace;

  Map<String, dynamic> toJson() {
    var json = new Map<String, dynamic>();
    json["type"] = this.type;
    json["category"] = this.category;
    json["status"] = this.status;
    json["code"] = this.code;
    json["message"] = this.message;
    json["details"] = this.details != null ? this.details.toJson() : null;
    json["correlation_id"] = this.correlation_id;
    json["cause"] = this.cause;
    json["stack_trace"] = this.stack_trace;
    return json;
  }

  void fromJson(Map<String, dynamic> json) {
    this.type = StringConverter.toNullableString(json["type"]);
    this.category = StringConverter.toNullableString(json["category"]);
    this.status = IntegerConverter.toNullableInteger(json["status"]);
    this.code = StringConverter.toNullableString(json["code"]);
    this.message = StringConverter.toNullableString(json["message"]);
    this.details = StringValueMap.fromValue(json["details"]);
    this.correlation_id =
        StringConverter.toNullableString(json["correlation_id"]);
    this.cause = StringConverter.toNullableString(json["cause"]);
    this.stack_trace = StringConverter.toNullableString(json["stack_trace"]);
  }
}
