/**
 * Interface for data objects that have human-readable names.
 * 
 * ### Example ###
 * 
 *     class MyData implements IStringIdentifiable, INamed {
 *         id: string;
 *         name: string;
 *         field1: string;
 *         field2: number;
 *         ...
 *     }
 */
abstract class INamed {
	/** The object's humand-readable name. */
	get string name();
}
