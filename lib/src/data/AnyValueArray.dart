// /** @module data */
// /** @hidden */ 
// let _ = require('lodash');

// import { TypeCode } from '../convert/TypeCode';
// import { TypeConverter } from '../convert/TypeConverter';
// import { StringConverter } from '../convert/StringConverter';
// import { BooleanConverter } from '../convert/BooleanConverter';
// import { IntegerConverter } from '../convert/IntegerConverter';
// import { LongConverter } from '../convert/LongConverter';
// import { FloatConverter } from '../convert/FloatConverter';
// import { DoubleConverter } from '../convert/DoubleConverter';
// import { DateTimeConverter } from '../convert/DateTimeConverter';
// import { ArrayConverter } from '../convert/ArrayConverter';
// import { ICloneable } from './ICloneable';
// import { AnyValue } from './AnyValue';
// import { AnyValueMap } from './AnyValueMap';

// /**
//  * Cross-language implementation of dynamic object array what can hold values of any type.
//  * The stored values can be converted to different types using variety of accessor methods.
//  * 
//  * ### Example ###
//  * 
//  *     let value1 = new AnyValueArray([1, "123.456", "2018-01-01"]);
//  *     
//  *     value1.getAsBoolean(0);   // Result: true
//  *     value1.getAsInteger(1);   // Result: 123
//  *     value1.getAsFloat(1);     // Result: 123.456
//  *     value1.getAsDateTime(2);  // Result: new Date(2018,0,1)
//  * 
//  * @see [[StringConverter]]
//  * @see [[TypeConverter]]
//  * @see [[BooleanConverter]]
//  * @see [[IntegerConverter]]
//  * @see [[LongConverter]]
//  * @see [[DoubleConverter]]
//  * @see [[FloatConverter]]
//  * @see [[DateTimeConverter]]
//  * @see [[ICloneable]]
//  */
// export class AnyValueArray extends Array<any> implements ICloneable {

//     /**
//      * Creates a new instance of the array and assigns its value.
//      * 
//      * @param value     (optional) values to initialize this array.
//      */
//     public constructor(values: any[] = null) {
//         super();

//         // Set the prototype explicitly.
//         // https://github.com/Microsoft/TypeScript-wiki/blob/master/Breaking-Changes.md#extending-built-ins-like-error-array-and-map-may-no-longer-work
//         (<any>this).__proto__ = AnyValueArray.prototype;

//         this.append(values);
//     }
    
//     /**
//      * Gets an array element specified by its index.
//      * 
//      * @param index     an index of the element to get.
//      * @returns         the value of the array element.
//      */
//     public get(index: number): any {
//         return this[index];
//     }

//     /**
//      * Puts a new value into array element specified by its index.
//      * 
//      * @param index     an index of the element to put.
//      * @param value     a new value for array element.
//      */
//     public put(index: number, value: any): void {
//         this[index] = value;
//     }

//     /**
//      * Removes an array element specified by its index
//      * 
//      * @param index     an index of the element to remove.
//      */
//     public remove(index: number): void {
//         this.splice(index, 1);
//     }

//     /**
//      * Appends new elements to this array.
//      * 
//      * @param elements  a list of elements to be added.
//      */
//     public append(elements: any[]): void {
//     	if (elements != null) {
//             for (let index = 0; index < elements.length; index++)            	
//             	this.push(elements[index]);
//     	}
//     }

//     /**
//      * Clears this array by removing all its elements.
//     */
//     public clear(): void {
//         this.splice(0, this.length);
//     }

//     /**
//      * Gets the value stored in array element without any conversions.
//      * When element index is not defined it returns the entire array value.
//      * 
//      * @param index     (optional) an index of the element to get
//      * @returns the element value or value of the array when index is not defined. 
//      */
//     public getAsObject(index: number = undefined): any {
//         if (index === undefined) {
//             let result: any[] = [];
//             for (index = 0; index < this.length; index++)
//                 result.push(this[index]);
//             return result;
//         } else {
//             return this[index];
//         }
//     }

