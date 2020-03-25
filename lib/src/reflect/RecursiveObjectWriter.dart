// /** @module reflect */
// /** @hidden */ 
// let _ = require('lodash');

// import { IntegerConverter } from '../convert/IntegerConverter';
// import { ObjectReader } from './ObjectReader';
// import { ObjectWriter } from './ObjectWriter';
// import { RecursiveObjectReader } from './RecursiveObjectReader';

// /**
//  * Helper class to perform property introspection and dynamic writing.
//  * 
//  * It is similar to [[ObjectWriter]] but writes properties recursively
//  * through the entire object graph. Nested property names are defined
//  * using dot notation as "object.subobject.property"
//  *
//  * @see [[PropertyReflector]]
//  * @see [[ObjectWriter]]
//  */
// export class RecursiveObjectWriter {

// 	private static createProperty(obj: any, names: string[], nameIndex: number): any {
// 		// If next field is index then create an array
// 		let subField = names.length > nameIndex + 1 ? names[nameIndex + 1] : null;
// 		let subFieldIndex = IntegerConverter.toNullableInteger(subField);
// 		if (subFieldIndex != null)
// 			return [];

// 		// Else create a dictionary
// 		return {};
// 	}
	
//     private static performSetProperty(obj: any, names: string[], nameIndex: number, value: any): any {
// 		if (nameIndex < names.length - 1) {
// 			let subObj = ObjectReader.getProperty(obj, names[nameIndex]);
// 			if (subObj != null)
// 				RecursiveObjectWriter.performSetProperty(subObj, names, nameIndex + 1, value);
// 			else {
// 				subObj = RecursiveObjectWriter.createProperty(obj, names, nameIndex);
// 				if (subObj != null) {					
// 					RecursiveObjectWriter.performSetProperty(subObj, names, nameIndex + 1, value);
// 					ObjectWriter.setProperty(obj, names[nameIndex], subObj);
// 				}
// 			}
// 		} else
// 			ObjectWriter.setProperty(obj, names[nameIndex], value);
// 	}

// 	/**
// 	 * Recursively sets value of object and its subobjects property specified by its name.
// 	 * 
//      * The object can be a user defined object, map or array.
//      * The property name correspondently must be object property,
//      * map key or array index.
// 	 * 
// 	 * If the property does not exist or introspection fails
// 	 * this method doesn't do anything and doesn't any throw errors.
// 	 * 
// 	 * @param obj 	an object to write property to.
// 	 * @param name 	a name of the property to set.
// 	 * @param value a new value for the property to set.
// 	 */ 
// 	public static setProperty(obj: any, name: string, value: any): void {
//         if (obj == null || name == null) return;

//         let names = name.split(".");
//         if (names == null || names.length == 0) 
//         	return;

//         RecursiveObjectWriter.performSetProperty(obj, names, 0, value);
// 	}

// 	/**
// 	 * Recursively sets values of some (all) object and its subobjects properties.
// 	 * 
//      * The object can be a user defined object, map or array.
//      * Property values correspondently are object properties,
//      * map key-pairs or array elements with their indexes.
// 	 * 
// 	 * If some properties do not exist or introspection fails
// 	 * they are just silently skipped and no errors thrown.
// 	 * 
// 	 * @param obj 		 an object to write properties to.
// 	 * @param values 	a map, containing property names and their values.
// 	 * 
// 	 * @see [[setProperty]]
// 	 */
// 	public static setProperties(obj: any, values: any): void {
// 		if (values == null) return;
		
// 		for (let key in values) {
//             let value = values[key];
// 			RecursiveObjectWriter.setProperty(obj, key, value);
// 		}
// 	}

// 	/**
// 	 * Copies content of one object to another object
// 	 * by recursively reading all properties from source object
// 	 * and then recursively writing them to destination object.
// 	 * 
// 	 * @param dest 	a destination object to write properties to.
// 	 * @param src 	a source object to read properties from
// 	 */
// 	public static copyProperties(dest: any, src: any): void {
// 		if (dest == null || src == null) return;
		
// 		let values = RecursiveObjectReader.getProperties(src);
// 		RecursiveObjectWriter.setProperties(dest, values);
// 	}

// }
