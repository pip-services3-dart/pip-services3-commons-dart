/**
 * Interface for a map that holds component references and passes them to components
 * to establish dependencies with each other.
 * 
 * Together with [IReferenceable] and [IUnreferenceable] interfaces it implements
 * a Locator pattern that is used by PipServices toolkit for Inversion of Control
 * to assign external dependencies to components. 
 * 
 * The IReferences object is a simple map, where keys are locators
 * and values are component references. It allows to add, remove and find components
 * by their locators. Locators can be any values like integers, strings or component types.
 * But most often PipServices toolkit uses [Descriptor] as locators that match
 * by 5 fields: group, type, kind, name and version.
 * 
 * See [Descriptor]
 * See [References]
 * 
 * ### Example ###
 * 
 *     class MyController implements IReferenceable {
 *         IMyPersistence persistence;
 *         ...    
 *         void setReferences(IReferences references) {
 *             this.persistence = references.getOneRequired<IMyPersistence>(
 *                 new Descriptor("mygroup", "persistence", "*", "*", "1.0")
 *             );
 *         }
 *         ...
 *     }
 *     
 *     var persistence = new MyMongoDbPersistence();
 *     
 *     var controller = new MyController();
 *     
 *     var references = References.fromTuples([
 *         new Descriptor("mygroup", "persistence", "mongodb", "default", "1.0"), persistence,
 *         new Descriptor("mygroup", "controller", "default", "default", "1.0"), controller
 *     ]);
 *     controller.setReferences(references);
 * 	
 */
abstract class IReferences {
  /**
	 * Puts a new reference into this reference map.
	 * 
	 * - [locator] 	a locator to find the reference by.
	 * - component a component reference to be added.
	 */
  put(locator, component);

  /**
	 * Removes a previously added reference that matches specified locator.
	 * If many references match the locator, it removes only the first one.
	 * When all references shall be removed, use [removeAll] method instead.
	 * 
	 * - [locator] 	a locator to remove reference
	 * Returns the removed component reference.
	 * 
	 * See [removeAll]
	 */
  remove(locator);

  /**
	 * Removes all component references that match the specified locator. 
	 * 
	 * - [locator] 	the locator to remove references by.
	 * Returns a list, containing all removed references.
	 */
  List removeAll(locator);

  /**
	 * Gets locators for all registered component references in this reference map.
	 * 
	 * Returns a list with component locators.
	 */
  List getAllLocators();

  /**
	 * Gets all component references registered in this reference map.
	 * 	
	 * Returns a list with component references.
	 */
  List getAll();

  /**
	 * Gets all component references that match specified locator.
	 * 
	 * - [locator] 	the locator to find references by.	 
	 * Returns a list with matching component references or empty list if nothing was found.
	 */
  List<T> getOptional<T>(locator);

  /**
	 * Gets all component references that match specified locator.
	 * At least one component reference must be present.
	 * If it doesn't the method throws an error.
	 * 
	 * - [locator] 	the locator to find references by.	 
	 * Returns a list with matching component references.
	 * 
	 * Throws a [ReferenceException] when no references found.
	 */
  List<T> getRequired<T>(locator);

  /**
	 * Gets an optional component reference that matches specified locator.
	 * 
	 * - [locator] 	the locator to find references by.	 
	 * Returns a matching component reference or null if nothing was found.
	 */
  T getOneOptional<T>(locator);

  /**
	 * Gets a required component reference that matches specified locator.
	 * 
	 * - [locator] 	the locator to find a reference by.	 
	 * Returns a matching component reference.
	 * Throws a [ReferenceException] when no references found.
	 */
  T getOneRequired<T>(locator);

  /**
	 * Gets all component references that match specified locator.
	 * 
	 * - [locator] 	the locator to find a reference by.
	 * - required 	forces to raise an exception if no reference is found.
	 * Returns a list with matching component references.
	 * 
	 * Throws a [ReferenceException] when required is set to true but no references found.
	 */
  List<T> find<T>(locator, bool required);
}
