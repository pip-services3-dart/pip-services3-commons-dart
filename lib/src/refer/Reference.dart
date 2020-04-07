import './Descriptor.dart';

/// Contains a reference to a component and locator to find it.
/// It is used by [References] to store registered component references.

class Reference {
  var _locator;
  var _component;

  /// Create a new instance of the reference object and assigns its values.
  ///
  /// - [locator] 		a locator to find the reference.
  /// - [reference] 	a reference to component.

  Reference(locator, component) {
    if (component == null) throw Exception('Component cannot be null');

    _locator = locator;
    _component = component;
  }

  /// Matches locator to this reference locator.
  ///
  /// Descriptors are matched using equal method.
  /// All other locator types are matched using direct comparison.
  ///
  /// - [locator] 	the locator to match.
  /// @return true if locators are matching and false it they don't.
  ///
  /// See [Descriptor]

  bool match(locator) {
    // Locate by direct reference matching
    if (_component == locator) {
      return true;
    } else if (_locator is Descriptor) {
      return _locator.equals(locator);
    } else if (_locator != null) {
      return _locator == locator;
    } else {
      return false;
    }
  }

  /// Gets the stored component reference.
  ///
  /// Return the component's references.

  dynamic getComponent() {
    return _component;
  }

  /// Gets the stored component locator.
  ///
  /// Return the component's locator.

  dynamic getLocator() {
    return _locator;
  }
}
