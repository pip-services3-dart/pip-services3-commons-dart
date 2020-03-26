import "./IIdentifiable.dart";

/**
 * Interface for data objects that can be uniquely identifed by a string id. 
 * 
 * The interface extends [[IIdentifiable]] to hardcode id type to string.
 * 
 * It is a common pattern to use a string GUID as the id, generated by [[IdGenerator]].
 * 
 * @see [[IIdentifiable]]
 * @see [[IdGenerator]]
 * 
 * ### Example ###
 * 
 *     export class MyData implements IStringIdentifiable {
 *         public id: string;
 *         public field1: string;
 *         public field2: number; 
 *         ...
 *     }
 */
abstract class IStringIdentifiable implements IIdentifiable<String> {}
