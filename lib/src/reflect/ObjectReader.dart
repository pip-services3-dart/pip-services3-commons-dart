// /** @module reflect */
// /** @hidden */ 
// let _ = require('lodash');

// import { PropertyReflector } from './PropertyReflector';
// import { IntegerConverter } from '../convert/IntegerConverter';

// /**
//  * Helper class to perform property introspection and dynamic reading.
//  * 
//  * In contrast to [[PropertyReflector]] which only introspects regular objects,
//  * this ObjectReader is also able to handle maps and arrays.
//  * For maps properties are key-pairs identified by string keys,
//  * For arrays properties are elements identified by integer index.
//  * 
//  * This class has symmetric implementation across all languages supported
//  * by Pip.Services toolkit and used to support dynamic data processing.
//  * 
//  * Because all languages have different casing and case sensitivity rules,
//  * this ObjectReader treats all property names as case insensitive.
//  *
//  * @see [[PropertyReflector]]
//  * 
//  * ### Example ###
//  * 
//  *     let myObj = new MyObject();
//  *     
//  *     let properties = ObjectReader.getPropertyNames();
//  *     ObjectReader.hasProperty(myObj, "myProperty");
//  *     let value = PropertyReflector.getProperty(myObj, "myProperty");
//  *     
//  *     let myMap = { key1: 123, key2: "ABC" };
//  *     ObjectReader.hasProperty(myMap, "key1");
//  *     let value = ObjectReader.getProperty(myMap, "key1");
//  *     
//  *     let myArray = [1, 2, 3]
//  *     ObjectReader.hasProperty(myArrat, "0");
//  *     let value = ObjectReader.getProperty(myArray, "0");
//  */
// export class ObjectReader {
    
//     /**
//      * Gets a real object value.
//      * If object is a wrapper, it unwraps the value behind it. 
//      * Otherwise it returns the same object value.
//      * 
//      * @param obj   an object to unwrap..
//      * @returns an actual (unwrapped) object value. 
//      */
//     public static getValue(obj: any): any {
//     	// Todo: just a blank implementation for compatibility
//         return obj;
//     }

//     /**
// 	 * Checks if object has a property with specified name.
//      * 
//      * The object can be a user defined object, map or array.
//      * The property name correspondently must be object property,
//      * map key or array index.
// 	 * 
// 	 * @param obj 	an object to introspect.
// 	 * @param name 	a name of the property to check.
// 	 * @returns true if the object has the property and false if it doesn't.
//      */
// 	public static hasProperty(obj: any, name: string): boolean {
//         if (obj == null || name == null) {
//         	return false;
//         } else if (_.isObject(obj) && !_.isDate(obj)) {
//             return PropertyReflector.hasProperty(obj, name);
//         } else if (_.isArray(obj)) {
//             let index = IntegerConverter.toNullableInteger(name);
//             return index != null && index < obj.length;
//         } else {
//             return false;
//         }
//     }

//     /**
// 	 * Gets value of object property specified by its name.
// 	 * 
//      * The object can be a user defined object, map or array.
//      * The property name correspondently must be object property,
//      * map key or array index.
//      * 
// 	 * @param obj 	an object to read property from.
// 	 * @param name 	a name of the property to get.
// 	 * @returns the property value or null if property doesn't exist or introspection failed.
//      */
// 	public static getProperty(obj: any, name: string): any {
//         if (obj == null || name == null) {
//         	return null;
//         } else if (_.isObject(obj) && !_.isDate(obj)) {
//             return PropertyReflector.getProperty(obj, name);
//         } else if (_.isArray(obj)) {
//             let index = IntegerConverter.toNullableInteger(name);
//             return index != null && index < obj.length ? obj[index] : null;
//         } else {
//             return null;
//         }
//     }

//     /**
//      * Gets names of all properties implemented in specified object.
//      * 
//      * The object can be a user defined object, map or array.
//      * Returned property name correspondently are object properties,
//      * map keys or array indexes.
//      * 
//      * @param obj   an objec to introspect.
//      * @returns a list with property names.
//      */
// 	public static getPropertyNames(obj: any): string[] {
//         let properties: string[] = [];
        
//         if (obj == null) {
//         	// Do nothing
//         } else if (_.isObject(obj) && !_.isDate(obj)) {
//             properties = PropertyReflector.getPropertyNames(obj);
//         } else if (_.isArray(obj)) {
// 			let length = obj.length;
//             for (let index = 0; index < length; index++)
//             	properties.push(index.toString());
//         } else {
//             // Do nothing
//         }

//         return properties;
//     }

//     /**
//      * Get values of all properties in specified object
// 	 * and returns them as a map.
//      * 
//      * The object can be a user defined object, map or array.
//      * Returned properties correspondently are object properties,
//      * map key-pairs or array elements with their indexes.
//      * 
//      * @param obj   an object to get properties from.
//      * @returns a map, containing the names of the object's properties and their values.
//      */
// 	public static getProperties(obj: any): any {
//         let map: any = {};
        
//         if (obj == null) {
//         	// Do nothing
//         } else if (_.isObject(obj) && !_.isDate(obj)) {
//             map = PropertyReflector.getProperties(obj);
//         } else if (_.isArray(obj)) {
// 			let length = obj.length;
//             for (let index = 0; index < length; index++)
//                 map[index.toString()] = obj[index];
//         } else {
//             // Do nothing
//         }

//         return map;
//     }
// }
