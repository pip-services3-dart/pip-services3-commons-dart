/** @module data */
import "./IChangeable.dart";

/**
 * Interface for data objects that can track their changes, including logical deletion.
 * 
 * @see [[IChangeable]]
 * 
 * ### Example ###
 * 
 *     class MyData implements IStringIdentifiable, ITrackable {
 *         public id: string;
 *         public field1: string;
 *         public field2: number;
 *         ...
 *         public change_time: Date;
 *         public create_time: Date;
 *         public deleted: boolean;
 *     }
 */
abstract class ITrackable implements IChangeable {
  /** The UTC time at which the object was created. */
  DateTime create_time;

  /** The UTC time at which the object was last changed (created, updated, or deleted). */
  DateTime change_time;

  /** The logical deletion flag. True when object is deleted and null or false otherwise */
  bool deleted;
}
