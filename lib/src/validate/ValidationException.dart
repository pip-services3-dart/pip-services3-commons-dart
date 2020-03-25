// /** @module validate */
// import { ValidationResult } from './ValidationResult';
// import { ValidationResultType } from './ValidationResultType';
// import { BadRequestException } from '../errors/BadRequestException';

// /**
//  * Errors in schema validation.
//  * 
//  * Validation errors are usually generated based in [[ValidationResult]].
//  * If using strict mode, warnings will also raise validation exceptions.
//  * 
//  * @see [[BadRequestException]]
//  * @see [[ValidationResult]]
//  */
// export class ValidationException extends BadRequestException {
//     private static readonly SerialVersionUid: number = -1459801864235223845;

//     /**
//      * Creates a new instance of validation exception and assigns its values.
//      * 
//      * @param category          (optional) a standard error category. Default: Unknown
//      * @param correlation_id    (optional) a unique transaction id to trace execution through call chain.
//      * @param results           (optional) a list of validation results
//      * @param message           (optional) a human-readable description of the error.
//      * 
//      * @see [[ValidationResult]]
//      */
//     public constructor(correlationId: string, message?: string, results?: ValidationResult[]) {
//         super(correlationId, "INVALID_DATA", message || ValidationException.composeMessage(results));

//         if (results)
//             this.withDetails("results", results);
//     }

//     /**
//      * Composes human readable error message based on validation results.
//      * 
//      * @param results   a list of validation results.
//      * @returns a composed error message.
//      * 
//      * @see [[ValidationResult]]
//      */
//     public static composeMessage(results: ValidationResult[]): string {
//         let builder: string = "Validation failed";

//         if (results && results.length > 0) {
//             var first = true;
//             for (var i = 0; i < results.length; i++) {
//                 let result: ValidationResult = results[i];

//                 if (result.getType() == ValidationResultType.Information)
//                     continue;

//                 builder += first ? ": " : ", ";
//                 builder += result.getMessage();
//                 first = false;
//             }
//         }

//         return builder;
//     }

//     /**
//      * Creates a new ValidationException based on errors in validation results.
//      * If validation results have no errors, than null is returned.
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param results           list of validation results that may contain errors
//      * @param strict            true to treat warnings as errors.
//      * @returns a newly created ValidationException or null if no errors in found.
//      * 
//      * @see [[ValidationResult]]
//      */
//     public static fromResults(correlationId: string, results: ValidationResult[], strict: boolean): ValidationException {
//         var hasErrors = false;

//         for (var i = 0; i < results.length; i++) {
//             let result: ValidationResult = results[i];

//             if (result.getType() == ValidationResultType.Error)
//                 hasErrors = true;

//             if (strict && result.getType() == ValidationResultType.Warning)
//                 hasErrors = true;
//         }

//         return hasErrors ? new ValidationException(correlationId, null, results) : null;
//     }

//     /**
//      * Throws ValidationException based on errors in validation results.
//      * If validation results have no errors, than no exception is thrown.
//      * 
//      * @param correlationId     (optional) transaction id to trace execution through call chain.
//      * @param results           list of validation results that may contain errors
//      * @param strict            true to treat warnings as errors.
//      * 
//      * @see [[ValidationResult]]
//      * @see [[ValidationException]]
//      */
//     public static throwExceptionIfNeeded(correlationId: string, results: ValidationResult[], strict: boolean): void {
//         let ex = ValidationException.fromResults(correlationId, results, strict);
//         if (ex) throw ex;
//     }

// }
