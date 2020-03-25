// /** @module refer */
// import { TypeCode } from '../convert/TypeCode';

// /**
//  * Interface for a map that holds component references and passes them to components
//  * to establish dependencies with each other.
//  * 
//  * Together with [[IReferenceable]] and [[IUnreferenceable]] interfaces it implements
//  * a Locator pattern that is used by PipServices toolkit for Inversion of Control
//  * to assign external dependencies to components. 
//  * 
//  * The IReferences object is a simple map, where keys are locators
//  * and values are component references. It allows to add, remove and find components
//  * by their locators. Locators can be any values like integers, strings or component types.
//  * But most often PipServices toolkit uses [[Descriptor]] as locators that match
//  * by 5 fields: group, type, kind, name and version.
//  * 
//  * @see [[Descriptor]]
//  * @see [[References]]
//  * 
//  * ### Example ###
//  * 
//  *     export class MyController implements IReferenceable {
//  *         public _persistence: IMyPersistence;
//  *         ...    
//  *         public setReferences(references: IReferences): void {
//  *             this._persistence = references.getOneRequired<IMyPersistence>(
//  *                 new Descriptor("mygroup", "persistence", "*", "*", "1.0")
//  *             );
//  *         }
//  *         ...
//  *     }
//  *     
//  *     let persistence = new MyMongoDbPersistence();
//  *     
//  *     let controller = new MyController();
//  *     
//  *     let references = References.fromTuples(
//  *         new Descriptor("mygroup", "persistence", "mongodb", "default", "1.0"), persistence,
//  *         new Descriptor("mygroup", "controller", "default", "default", "1.0"), controller
//  *     );
//  *     controller.setReferences(references);
//  * 	
//  */
// export interface IReferences {
// 	/**
// 	 * Puts a new reference into this reference map.
// 	 * 
// 	 * @param locator 	a locator to find the reference by.
// 	 * @param component a component reference to be added.
// 	 */
// 	put(locator: any, component: any);

// 	/**
// 	 * Removes a previously added reference that matches specified locator.
// 	 * If many references match the locator, it removes only the first one.
// 	 * When all references shall be removed, use [[removeAll]] method instead.
// 	 * 
// 	 * @param locator 	a locator to remove reference
// 	 * @returns the removed component reference.
// 	 * 
// 	 * @see [[removeAll]]
// 	 */
// 	remove(locator: any): any;	

// 	/**
// 	 * Removes all component references that match the specified locator. 
// 	 * 
// 	 * @param locator 	the locator to remove references by.
// 	 * @returns a list, containing all removed references.
// 	 */
// 	removeAll(locator: any): any[];	
	
// 	/**
// 	 * Gets locators for all registered component references in this reference map.
// 	 * 
// 	 * @returns a list with component locators.
// 	 */
// 	getAllLocators(): any[];	

// 	/**
// 	 * Gets all component references registered in this reference map.
// 	 * 	
// 	 * @returns a list with component references.
// 	 */
// 	getAll(): any[];	
		
// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a list with matching component references or empty list if nothing was found.
// 	 */
// 	getOptional<T>(locator: any): T[];

// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * At least one component reference must be present.
// 	 * If it doesn't the method throws an error.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a list with matching component references.
// 	 * 
// 	 * @throws a [[ReferenceException]] when no references found.
// 	 */
// 	getRequired<T>(locator: any): T[];

// 	/**
// 	 * Gets an optional component reference that matches specified locator.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a matching component reference or null if nothing was found.
// 	 */
// 	getOneOptional<T>(locator: any): T;
	
// 	/**
// 	 * Gets a required component reference that matches specified locator.
// 	 * 
// 	 * @param locator 	the locator to find a reference by.	 
// 	 * @returns a matching component reference.
// 	 * @throws a [[ReferenceException]] when no references found.
// 	 */
// 	getOneRequired<T>(locator: any): T;

// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * 
// 	 * @param locator 	the locator to find a reference by.
// 	 * @param required 	forces to raise an exception if no reference is found.
// 	 * @returns a list with matching component references.
// 	 * 
// 	 * @throws a [[ReferenceException]] when required is set to true but no references found.
// 	 */
// 	find<T>(locator: any, required: boolean): T[];
// }
