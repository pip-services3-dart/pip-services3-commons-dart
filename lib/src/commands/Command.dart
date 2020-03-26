// /** @module commands */
// /** @hidden */
// let _ = require('lodash');

// import { ICommand } from './ICommand';
// import { InvocationException } from '../errors/InvocationException';
// import { Schema } from '../validate/Schema';
// import { Parameters } from '../run/Parameters';
// import { ValidationResult } from '../validate/ValidationResult';

// /**
//  * Concrete implementation of [[ICommand ICommand]] interface. Command allows to call a method
//  * or function using Command pattern.
//  *
//  * ### Example ###
//  *
//  *     let command = new Command("add", null, (correlationId, args, callback) => {
//  *         let param1 = args.getAsFloat("param1");
//  *         let param2 = args.getAsFloat("param2");
//  *         let result = param1 + param2;
//  *         callback(null, result);
//  *     });
//  *
//  *     command.execute(
//  *       "123",
//  *       Parameters.fromTuples(
//  *         "param1", 2,
//  *         "param2", 2
//  *       ),
//  *       (err, result) => {
//  *         if (err) console.error(err);
//  *         else console.log("2 + 2 = " + result);
//  *       }
//  *     );
//  *
//  *     // Console output: 2 + 2 = 4
//  *
//  * @see [[ICommand]]
//  * @see [[CommandSet]]
//  */
// export class Command implements ICommand {
//     private _name: string;
//     private readonly _schema: Schema;
//     private readonly _function: (correlationId: string, args: Parameters, callback: (err: any, result: any) => void) => void;

//     /**
//      * Creates a new command object and assigns it's parameters.
//      *
//      * @param name      the command name.
//      * @param schema    the schema to validate command arguments.
//      * @param func      the function to be executed by this command.
//      */
//     public constructor(name: string, schema: Schema, func: any) {
//         if (!name)
//             throw new Error("Name cannot be null");
//         if (!func)
//             throw new Error("Function cannot be null");

//         this._name = name;
//         this._schema = schema;

//         if (!_.isFunction(func))
//             this._function = func.execute;
//         else
//             this._function = func;

//         if (!_.isFunction(this._function))
//             throw new Error("Function doesn't have function type");
//     }

//     /**
//      * Gets the command name.
//      * @returns the name of this command.
//      */
//     public getName(): string {
//         return this._name;
//     }

//     /**
//      * Executes the command. Before execution it validates [[Parameters args]] using
//      * the defined schema. The command execution intercepts exceptions raised
//      * by the called function and returns them as an error in callback.
//      *
//      * @param correlationId (optional) transaction id to trace execution through call chain.
//      * @param args          the parameters (arguments) to pass to this command for execution.
//      * @param callback      function to be called when command is complete
//      *
//      * @see [[Parameters]]
//      */
//     public execute(correlationId: string, args: Parameters, callback: (err: any, result: any) => void): void {
//         if (this._schema) {
//             try {
//                 this._schema.validateAndThrowException(correlationId, args);
//             } catch (ex) {
//                 callback(ex, null);
//                 return;
//             }
//         }

//         try {
//             this._function(correlationId, args, callback);
//         } catch (ex) {
//             let err = new InvocationException(
//                 correlationId,
//                 "EXEC_FAILED",
//                 "Execution " + this.getName() + " failed: " + ex
//             ).withDetails("command", this.getName()).wrap(ex);

//             callback(err, null);
//         }
//     }

//     /**
//      * Validates the command [[Parameters args]] before execution using the defined schema.
//      *
//      * @param args  the parameters (arguments) to validate using this command's schema.
//      * @returns     an array of ValidationResults or an empty array (if no schema is set).
//      *
//      * @see [[Parameters]]
//      * @see [[ValidationResult]]
//      */
//     public validate(args: Parameters): ValidationResult[] {
//         if (this._schema)
//             return this._schema.validate(args);

//         return [];
//     }
// }
