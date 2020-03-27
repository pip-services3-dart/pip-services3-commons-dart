/**
 * Interface for components that require explicit clearing of references to dependent components.
 * 
 * See [[IReferences]]
 * See [[IReferenceable]]
 * 
 * ### Example ###
 * 
 *     class MyController implements IReferenceable, IUnreferenceable {
 *        public _persistence: IMyPersistence;
 *        ...    
 *        public setReferences(references: IReferences): void {
 *            this._persistence = references.getOneRequired<IMyPersistence>(
 *                new Descriptor("mygroup", "persistence", "*", "*", "1.0")
 *            );
 *        }
 *     
 *        public unsetReferences(): void {
 *            this._persistence = null;
 *        }
 *        ...
 *     }
 */
abstract class IUnreferenceable {
  /**
	 * Unsets (clears) previously set references to dependent components. 
	 */
  void unsetReferences();
}
