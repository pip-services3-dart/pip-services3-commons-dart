// /** @module refer */
// import { StringConverter } from '../convert/StringConverter';
// import { ConfigParams } from '../config/ConfigParams';
// import { IReconfigurable } from '../config/IReconfigurable';
// import { IReferenceable } from './IReferenceable';
// import { IReferences } from './IReferences';
// import { ReferenceException } from './ReferenceException';
// import { Descriptor } from './Descriptor';

// /**
//  * Helper class for resolving component dependencies.
//  * 
//  * The resolver is configured to resolve named dependencies by specific locator.
//  * During deployment the dependency locator can be changed.
//  * 
//  * This mechanism can be used to clarify specific dependency among several alternatives.
//  * Typically components are configured to retrieve the first dependency that matches
//  * logical group, type and version. But if container contains more than one instance
//  * and resolution has to be specific about those instances, they can be given a unique
//  * name and dependency resolvers can be reconfigured to retrieve dependencies by their name.
//  * 
//  * ### Configuration parameters ###
//  * 
//  * dependencies:
//  * - [dependency name 1]: Dependency 1 locator (descriptor)
//  * - ...
//  * - [dependency name N]: Dependency N locator (descriptor)
//  * 
//  * ### References ###
//  * 
//  * References must match configured dependencies.
//  * 
//  * ### Example ###
//  * 
//  *     class MyComponent: IConfigurable, IReferenceable {
//  *         private _dependencyResolver: DependencyResolver = new DependencyResolver();
//  *         private _persistence: IMyPersistence;
//  *         ...
//  *         
//  *         public constructor() {
//  *             this._dependencyResolver.put("persistence", new Descriptor("mygroup", "persistence", "*", "*", "1.0"));
//  *         }
//  *         
//  *         public configure(config: ConfigParams): void {
//  *             this._dependencyResolver.configure(config);
//  *         }  
//  *         
//  *         public setReferences(references: IReferences): void {
//  *             this._dependencyResolver.setReferences(references);
//  *             this._persistence = this._dependencyResolver.getOneRequired<IMyPersistence>("persistence");
//  *         }
//  *     }
//  *     
//  *     // Create mycomponent and set specific dependency out of many
//  *     let component = new MyComponent();
//  *     component.configure(ConfigParams.fromTuples(
//  *         "dependencies.persistence", "mygroup:persistence:*:persistence2:1.0" 
//  *     // Override default persistence dependency
//  *     ));
//  *     component.setReferences(References.fromTuples(
//  *         new Descriptor("mygroup","persistence","*","persistence1","1.0"), new MyPersistence(),
//  *         new Descriptor("mygroup","persistence","*","persistence2","1.0"), new MyPersistence()  
//  *     // This dependency shall be set
//  *     ));
//  * 
//  * @see [[IReferences]]
//  */
// export class DependencyResolver implements IReferenceable, IReconfigurable {
// 	private _dependencies: any = {};
// 	private _references: IReferences;
	
// 	/**
// 	 * Creates a new instance of the dependency resolver.
// 	 * 
// 	 * @param config		(optional) default configuration where key is dependency name and value is locator (descriptor)
// 	 * @param references	(optional) default component references
// 	 * 
// 	 * @see [[ConfigParams]]
// 	 * @see [[configure]]
// 	 * @see [[IReferences]]
// 	 * @see [[setReferences]]
// 	 */
// 	public constructor(config?: ConfigParams, references?: IReferences) {
// 		if (config != null)
// 			this.configure(config);
// 		if (references != null)
// 			this.setReferences(references);
// 	}

// 	/**
// 	 * Configures the component with specified parameters.
// 	 * 
// 	 * @param config 	configuration parameters to set.
// 	 * 
// 	 * @see [[ConfigParams]]
// 	 */
// 	public configure(config: ConfigParams): void {
// 		let dependencies = config.getSection("dependencies");
//         let names = dependencies.getKeys();
// 		for (let index = 0; index < names.length; index++) {
//             let name = names[index];
// 			let locator = dependencies.get(name);
// 			if (locator == null) continue;
			
// 			try {
// 				let descriptor = Descriptor.fromString(locator);
// 				if (descriptor != null)
// 					this._dependencies[name] = descriptor;
// 				else
// 					this._dependencies[name] = locator;
// 			} catch (ex) {
// 				this._dependencies[name] = locator;
// 			}
// 		}
// 	}

