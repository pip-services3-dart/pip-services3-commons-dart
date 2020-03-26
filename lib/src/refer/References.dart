import './Reference.dart';
import './IReferences.dart';
import './ReferenceException.dart';

/**
 * The most basic implementation of [[IReferences]] to store and locate component references.
 * 
 * @see [[IReferences]]
 * 
 * ### Example ###
 * 
 *     class MyController implements IReferenceable {
 *         public _persistence: IMyPersistence;
 *         ...    
 *         public setReferences(references: IReferences): void {
 *             this._persistence = references.getOneRequired<IMyPersistence>(
 *                 new Descriptor("mygroup", "persistence", "*", "*", "1.0")
 *             );
 *         }
 *         ...
 *     }
 *     
 *     let persistence = new MyMongoDbPersistence();
 *     
 *     let controller = new MyController();
 *     
 *     let references = References.fromTuples(
 *         new Descriptor("mygroup", "persistence", "mongodb", "default", "1.0"), persistence,
 *         new Descriptor("mygroup", "controller", "default", "default", "1.0"), controller
 *     );
 *     controller.setReferences(references);
 */

class References implements IReferences {
  var _references = new List<Reference>();

  /**
     * Creates a new instance of references and initializes it with references.
     * 
     * @param tuples    (optional) a list of values where odd elements are locators and the following even elements are component references
     */
  References([List tuples = null]) {
    if (tuples != null) {
      for (var index = 0; index < tuples.length; index += 2) {
        if (index + 1 >= tuples.length) break;

        this.put(tuples[index], tuples[index + 1]);
      }
    }
  }

  /**
	 * Puts a new reference into this reference map.
	 * 
	 * @param locator 	a locator to find the reference by.
	 * @param component a component reference to be added.
	 */
  void put(locator, component) {
    if (component == null) throw new Exception("Component cannot be null");

    this._references.add(new Reference(locator, component));
  }

  /**
	 * Removes a previously added reference that matches specified locator.
	 * If many references match the locator, it removes only the first one.
	 * When all references shall be removed, use [[removeAll]] method instead.
	 * 
	 * @param locator 	a locator to remove reference
	 * @returns the removed component reference.
	 * 
	 * @see [[removeAll]]
	 */
  remove(locator) {
    if (locator == null) return null;

    for (var index = this._references.length - 1; index >= 0; index--) {
      var reference = this._references[index];
      if (reference.match(locator)) {
        this._references.removeAt(index);
        return reference.getComponent();
      }
    }

    return null;
  }

  /**
	 * Removes all component references that match the specified locator. 
	 * 
	 * @param locator 	the locator to remove references by.
	 * @returns a list, containing all removed references.
	 */
  List removeAll(locator) {
    var components = new List();

    if (locator == null) return components;

    for (var index = this._references.length - 1; index >= 0; index--) {
      var reference = this._references[index];
      if (reference.match(locator)) {
        this._references.removeAt(index);
        components.add(reference.getComponent());
      }
    }

    return components;
  }

  /**
	 * Gets locators for all registered component references in this reference map.
	 * 
	 * @returns a list with component locators.
	 */
  List getAllLocators() {
    var locators = new List();

    for (var index = 0; index < this._references.length; index++) {
      var reference = this._references[index];
      locators.add(reference.getLocator());
    }

    return locators;
  }

  /**
	 * Gets all component references registered in this reference map.
	 * 	
	 * @returns a list with component references.
	 */
  List getAll() {
    var components = new List();

    for (var index = 0; index < this._references.length; index++) {
      var reference = this._references[index];
      components.add(reference.getComponent());
    }

    return components;
  }

  /**
	 * Gets an optional component reference that matches specified locator.
	 * 
	 * @param locator 	the locator to find references by.	 
	 * @returns a matching component reference or null if nothing was found.
	 */
  T getOneOptional<T>(locator) {
    try {
      var components = this.find<T>(locator, false);
      return components.length > 0 ? components[0] : null;
    } catch (ex) {
      return null;
    }
  }

  /**
	 * Gets a required component reference that matches specified locator.
	 * 
	 * @param locator 	the locator to find a reference by.	 
	 * @returns a matching component reference.
	 * @throws a [[ReferenceException]] when no references found.
	 */
  T getOneRequired<T>(locator) {
    var components = this.find<T>(locator, true);
    return components.length > 0 ? components[0] : null;
  }

  /**
	 * Gets all component references that match specified locator.
	 * 
	 * @param locator 	the locator to find references by.	 
	 * @returns a list with matching component references or empty list if nothing was found.
	 */
  List<T> getOptional<T>(locator) {
    try {
      return this.find<T>(locator, false);
    } catch (ex) {
      return new List<T>();
    }
  }

  /**
	 * Gets all component references that match specified locator.
	 * At least one component reference must be present.
	 * If it doesn't the method throws an error.
	 * 
	 * @param locator 	the locator to find references by.	 
	 * @returns a list with matching component references.
	 * 
	 * @throws a [[ReferenceException]] when no references found.
	 */
  List<T> getRequired<T>(locator) {
    return this.find<T>(locator, true);
  }

  /**
	 * Gets all component references that match specified locator.
	 * 
	 * @param locator 	the locator to find a reference by.
	 * @param required 	forces to raise an exception if no reference is found.
	 * @returns a list with matching component references.
	 * 
	 * @throws a [[ReferenceException]] when required is set to true but no references found.
	 */
  List<T> find<T>(locator, bool required) {
    if (locator == null) throw new Exception("Locator cannot be null");

    var components = new List<T>();

    // Search all references
    for (var index = this._references.length - 1; index >= 0; index--) {
      var reference = this._references[index];
      if (reference.match(locator)) {
        var component = reference.getComponent() as T;
        if (component != null) components.add(component);
      }
    }

    if (components.length == 0 && required)
      throw new ReferenceException(null, locator);

    return components;
  }

  /**
   * Creates a new References from a list of key-value pairs called tuples.
   * 
   * @param tuples    a list of values where odd elements are locators and the following even elements are component references
   * @returns         a newly created References.
   * 
   * @see [[fromTuplesArray]]
   */
  static References fromTuples(List tuples) {
    return new References(tuples);
  }
}
