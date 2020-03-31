import './IReferences.dart';
import './IReferenceable.dart';
import './IUnreferenceable.dart';

/**
/// Helper class that sets and unsets references to components.
/// 
/// See [IReferenceable]
/// See [IUnreferenceable]
 */
class Referencer {
  /**
	/// Sets references to specific component.
	/// 
	/// To set references components must implement [IReferenceable] interface.
	/// If they don't the call to this method has no effect.
	/// 
	/// - [references] 	the references to be set.
	/// - [component] 	the component to set references to.
	/// 
	/// See [IReferenceable]
	 */
  static void setReferencesForOne(IReferences references, component) {
    if (component is IReferenceable) component.setReferences(references);
  }

  /**
	/// Sets references to multiple components.
	/// 
	/// To set references components must implement [IReferenceable] interface.
	/// If they don't the call to this method has no effect.
	/// 
	/// - [references] 	the references to be set.
	/// - [components] 	a list of components to set the references to.
	/// 
	/// See [IReferenceable]
	 */
  static void setReferences(IReferences references, List components) {
    for (var component in components)
      Referencer.setReferencesForOne(references, component);
  }

  /**
	/// Unsets references in specific component.
	/// 
	/// To unset references components must implement [IUnreferenceable] interface.
	/// If they don't the call to this method has no effect.
	/// 
	/// - [component] 	the component to unset references.
	/// 
	/// See [IUnreferenceable]
	 */
  static void unsetReferencesForOne(component) {
    if (component is IUnreferenceable) component.unsetReferences();
  }

  /**
	/// Unsets references in multiple components.
	/// 
	/// To unset references components must implement [IUnreferenceable] interface.
	/// If they don't the call to this method has no effect.
	/// 
	/// - [components] 	the list of components, whose references must be cleared.
	/// 
	/// See [IUnreferenceable]
	 */
  static void unsetReferences(List components) {
    for (var component in components)
      Referencer.unsetReferencesForOne(component);
  }
}
