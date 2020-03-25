// /** @module config */
// import { ConfigParams } from './ConfigParams';

// /**
//  * A helper class to parameters from "options" configuration section.
//  * 
//  * ### Example ###
//  * 
//  *     let config = ConfigParams.fromTuples(
//  *         ...
//  *         "options.param1", "ABC",
//  *         "options.param2", 123
//  *     );
//  *     
//  *     let options = OptionsResolver.resolve(config); // Result: param1=ABC;param2=123 
//  */
// export class OptionResolver {

//     /**
//      * Resolves an "options" configuration section from component configuration parameters.
//      * 
//      * @param config            configuration parameters
//      * @param configAsDefault   (optional) When set true the method returns the entire parameter set when "options" section is not found. Default: false
//      * @returns                 configuration parameters from "options" section
//      */
//     static resolve(config: ConfigParams, configAsDefault: boolean = false): ConfigParams {
//         var options = config.getSection("options");

//         if (Object.keys(options).length == 0 && configAsDefault) 
//             options = config;

//         return options;
//     }
// }