//     /**
//      * Sets a new value to array element specified by its index.
//      * When the index is not defined, it resets the entire array value.
//      * This method has double purpose because method overrides are not supported in JavaScript.
//      * 
//      * @param index     (optional) an index of the element to set
//      * @param value     a new element or array value.
//      * 
//      * @see [[ArrayConverter.toArray]]
//      */
//     public setAsObject(index: any, value: any = undefined): void {
//         if (value === undefined) {
//             value = index //originally was not present - added by Mark Makarychev.
//             this.clear();
//             let elements = ArrayConverter.toArray(value);
//             this.append(elements);
//         } else {
//             this[index] = value;
//         }
//     }
    
//     /** 
//      * Converts array element into a string or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns string value of the element or null if conversion is not supported. 
//      * 
//      * @see [[StringConverter.toNullableString]]
//      */
//     public getAsNullableString(index: number): string {
//         let value = this[index];
//         return StringConverter.toNullableString(value);
//     }

//     /** 
//      * Converts array element into a string or returns "" if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns string value ot the element or "" if conversion is not supported. 
//      * 
//      * @see [[getAsStringWithDefault]]
//      */
//     public getAsString(index: number): string {
//         return this.getAsStringWithDefault(index, null);
//     }

//     /**
//      * Converts array element into a string or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns string value ot the element or default value if conversion is not supported. 
//      * 
//      * @see [[StringConverter.toStringWithDefault]]
//      */
//     public getAsStringWithDefault(index: number, defaultValue: string): string {
//         let value = this[index];
//         return StringConverter.toStringWithDefault(value, defaultValue);
//     }

//     /** 
//      * Converts array element into a boolean or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns boolean value of the element or null if conversion is not supported. 
//      * 
//      * @see [[BooleanConverter.toNullableBoolean]]
//      */
//     public getAsNullableBoolean(index: number): boolean {
//         let value = this[index];
//         return BooleanConverter.toNullableBoolean(value);
//     }

//     /** 
//      * Converts array element into a boolean or returns false if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns boolean value ot the element or false if conversion is not supported. 
//      * 
//      * @see [[getAsBooleanWithDefault]]
//      */
//     public getAsBoolean(index: number): boolean {
//         return this.getAsBooleanWithDefault(index, false);
//     }

//     /**
//      * Converts array element into a boolean or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns boolean value ot the element or default value if conversion is not supported. 
//      * 
//      * @see [[BooleanConverter.toBooleanWithDefault]]
//      */
//     public getAsBooleanWithDefault(index: number, defaultValue: boolean): boolean {
//         let value = this[index];
//         return BooleanConverter.toBooleanWithDefault(value, defaultValue);
//     }

//     /** 
//      * Converts array element into an integer or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns integer value of the element or null if conversion is not supported. 
//      * 
//      * @see [[IntegerConverter.toNullableInteger]]
//      */
//     public getAsNullableInteger(index: number): number {
//         let value = this[index];
//         return IntegerConverter.toNullableInteger(value);
//     }

//     /** 
//      * Converts array element into an integer or returns 0 if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns integer value ot the element or 0 if conversion is not supported. 
//      * 
//      * @see [[getAsIntegerWithDefault]]
//      */
//     public getAsInteger(index: number): number {
//         return this.getAsIntegerWithDefault(index, 0);
//     }

//     /**
//      * Converts array element into an integer or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns integer value ot the element or default value if conversion is not supported. 
//      * 
//      * @see [[IntegerConverter.toIntegerWithDefault]]
//      */
//     public getAsIntegerWithDefault(index: number, defaultValue: number): number {
//         let value = this[index];
//         return IntegerConverter.toIntegerWithDefault(value, defaultValue);
//     }

//     /** 
//      * Converts array element into a long or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns long value of the element or null if conversion is not supported. 
//      * 
//      * @see [[LongConverter.toNullableLong]]
//      */
//     public getAsNullableLong(index: number): number {
//         let value = this[index];
//         return LongConverter.toNullableLong(value);
//     }

