/**
 * Interface for components that require explicit clearing of references to dependent components.
 * 
 * See [IReferences]
 * See [IReferenceable]
 * 
 * ### Example ###
 * 
 *     class MyController implements IReferenceable, IUnreferenceable {
 *        IMyPersistence persistence;
 *        ...    
 *        void  setReferences(IReferences references) {
 *            this.persistence = references.getOneRequired<IMyPersistence>(
 *                new Descriptor("mygroup", "persistence", "*", "*", "1.0")
 *            );
 *        }
 *     
 *        void unsetReferences() {
 *            this.persistence = null;
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
