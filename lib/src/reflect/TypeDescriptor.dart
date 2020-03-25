// /** @module reflect */
// import { ConfigException } from '../errors/ConfigException';

// /**
//  * Descriptor that points to specific object type by it's name
//  * and optional library (or module) where this type is defined.
//  * 
//  * This class has symmetric implementation across all languages supported
//  * by Pip.Services toolkit and used to support dynamic data processing.
//  */
// export class TypeDescriptor {
// 	private _name: string;
// 	private _library: string;
		
// 	/**
// 	 * Creates a new instance of the type descriptor and sets its values.
// 	 * 
// 	 * @param name 		a name of the object type.
// 	 * @param library 	a library or module where this object type is implemented.
// 	 */
// 	public constructor(name: string, library: string) {
// 		this._name = name;
// 		this._library = library;
// 	}
	
// 	/**
// 	 * Get the name of the object type.
// 	 * 
// 	 * @returns the name of the object type.
// 	 */
// 	public getName(): string { 
//         return this._name; 
//     }
	
// 	/**
// 	 * Gets the name of the library or module where the object type is defined.
// 	 * 
// 	 * @returns the name of the library or module.
// 	 */
// 	public getLibrary(): string { 
//         return this._library; 
//     }
	
// 	/**
// 	 * Compares this descriptor to a value.
// 	 * If the value is also a TypeDescriptor it compares their name and library fields.
// 	 * Otherwise this method returns false.
// 	 * 
// 	 * @param value		a value to compare.
// 	 * @returns true if value is identical TypeDescriptor and false otherwise.
// 	 */
// 	public equals(value: any): boolean {
// 		if (value instanceof TypeDescriptor) {
// 			let otherType = <TypeDescriptor>value;
// 			if (this.getName() == null || otherType.getName() == null)
// 				return false;
// 			if (this.getName() != otherType.getName())
// 				return false;
// 			if (this.getLibrary() == null || otherType.getLibrary() == null
// 				|| this.getLibrary() == otherType.getLibrary())
// 				return true;
// 		}
		
// 		return false;
// 	}
	
// 	/**
//      * Gets a string representation of the object.
//      * The result has format name[,library]
//      * 
//      * @returns a string representation of the object.
// 	 * 
// 	 * @see [[fromString]]
// 	 */
// 	public toString(): string {
// 		let builder = '' + this._name;
// 		if (this._library != null)
// 			builder += ',' + this._library;
// 		return builder.toString();
// 	}
	
// 	/**
//      * Parses a string to get descriptor fields and returns them as a Descriptor.
// 	 * The string must have format name[,library]
//      * 
//      * @param value     a string to parse.
//      * @returns         a newly created Descriptor.
// 	 * @throws a [[ConfigException]] if the descriptor string is of a wrong format.
// 	 * 
// 	 * @see [[toString]]
// 	 */
// 	public static fromString(value: string): TypeDescriptor {
// 		if (value == null || value.length == 0) 
// 			return null;
				
// 		let tokens = value.split(",");
// 		if (tokens.length == 1) {
// 			return new TypeDescriptor(tokens[0].trim(), null);
// 		} else if (tokens.length == 2) {
// 			return new TypeDescriptor(tokens[0].trim(), tokens[1].trim());		
// 		} else {
// 			throw new ConfigException(
// 				null, "BAD_DESCRIPTOR", "Type descriptor " + value + " is in wrong format"
// 			).withDetails("descriptor", value);
// 		}			
// 	}

// }
