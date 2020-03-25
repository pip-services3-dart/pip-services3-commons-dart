// /** @module refer */
// import { IReferences } from './IReferences';

// /**
//  * Interface for components that depends on other components. 
//  * 
//  * If component requires explicit notification to unset references
//  * it shall additionally implement [[IUnreferenceable]] interface.
//  * 
//  * @see [[IReferences]]
//  * @see [[IUnreferenceable]]
//  * @see [[Referencer]]
//  * 
//  * ### Example ###
//  * 
//  *     export class MyController implements IReferenceable {
//  *         public _persistence: IMyPersistence;
//  *         ...    
//  *         public setReferences(references: IReferences): void {
//  *             this._persistence = references.getOneRequired<IMyPersistence>(
//  *                 new Descriptor("mygroup", "persistence", "*", "*", "1.0")
//  *             );
//  *         }
//  *         ...
//  *     }
//  */
// export interface IReferenceable {
// 	/**
// 	 * Sets references to dependent components.
// 	 * 
// 	 * @param references 	references to locate the component dependencies. 
// 	 * @see [[IReferences]]
// 	 */
// 	setReferences(references: IReferences): void;
// }
