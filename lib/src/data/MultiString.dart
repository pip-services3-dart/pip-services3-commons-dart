// /** @module data */

// import { StringConverter } from '../convert/StringConverter';

// /**
//  * An object that contains string translations for multiple languages.
//  * Language keys use two-letter codes like: 'en', 'sp', 'de', 'ru', 'fr', 'pr'.
//  * When translation for specified language does not exists it defaults to English ('en').
//  * When English does not exists it falls back to the first defined language.
//  * 
//  * ### Example ###
//  * 
//  *     let values = MultiString.fromTuples(
//  *         "en", "Hello World!",
//  *         "ru", "Привет мир!"
//  *     );
//  *     
//  *     let value1 = values.get('ru'); // Result: "Привет мир!"
//  *     let value2 = values.get('pt'); // Result: "Hello World!"
//  */
// export class MultiString {
//     /**
//      * Creates a new MultiString object and initializes it with values.
//      * 
//      * @param map    a map with language-text pairs.
//      */
//     public constructor(map: any = null) {
//         if (map != null)
//     	    this.append(map);
//     }

//     /**
//      * Gets a string translation by specified language.
//      * When language is not found it defaults to English ('en').
//      * When English is not found it takes the first value.
//      * 
//      * @param language  a language two-symbol code.
//      * @returns         a translation for the specified language or default translation.
//      */
//     public get(language: string): string {
//         // Get specified language
//         let value = this[language];

//         // Default to english
//         if (value == null)
//             value = this['en'];
        
//         // Default to the first property
//         if (value == null) {
//             for (let language in this) {
//                 if (this.hasOwnProperty(language))
//                 value = this[language];
//                 break;
//             }
//         }

//         return value;
//     }

//     /** 
//      * Gets all languages stored in this MultiString object,
//      * 
//      * @returns a list with language codes. 
//      */
// 	public getLanguages(): string[] {
//         let languages: string[] = [];
		
// 		for (let key in this) {
//             if (this.hasOwnProperty(key)) {
//                 languages.push(key);
//             }
//         }

//         return languages;
//     }            
    
//     /**
//      * Puts a new translation for the specified language.
//      * 
//      * @param language  a language two-symbol code.
//      * @param value     a new translation for the specified language.
//      */
// 	public put(language: string, value: any): any {
//         this[language] = StringConverter.toNullableString(value);
//     }

//     /**
//      * Removes translation for the specified language.
//      * 
//      * @param language  a language two-symbol code.
//      */
//     public remove(language: string): void {
//         delete this[language];
//     }
    
//     /**
//      * Appends a map with language-translation pairs.
//      * 
//      * @param map   the map with language-translation pairs.
//      */
//     public append(map: any): void {
//     	if (map == null) return;
    	
// 		for (let key in map) {
//             let value = map[key];
//             if (map.hasOwnProperty(key))
//                 this[key] = StringConverter.toNullableString(value);
// 		}
//     }

//     /**
//      * Clears all translations from this MultiString object.
//      */
//     public clear(): any {
//     	for (let key in this) {
//             let value = this[key];
//             if (this.hasOwnProperty(key))
//     		    delete this[key];
//     	}
//     }

//     /** 
//      * Returns the number of translations stored in this MultiString object.
//      *  
//      * @returns the number of translations.
//      */
//     public length(): number {
//         let count: number = 0;
//         for (let key in this) {
//             if (this.hasOwnProperty(key))
//                 count ++;
//         }        
//         return count;
//     } 
        
//     /**
//      * Creates a new MultiString object from a value that contains language-translation pairs.
//      * 
//      * @param value     the value to initialize MultiString.
//      * @returns         a MultiString object.
//      * 
//      * @see [[StringValueMap]]
//      */
//     public static fromValue(value: any): MultiString {
//         return new MultiString(value);
//     }

//     /**
//      * Creates a new MultiString object from language-translation pairs (tuples).
//      * 
//      * @param tuples    an array that contains language-translation tuples.
//      * @returns         a MultiString Object.
//      * 
//      * @see [[fromTuplesArray]]
//      */
//     public static fromTuples(...tuples: any[]): MultiString {
//         return MultiString.fromTuplesArray(tuples);
//     }
    
//     /**
//      * Creates a new MultiString object from language-translation pairs (tuples) specified as array.
//      * 
//      * @param tuples    an array that contains language-translation tuples.
//      * @returns         a MultiString Object.
//      */
//     public static fromTuplesArray(tuples: any[]): MultiString {
//     	let result = new MultiString();
//     	if (tuples == null || tuples.length == 0)
//     		return result;
    	
//         for (let index = 0; index < tuples.length; index += 2) {
//             if (index + 1 >= tuples.length) break;

//             let name = StringConverter.toString(tuples[index]);
//             let value = StringConverter.toNullableString(tuples[index + 1]);

//             result[name] = value;
//         }
        
//     	return result;
//     }    
// }