//     /** 
//      * Converts array element into a long or returns 0 if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns long value ot the element or 0 if conversion is not supported. 
//      * 
//      * @see [[getAsLongWithDefault]]
//      */
//     public getAsLong(index: number): number {
//         return this.getAsLongWithDefault(index, 0);
//     }

//     /**
//      * Converts array element into a long or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns long value ot the element or default value if conversion is not supported. 
//      * 
//      * @see [[LongConverter.toLongWithDefault]]
//      */
//     public getAsLongWithDefault(index: number, defaultValue: number): number {
//         let value = this[index];
//         return LongConverter.toLongWithDefault(value, defaultValue);
//     }

//     /** 
//      * Converts array element into a float or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns float value of the element or null if conversion is not supported. 
//      * 
//      * @see [[FloatConverter.toNullableFloat]]
//      */
//     public getAsNullableFloat(index: number): number {
//         let value = this[index];
//         return FloatConverter.toNullableFloat(value);
//     }

//     /** 
//      * Converts array element into a float or returns 0 if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns float value ot the element or 0 if conversion is not supported. 
//      * 
//      * @see [[getAsFloatWithDefault]]
//      */
//     public getAsFloat(index: number): number {
//         return this.getAsFloatWithDefault(index, 0);
//     }

//     /**
//      * Converts array element into a float or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns float value ot the element or default value if conversion is not supported. 
//      * 
//      * @see [[FloatConverter.toFloatWithDefault]]
//      */
//     public getAsFloatWithDefault(index: number, defaultValue: number): number {
//         let value = this[index];
//         return FloatConverter.toFloatWithDefault(value, defaultValue);
//     }

//     /** 
//      * Converts array element into a double or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns double value of the element or null if conversion is not supported. 
//      * 
//      * @see [[DoubleConverter.toNullableDouble]]
//      */
//     public getAsNullableDouble(index: number): number {
//         let value = this[index];
//         return DoubleConverter.toNullableDouble(value);
//     }

//     /** 
//      * Converts array element into a double or returns 0 if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns double value ot the element or 0 if conversion is not supported. 
//      * 
//      * @see [[getAsDoubleWithDefault]]
//      */
//     public getAsDouble(index: number) {
//         return this.getAsDoubleWithDefault(index, 0);
//     }

//     /**
//      * Converts array element into a double or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns double value ot the element or default value if conversion is not supported. 
//      * 
//      * @see [[DoubleConverter.toDoubleWithDefault]]
//      */
//     public getAsDoubleWithDefault(index: number, defaultValue: number): number {
//         let value = this[index];
//         return DoubleConverter.toDoubleWithDefault(value, defaultValue);
//     }

//     /** 
//      * Converts array element into a Date or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns Date value of the element or null if conversion is not supported. 
//      * 
//      * @see [[DateTimeConverter.toNullableDateTime]]
//      */
//     public getAsNullableDateTime(index: number): Date {
//         let value = this[index];
//         return DateTimeConverter.toNullableDateTime(value);
//     }

//     /** 
//      * Converts array element into a Date or returns the current date if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns Date value ot the element or the current date if conversion is not supported. 
//      * 
//      * @see [[getAsDateTimeWithDefault]]
//      */
//     public getAsDateTime(index: number): Date {
//         return this.getAsDateTimeWithDefault(index, new Date());
//     }

//     /**
//      * Converts array element into a Date or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns Date value ot the element or default value if conversion is not supported. 
//      * 
//      * @see [[DateTimeConverter.toDateTimeWithDefault]]
//      */
//     public getAsDateTimeWithDefault(index: number, defaultValue: Date): Date {
//         let value = this[index];
//         return DateTimeConverter.toDateTimeWithDefault(value, defaultValue);
//     }

//     /** 
//      * Converts array element into a value defined by specied typecode.
//      * If conversion is not possible it returns null.
//      * 
//      * @param type      the TypeCode that defined the type of the result
//      * @param index     an index of element to get.
//      * @returns element value defined by the typecode or null if conversion is not supported. 
//      * 
//      * @see [[TypeConverter.toNullableType]]
//      */
//     public getAsNullableType<T>(type: TypeCode, index: number): T {
//         let value = this[index];
//         return TypeConverter.toNullableType<T>(type, value);
//     }

