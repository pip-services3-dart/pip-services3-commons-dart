// /** @module refer */
// import { Reference } from './Reference';
// import { IReferences } from './IReferences';
// import { ReferenceException } from './ReferenceException';

// /**
//  * The most basic implementation of [[IReferences]] to store and locate component references.
//  * 
//  * @see [[IReferences]]
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
//  */

// export class References implements IReferences {	
// 	protected _references: Reference[] = [];
    
//     /**
//      * Creates a new instance of references and initializes it with references.
//      * 
//      * @param tuples    (optional) a list of values where odd elements are locators and the following even elements are component references
//      */
// 	public constructor(tuples: any[] = null) {
// 		if (tuples != null) {
// 	        for (let index = 0; index < tuples.length; index += 2) {
// 	            if (index + 1 >= tuples.length) break;
	
// 	            this.put(tuples[index], tuples[index + 1]);
// 	        }
// 		}
// 	}
    
// 	/**
// 	 * Puts a new reference into this reference map.
// 	 * 
// 	 * @param locator 	a locator to find the reference by.
// 	 * @param component a component reference to be added.
// 	 */
// 	public put(locator: any, component: any): void {
// 		if (component == null)
// 			throw new Error("Component cannot be null");

//         this._references.push(new Reference(locator, component));
// 	}
    
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
// 	public remove(locator: any): any {
// 		if (locator == null) return null;

//         for (let index = this._references.length - 1; index >= 0; index--) {
//             let reference = this._references[index];
//             if (reference.match(locator)) {
//                 this._references.splice(index, 1);
//                 return reference.getComponent();
//             }
//         }
		
// 		return null;
// 	}

// 	/**
// 	 * Removes all component references that match the specified locator. 
// 	 * 
// 	 * @param locator 	the locator to remove references by.
// 	 * @returns a list, containing all removed references.
// 	 */
// 	public removeAll(locator: any): any[] {
//         let components: any[] = [];
		
// 		if (locator == null) return components;

//         for (let index = this._references.length - 1; index >= 0; index--) {
//             let reference = this._references[index];
//             if (reference.match(locator)) {
//                 this._references.splice(index, 1);
//                 components.push(reference.getComponent());
//             }
//         }
		
// 		return components;
// 	}

// 	/**
// 	 * Gets locators for all registered component references in this reference map.
// 	 * 
// 	 * @returns a list with component locators.
// 	 */
// 	public getAllLocators(): any[] {
//         let locators: any[] = [];
		
//         for (let index = 0; index < this._references.length; index++) {
//             let reference = this._references[index];
//             locators.push(reference.getLocator());
//         }
		
// 		return locators;
//     }
    
// 	/**
// 	 * Gets all component references registered in this reference map.
// 	 * 	
// 	 * @returns a list with component references.
// 	 */
//     public getAll(): any[] {
//         let components: any[] = [];
		
//         for (let index = 0; index < this._references.length; index++) {
//             let reference = this._references[index];
//             components.push(reference.getComponent());
//         }
		
// 		return components;
// 	}
    
// 	/**
// 	 * Gets an optional component reference that matches specified locator.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a matching component reference or null if nothing was found.
// 	 */
//     public getOneOptional<T>(locator: any): T {
//     	try {
// 	        let components = this.find<T>(locator, false);
//             return components.length > 0 ? components[0] : null;
//     	} catch (ex) {
//     		return null;
//     	}
//     }

// 	/**
// 	 * Gets a required component reference that matches specified locator.
// 	 * 
// 	 * @param locator 	the locator to find a reference by.	 
// 	 * @returns a matching component reference.
// 	 * @throws a [[ReferenceException]] when no references found.
// 	 */
//     public getOneRequired<T>(locator: any): T {
//         let components = this.find<T>(locator, true);
//         return components.length > 0 ? components[0] : null;
//     }

// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * 
// 	 * @param locator 	the locator to find references by.	 
// 	 * @returns a list with matching component references or empty list if nothing was found.
// 	 */
//     public getOptional<T>(locator: any): T[] {
//     	try {
//     		return this.find<T>(locator, false);
//     	} catch (ex) {
//             return [];
//     	}
//     }

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
//     public getRequired<T>(locator: any): T[] {
//         return this.find<T>(locator, true);
//     }

// 	/**
// 	 * Gets all component references that match specified locator.
// 	 * 
// 	 * @param locator 	the locator to find a reference by.
// 	 * @param required 	forces to raise an exception if no reference is found.
// 	 * @returns a list with matching component references.
// 	 * 
// 	 * @throws a [[ReferenceException]] when required is set to true but no references found.
// 	 */
// 	public find<T>(locator: any, required: boolean): T[] {
// 		if (locator == null)
// 			throw new Error("Locator cannot be null");

//         let components: T[] = [];

//         // Search all references
//         for (let index = this._references.length - 1; index >= 0; index--) {
//             let reference = this._references[index];
//             if (reference.match(locator)) {
//                 let component = reference.getComponent();
//                 components.push(component);
//             }
//         }

//         if (components.length == 0 && required)
//             throw new ReferenceException(null, locator);

//         return components;
//     }

//     /**
//      * Creates a new References from a list of key-value pairs called tuples.
//      * 
//      * @param tuples    a list of values where odd elements are locators and the following even elements are component references
//      * @returns         a newly created References.
//      * 
//      * @see [[fromTuplesArray]]
//      */
// 	public static fromTuples(...tuples: any[]): References {
// 		return new References(tuples);
// 	}
// }