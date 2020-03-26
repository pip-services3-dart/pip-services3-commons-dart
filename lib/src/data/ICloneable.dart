/**
 * Interface for data objects that are able to create their full binary copy.
 * 
 * ### Example ###
 * 
 *     class MyClass implements IMyClass, ICloneable {
 *       MyClass() { };
 *     
 *       public clone() {
 *           var cloneObj = new (<any>this.constructor());
 *                  
 *           // Copy every attribute from this to cloneObj here.
 *           ...
 *                  
 *           return cloneObj;
 *       }
 *     }
 */
abstract class ICloneable {
  /** 
     * Creates a binary clone of this object.
     * 
     * @returns a clone of this object.
     */
  clone();
}