//     /** 
//      * Converts array element into a value defined by specied typecode.
//      * If conversion is not possible it returns default value for the specified type.
//      * 
//      * @param type      the TypeCode that defined the type of the result
//      * @param index     an index of element to get.
//      * @returns element value defined by the typecode or default if conversion is not supported. 
//      * 
//      * @see [[getAsTypeWithDefault]]
//      */
//     public getAsType<T>(type: TypeCode, index: number): T {
//         return this.getAsTypeWithDefault(type, index, null);
//     }

//     /**
//      * Converts array element into a value defined by specied typecode.
//      * If conversion is not possible it returns default value.
//      * 
//      * @param type          the TypeCode that defined the type of the result
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns element value defined by the typecode or default value if conversion is not supported. 
//      * 
//      * @see [[TypeConverter.toTypeWithDefault]]
//      */
//     public getAsTypeWithDefault<T>(type: TypeCode, index: number, defaultValue: T): T {
//         let value = this[index];
//         return TypeConverter.toTypeWithDefault(type, value, defaultValue);
//     }

//     /** 
//      * Converts array element into an AnyValue or returns an empty AnyValue if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns AnyValue value of the element or empty AnyValue if conversion is not supported. 
//      * 
//      * @see [[AnyValue]]
//      * @see [[AnyValue.constructor]]
//      */
//     public getAsValue(index: number): AnyValue {
//         let value = this[index];
//     	return new AnyValue(value);
//     }

//     /** 
//      * Converts array element into an AnyValueArray or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns AnyValueArray value of the element or null if conversion is not supported. 
//      * 
//      * @see [[fromValue]]
//      */
//     public getAsNullableArray(index: number): AnyValueArray {
//         let value = this[index];
//     	return value != null ? AnyValueArray.fromValue(value) : null;
//     }

//     /** 
//      * Converts array element into an AnyValueArray or returns empty AnyValueArray if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns AnyValueArray value of the element or empty AnyValueArray if conversion is not supported. 
//      * 
//      * @see [[fromValue]]
//      */
//     public getAsArray(index: number): AnyValueArray {
//         let value = this[index];
//     	return AnyValueArray.fromValue(value);
//     }
    
//     /** 
//      * Converts array element into an AnyValueArray or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns AnyValueArray value of the element or default value if conversion is not supported. 
//      * 
//      * @see [[getAsNullableArray]]
//      */
//     public getAsArrayWithDefault(index: number, defaultValue: AnyValueArray): AnyValueArray {
//     	let result = this.getAsNullableArray(index);
//     	return result != null ? result : defaultValue;
//     }

//     /** 
//      * Converts array element into an AnyValueMap or returns null if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns AnyValueMap value of the element or null if conversion is not supported. 
//      * 
//      * @see [[AnyValueMap]]
//      * @see [[AnyValueMap.fromValue]]
//      */
//     public getAsNullableMap(index: number): AnyValueMap {
//         let value = this[index];
//     	return value != null ? AnyValueMap.fromValue(value) : null;
//     }

//     /** 
//      * Converts array element into an AnyValueMap or returns empty AnyValueMap if conversion is not possible.
//      * 
//      * @param index     an index of element to get.
//      * @returns AnyValueMap value of the element or empty AnyValueMap if conversion is not supported. 
//      * 
//      * @see [[AnyValueMap]]
//      * @see [[AnyValueMap.fromValue]]
//      */
//     public getAsMap(index: number): AnyValueMap {
//         let value = this[index];
//     	return AnyValueMap.fromValue(value);
//     }

//     /** 
//      * Converts array element into an AnyValueMap or returns default value if conversion is not possible.
//      * 
//      * @param index         an index of element to get.
//      * @param defaultValue  the default value
//      * @returns AnyValueMap value of the element or default value if conversion is not supported. 
//      * 
//      * @see [[getAsNullableMap]]
//      */
//     public getAsMapWithDefault(index: number, defaultValue: AnyValueMap): AnyValueMap {
//         let result = this.getAsNullableMap(index);
//     	return result != null ? AnyValueMap.fromValue(result): defaultValue;
//     }

