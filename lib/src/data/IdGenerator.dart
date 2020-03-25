// /** @module data */
// /** @hidden */ 
// const uuid = require('uuid');

// // Maps for number <-> hex string conversion
// /** @hidden */ 
// let byteToHex = [];
// for (let i = 0; i < 256; i++) {
//     byteToHex[i] = (i + 0x100).toString(16).substr(1);
// }

// /**
//  * Helper class to generate unique object IDs.
//  * It supports two types of IDs: long and short.
//  * 
//  * Long IDs are string GUIDs. They are globally unique and 32-character long.
//  * 
//  * ShortIDs are just 9-digit random numbers. They are not guaranteed be unique.
//  * 
//  * ### Example ###
//  * 
//  *     IdGenerator.nextLong();      // Possible result: "234ab342c56a2b49c2ab42bf23ff991ac"
//  *     IdGenerator.nextShort();     // Possible result: "23495247"
//  * 
//  */
// export class IdGenerator {
    
//     /**
//      * Generates a random 9-digit random ID (code).
//      * 
//      * Remember: The returned value is not guaranteed to be unique.
//      * 
//      * @returns a generated random 9-digit code
//      */
//     public static nextShort(): string {
//         return Math.ceil(100000000 + Math.random() * 899999999).toString();
//     }

//     private static uuidToHex(buffer) {
//         return   byteToHex[buffer[0]]  + byteToHex[buffer[1]]
//                + byteToHex[buffer[2]]  + byteToHex[buffer[3]] 
//                + byteToHex[buffer[4]]  + byteToHex[buffer[5]] 
//                + byteToHex[buffer[6]]  + byteToHex[buffer[7]] 
//                + byteToHex[buffer[8]]  + byteToHex[buffer[9]] 
//                + byteToHex[buffer[10]] + byteToHex[buffer[11]]
//                + byteToHex[buffer[12]] + byteToHex[buffer[13]]
//                + byteToHex[buffer[14]] + byteToHex[buffer[15]];
//     }

//     /**
//      * Generates a globally unique 32-digit object ID.
//      * The value is a string representation of a GUID value.
//      * 
//      * @returns a generated 32-digit object ID
//      */
//     public static nextLong(): string {
//         var buffer = new Array(16);
//         return IdGenerator.uuidToHex(uuid.v4(null, buffer));
//     }
        
// }
