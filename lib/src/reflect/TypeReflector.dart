// /** @module reflect */
// /** @hidden */ 
// let _ = require('lodash');
// /** @hidden */ 
// let path = require("path");

// import { TypeDescriptor } from './TypeDescriptor';
// import { NotFoundException } from '../errors/NotFoundException';
// import { UnsupportedException } from '../errors/UnsupportedException';
// import { TypeCode } from '../convert/TypeCode';
// import { TypeConverter } from '../convert/TypeConverter';

// /**
//  * Helper class to perform object type introspection and object instantiation.
//  * 
//  * This class has symmetric implementation across all languages supported
//  * by Pip.Services toolkit and used to support dynamic data processing.
//  * 
//  * Because all languages have different casing and case sensitivity rules,
//  * this TypeReflector treats all type names as case insensitive.
//  * 
//  * @see [[TypeDescriptor]]
//  * 
//  * ### Example ###
//  * 
//  *     let descriptor = new TypeDescriptor("MyObject", "mylibrary");
//  *     Typeeflector.getTypeByDescriptor(descriptor);
//  *     let myObj = TypeReflector.createInstanceByDescriptor(descriptor);
//  *     
//  *     TypeDescriptor.isPrimitive(myObject); 		// Result: false
//  *     TypeDescriptor.isPrimitive(123);				// Result: true
//  */
// export class TypeReflector {

// 	/**
// 	 * Gets object type by its name and library where it is defined.
// 	 * 
// 	 * @param name 		an object type name.
// 	 * @param library 	a library where the type is defined
// 	 * @returns the object type or null is the type wasn't found.
// 	 */
// 	public static getType(name: string, library: string): any {
// 		try {
// 			if (!library)
// 				library = name;

// 			let absPath = library;
// 			if (_.startsWith(absPath, '.'))
// 				absPath = path.resolve(absPath)

// 	        // Load module
//             let type = require(absPath);
//             if (type == null) return null;

//             // Get exported type by name
//             if (name != null && name.length > 0)
//                 type = type[name];

//             return type;
// 	    } catch (ex) {
// 	    	return null;
// 	    }
// 	}

// 	/**
// 	 * Gets object type by type descriptor.
// 	 * 
// 	 * @param descriptor 	a type descriptor that points to an object type
// 	 * @returns the object type or null is the type wasn't found.
// 	 * 
// 	 * @see [[getType]]
// 	 * @see [[TypeDescriptor]]
// 	 */
// 	public static getTypeByDescriptor(descriptor: TypeDescriptor): any {
// 		if (descriptor == null)
// 			throw new Error("Type descriptor cannot be null");
			
// 		return TypeReflector.getType(descriptor.getName(), descriptor.getLibrary());
// 	}

// 	/**
// 	 * Creates an instance of an object type.
// 	 * 
// 	 * @param type 		an object type (factory function) to create.
// 	 * @param args		arguments for the object constructor.
// 	 * @returns the created object instance.
// 	 */
// 	public static createInstanceByType(type: any, ...args: any[]): any {
//         if (type == null)
//             throw new Error("Type constructor cannot be null");
//         if (!_.isFunction(type))
//             throw new Error("Type contructor has to be a function");

//         return new type(...args);
// 	}

// 	/**
// 	 * Creates an instance of an object type specified by its name
// 	 * and library where it is defined.
// 	 * 
// 	 * @param name 		an object type name.
// 	 * @param library 	a library (module) where object type is defined.
// 	 * @param args		arguments for the object constructor.
// 	 * @returns the created object instance.
// 	 * 
// 	 * @see [[getType]]
// 	 * @see [[createInstanceByType]]
// 	 */
// 	public static createInstance(name: string, library: string, ...args: any[]): any {
// 		let type = TypeReflector.getType(name, library);		
// 		if (type == null)
// 			throw new NotFoundException(null, "TYPE_NOT_FOUND", "Type " + name + "," + library + " was not found")
// 				.withDetails("type", name).withDetails("library", library);
		
// 		return TypeReflector.createInstanceByType(type, ...args);
// 	}

// 	/**
// 	 * Creates an instance of an object type specified by type descriptor.
// 	 * 
// 	 * @param descriptor 	a type descriptor that points to an object type
// 	 * @param args		arguments for the object constructor.
// 	 * @returns the created object instance.
// 	 * 
// 	 * @see [[createInstance]]
// 	 * @see [[TypeDescriptor]]
// 	 */
// 	public static createInstanceByDescriptor(descriptor: TypeDescriptor, ...args: any[]): any {
// 		if (descriptor == null)
// 			throw new Error("Type descriptor cannot be null");

// 		return TypeReflector.createInstance(descriptor.getName(), descriptor.getLibrary(), ...args);
// 	}

// 	/**
// 	 * Checks if value has primitive type.
// 	 * 
// 	 * Primitive types are: numbers, strings, booleans, date and time.
// 	 * Complex (non-primitive types are): objects, maps and arrays
// 	 * 
// 	 * @param value 	a value to check
// 	 * @returns true if the value has primitive type and false if value type is complex.
// 	 * 
// 	 * @see [[TypeConverter.toTypeCode]]
// 	 * @see [[TypeCode]]
// 	 */
// 	public static isPrimitive(value: any): boolean {
// 		let typeCode = TypeConverter.toTypeCode(value);
// 		return typeCode == TypeCode.String || typeCode == TypeCode.Enum
// 			|| typeCode == TypeCode.Boolean || typeCode == TypeCode.Integer
// 			|| typeCode == TypeCode.Long || typeCode == TypeCode.Float
// 			|| typeCode == TypeCode.Double || typeCode == TypeCode.DateTime
// 			|| typeCode == TypeCode.Duration;
// 	}

// }
