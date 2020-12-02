import '../convert/TypeCode.dart';
import './ObjectSchema.dart';

/// Schema to validate [PagingParams].
///
/// See [PagingParams]

class PagingParamsSchema extends ObjectSchema {
  /// Creates a new instance of validation schema.

  PagingParamsSchema() : super() {
    withOptionalProperty('skip', TypeCode.Long);
    withOptionalProperty('take', TypeCode.Long);
    withOptionalProperty('total', TypeCode.Boolean);
  }
}