// 	/**
// 	 * Sets the component references. References must match configured dependencies.
// 	 * 
// 	 * @param references 	references to set.
// 	 */
// 	public setReferences(references: IReferences): void {
// 		this._references = references;
// 	}

// 	/**
// 	 * Adds a new dependency into this resolver.
// 	 * 
// 	 * @param name 		the dependency's name.
// 	 * @param locator 	the locator to find the dependency by.
// 	 */
// 	public put(name: string, locator: any): void {
// 		this._dependencies[name] = locator;
// 	}

// 	/**
// 	 * Gets a dependency locator by its name.
// 	 * 
// 	 * @param name 	the name of the dependency to locate.
// 	 * @returns the dependency locator or null if locator was not configured.
// 	 */
// 	private locate(name: string): any {
// 		if (name == null)
// 			throw new Error("Dependency name cannot be null");
// 		if (this._references == null)
// 			throw new Error("References shall be set");
		
// 		return this._dependencies[name];
// 	}
	
//     /**
// 	 * Gets all optional dependencies by their name.
// 	 * 
// 	 * @param name 		the dependency name to locate.
// 	 * @returns a list with found dependencies or empty list of no dependencies was found.
// 	 */
// 	public getOptional<T>(name: string): T[] {
// 		let locator = this.locate(name);		
// 		return locator != null ? this._references.getOptional<T>(locator) : null;
// 	}

// 	/**
// 	 * Gets all required dependencies by their name.
// 	 * At least one dependency must be present.
// 	 * If no dependencies was found it throws a [[ReferenceException]]
// 	 * 
// 	 * @param name 		the dependency name to locate.
// 	 * @returns a list with found dependencies.
// 	 * 
// 	 * @throws a [[ReferenceException]] if no dependencies were found.
// 	 */
// 	public getRequired<T>(name: string): T[] {
// 		let locator = this.locate(name);
// 		if (locator == null)
// 			throw new ReferenceException(null, name);
		
// 		return this._references.getRequired<T>(locator);
// 	}

//     /**
// 	 * Gets one optional dependency by its name.
// 	 * 
// 	 * @param name 		the dependency name to locate.
// 	 * @returns a dependency reference or null of the dependency was not found
// 	 */
// 	public getOneOptional<T>(name: string): T {
// 		let locator = this.locate(name);
// 		return locator != null ? this._references.getOneOptional<T>(locator) : null;
// 	}

// 	/**
// 	 * Gets one required dependency by its name.
// 	 * At least one dependency must present.
// 	 * If the dependency was found it throws a [[ReferenceException]]
// 	 * 
// 	 * @param name 		the dependency name to locate.
// 	 * @returns a dependency reference
// 	 * 
// 	 * @throws a [[ReferenceException]] if dependency was not found.
// 	 */
// 	public getOneRequired<T>(name: string): T {
// 		let locator = this.locate(name);
// 		if (locator == null)
// 			throw new ReferenceException(null, name);
		
// 		return this._references.getOneRequired<T>(locator);
// 	}

// 	/**
// 	 * Finds all matching dependencies by their name.
// 	 * 
// 	 * @param name 		the dependency name to locate.
// 	 * @param required 	true to raise an exception when no dependencies are found.
// 	 * @returns a list of found dependencies
// 	 * 
// 	 * @throws a [[ReferenceException]] of required is true and no dependencies found.
// 	 */
// 	public find<T>(name: string, required: boolean): T[] {
// 		if (name == null)
// 			throw new Error("Name cannot be null");
		
// 		let locator = this.locate(name);
// 		if (locator == null) {
// 			if (required)
// 				throw new ReferenceException(null, name);
// 			return null;
// 		}
		
// 		return this._references.find<T>(locator, required);
// 	}
	
// 	/**
//      * Creates a new DependencyResolver from a list of key-value pairs called tuples
// 	 * where key is dependency name and value the depedency locator (descriptor).
//      * 
//      * @param tuples    a list of values where odd elements are dependency name and the following even elements are dependency locator (descriptor)
//      * @returns         a newly created DependencyResolver.
//      * 
//      * @see [[fromTuplesArray]]
//      */
// 	public static fromTuples(...tuples: any[]): DependencyResolver {
// 		let result = new DependencyResolver();
//     	if (tuples == null || tuples.length == 0)
//     		return result;
    	
//         for (let index = 0; index < tuples.length; index += 2) {
//             if (index + 1 >= tuples.length) break;

//             let name = StringConverter.toString(tuples[index]);
//             let locator = tuples[index + 1];

//             result.put(name, locator);
//         }
         
//         return result;
// 	}
// }
