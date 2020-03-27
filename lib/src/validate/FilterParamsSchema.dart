import '../convert/TypeCode.dart';
import './MapSchema.dart';

/**
 * Schema to validate [[FilterParams]].
 * 
 * See [[FilterParams]]
 */
class FilterParamsSchema extends MapSchema {
  /**
     * Creates a new instance of validation schema.
     */
  FilterParamsSchema() : super(TypeCode.String, null) {}
}
