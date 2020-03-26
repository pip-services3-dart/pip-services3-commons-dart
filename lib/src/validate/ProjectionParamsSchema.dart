/** @module validate */
import  '../convert/TypeCode.dart';
import './ArraySchema.dart';

/**
 * Schema to validate [[ProjectionParams]]
 * 
 * @see [[ProjectionParams]]
 */
class ProjectionParamsSchema extends ArraySchema {

    /**
     * Creates a new instance of validation schema.
     */
    ProjectionParamsSchema() :  super(TypeCode.String){
    }

}
