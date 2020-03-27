import './Descriptor.dart';

/**
 * Contains a reference to a component and locator to find it.
 * It is used by [[References]] to store registered component references.
 */
class Reference {
  var _locator;
  var _component;

  /**
	 * Create a new instance of the reference object and assigns its values.
	 * 
	 * - locator 		a locator to find the reference.
	 * - reference 	a reference to component.
	 */
  Reference(locator, component) {
    if (component == null) throw new Exception("Component cannot be null");

    this._locator = locator;
    this._component = component;
  }

  /**
	 * Matches locator to this reference locator.
	 * 
	 * Descriptors are matched using equal method.
	 * All other locator types are matched using direct comparison.
	 * 
	 * - locator 	the locator to match. 
	 * @return true if locators are matching and false it they don't.
	 * 
	 * See [[Descriptor]]
	 */
  bool match(locator) {
    // Locate by direct reference matching
    if (this._component == locator)
      return true;
    // Locate by direct locator matching
    else if (this._locator is Descriptor)
      return this._locator.equals(locator);
    // Locate by direct locator matching
    else if (this._locator != null)
      return this._locator == locator;
    else
      return false;
  }

  /**
	 * Gets the stored component reference.
	 * 
	 * @return the component's references.
	 */
  getComponent() {
    return this._component;
  }

  /**
	 * Gets the stored component locator.
	 * 
	 * @return the component's locator.
	 */
  getLocator() {
    return this._locator;
  }
}
