import '../convert/TypeCode.dart';
import './ObjectSchema.dart';

/**
/// Schema to validate [[PagingParams]].
/// 
/// See [PagingParams]
 */
class PagingParamsSchema extends ObjectSchema {
  /**
    /// Creates a new instance of validation schema.
     */
  PagingParamsSchema() : super() {
    this.withOptionalProperty("skip", TypeCode.Long);
    this.withOptionalProperty("take", TypeCode.Long);
    this.withOptionalProperty("total", TypeCode.Boolean);
  }
}
