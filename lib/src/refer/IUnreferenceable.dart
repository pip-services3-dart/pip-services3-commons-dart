/// Interface for components that require explicit clearing of references to dependent components.
///
/// See [IReferences]
/// See [IReferenceable]
///
/// ### Example ###
///
///     class MyController implements IReferenceable, IUnreferenceable {
///        IMyPersistence persistence;
///        ...
///        void  setReferences(IReferences references) {
///            persistence = references.getOneRequired<IMyPersistence>(
///                 Descriptor('mygroup', 'persistence', '*', '*', '1.0')
///            );
///        }
///
///        void unsetReferences() {
///            persistence = null;
///        }
///        ...
///     }

abstract class IUnreferenceable {
  /// Unsets (clears) previously set references to dependent components.

  void unsetReferences();
}