//     /**
//      * Checks if this array contains a value.
//      * The check uses direct comparison between elements and the specified value.
//      * 
//      * @param value     a value to be checked
//      * @returns         true if this array contains the value or false otherwise.
//      */
//     public contains(value: any): boolean {
//         for (let index = 0; index < this.length; index++) {
//             let element = this[index];
            
//             if (value == null && element == null)
//             	return true;
//             if (value == null || element == null)
//             	continue;
//             if (value == element)
//                 return true;
//         }

//         return false;
//     }

//     /**
//      * Checks if this array contains a value.
//      * The check before comparison converts elements and the value to type specified by type code.
//      * 
//      * @param typeCode  a type code that defines a type to convert values before comparison
//      * @param value     a value to be checked
//      * @returns         true if this array contains the value or false otherwise.
//      * 
//      * @see [[TypeConverter.toType]]
//      * @see [[TypeConverter.toNullableType]]
//      */
//     public containsAsType<T>(typeCode: TypeCode, value: any): boolean {
//         let typedValue = TypeConverter.toType<T>(typeCode, value);

//         for (let index = 0; index < this.length; index++) {
//             let thisTypedValue = TypeConverter.toNullableType(typeCode, this[index]);

//             if (typedValue == null && thisTypedValue == null)
//                 return true;
//             if (typedValue == null || thisTypedValue == null)
//             	continue;
//             if (typedValue == thisTypedValue)
//             	return true;
//         }

//         return false;
//     }

//     /** 
//      * Creates a binary clone of this object.
//      * 
//      * @returns a clone of this object.
//      */
//     public clone(): any {
//     	return new AnyValueArray(this);
//     }
    
//     /** 
//      * Gets a string representation of the object.
//      * The result is a comma-separated list of string representations of individual elements as
//      * "value1,value2,value3"
//      * 
//      * @returns a string representation of the object.
//      *
//      * @see [[StringConverter.toString]]
//      */
//     public toString(): string {
//         let builder = '';
//         for (let index = 0; index < this.length; index++) {
//             if (index > 0)
//                 builder += ',';
//             builder += this.getAsStringWithDefault(index, "");
//         }
//         return builder;
//     }
    
//     /**
//      * Creates a new AnyValueArray from a list of values
//      * 
//      * @param values    a list of values to initialize the created AnyValueArray
//      * @returns         a newly created AnyValueArray.
//      */
//     public static fromValues(...values: any[]): AnyValueArray {
//     	return new AnyValueArray(values);
//     }
    
//     /**
//      * Converts specified value into AnyValueArray.
//      * 
//      * @param value     value to be converted
//      * @returns         a newly created AnyValueArray.
//      * 
//      * @see [[ArrayConverter.toNullableArray]]
//      */
//     public static fromValue(value: any): AnyValueArray {
//     	let values = ArrayConverter.toNullableArray(value);
//     	return new AnyValueArray(values);
//     }
    
//     /**
//      * Splits specified string into elements using a separator and assigns 
//      * the elements to a newly created AnyValueArray.
//      * 
//      * @param values            a string value to be split and assigned to AnyValueArray
//      * @param separator         a separator to split the string
//      * @param removeDuplicates  (optional) true to remove duplicated elements
//      * @returns                 a newly created AnyValueArray.
//      */
//     public static fromString(values: string, separator: string, removeDuplicates: boolean = false): AnyValueArray {
//     	let result = new AnyValueArray();
        
//     	if (values == null || values.length == 0)
//         	return result;
        
//         let items = values.split(separator, -1);
//         for (let index = 0; index < items.length; index++) {
//             let item = items[index];
//         	if ((item != null && item.length > 0) || removeDuplicates == false)
//         		result.push(item != null ? new AnyValue(item) : null);
//         }
        
//         return result;
//     }
// }