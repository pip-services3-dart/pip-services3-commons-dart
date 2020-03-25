import './IReferences.dart';

/**
 * Interface for components that depends on other components. 
 * 
 * If component requires explicit notification to unset references
 * it shall additionally implement [[IUnreferenceable]] interface.
 * 
 * @see [[IReferences]]
 * @see [[IUnreferenceable]]
 * @see [[Referencer]]
 * 
 * ### Example ###
 * 
 *     class MyController implements IReferenceable {
 *         public _persistence: IMyPersistence;
 *         ...    
 *         public setReferences(references: IReferences): void {
 *             this._persistence = references.getOneRequired<IMyPersistence>(
 *                 new Descriptor("mygroup", "persistence", "*", "*", "1.0")
 *             );
 *         }
 *         ...
 *     }
 */
abstract class IReferenceable {
	/**
	 * Sets references to dependent components.
	 * 
	 * @param references 	references to locate the component dependencies. 
	 * @see [[IReferences]]
	 */
	void setReferences(IReferences references);
}
