import './Reference.dart';
import './IReferences.dart';
import './ReferenceException.dart';

/// The most basic implementation of [IReferences] to store and locate component references.
///
/// See [IReferences]
///
/// ### Example ###
///
///     class MyController implements IReferenceable {
///         IMyPersistence persistence;
///         ...
///         void setReferences(IReferences references) {
///             persistence = references.getOneRequired<IMyPersistence>(
///                  Descriptor('mygroup', 'persistence', '*', '*', '1.0')
///             );
///         }
///         ...
///     }
///
///     var persistence =  MyMongoDbPersistence();
///
///     var controller =  MyController();
///
///     var references = References.fromTuples([
///          Descriptor('mygroup', 'persistence', 'mongodb', 'default', '1.0'), persistence,
///          Descriptor('mygroup', 'controller', 'default', 'default', '1.0'), controller
///     ]);
///     controller.setReferences(references);

class References implements IReferences {
  final _references = <Reference>[];

  /// Creates a new instance of references and initializes it with references.
  ///
  /// - [tuples]    (optional) a list of values where odd elements are locators and the following even elements are component references

  References([List tuples]) {
    if (tuples != null) {
      for (var index = 0; index < tuples.length; index += 2) {
        if (index + 1 >= tuples.length) break;

        put(tuples[index], tuples[index + 1]);
      }
    }
  }

  /// Puts a new reference into this reference map.
  ///
  /// - [locator] 	a locator to find the reference by.
  /// - [component] a component reference to be added.
  @override
  void put(locator, component) {
    if (component == null) throw Exception('Component cannot be null');

    _references.add(Reference(locator, component));
  }

  /// Removes a previously added reference that matches specified locator.
  /// If many references match the locator, it removes only the first one.
  /// When all references shall be removed, use [removeAll] method instead.
  ///
  /// - [locator] 	a locator to remove reference
  /// Returns the removed component reference.
  ///
  /// See [removeAll]

  @override
  dynamic remove(locator) {
    if (locator == null) return null;

    for (var index = _references.length - 1; index >= 0; index--) {
      var reference = _references[index];
      if (reference.match(locator)) {
        _references.removeAt(index);
        return reference.getComponent();
      }
    }

    return null;
  }

  /// Removes all component references that match the specified locator.
  ///
  /// - [locator] 	the locator to remove references by.
  /// Returns a list, containing all removed references.

  @override
  List removeAll(locator) {
    var components = [];

    if (locator == null) return components;

    for (var index = _references.length - 1; index >= 0; index--) {
      var reference = _references[index];
      if (reference.match(locator)) {
        _references.removeAt(index);
        components.add(reference.getComponent());
      }
    }

    return components;
  }

  /// Gets locators for all registered component references in this reference map.
  ///
  /// Returns a list with component locators.
  @override
  List getAllLocators() {
    var locators = [];

    for (var index = 0; index < _references.length; index++) {
      var reference = _references[index];
      locators.add(reference.getLocator());
    }

    return locators;
  }

  /// Gets all component references registered in this reference map.
  ///
  /// Returns a list with component references.

  @override
  List getAll() {
    var components = [];

    for (var index = 0; index < _references.length; index++) {
      var reference = _references[index];
      components.add(reference.getComponent());
    }

    return components;
  }

  /// Gets an optional component reference that matches specified locator.
  ///
  /// - [locator] 	the locator to find references by.
  /// Returns a matching component reference or null if nothing was found.

  @override
  T getOneOptional<T>(locator) {
    try {
      var components = find<T>(locator, false);
      return components.isNotEmpty ? components[0] : null;
    } catch (ex) {
      return null;
    }
  }

  /// Gets a required component reference that matches specified locator.
  ///
  /// - [locator] 	the locator to find a reference by.
  /// Returns a matching component reference.
  /// Throws a [ReferenceException] when no references found.

  @override
  T getOneRequired<T>(locator) {
    var components = find<T>(locator, true);
    return components.isNotEmpty ? components[0] : null;
  }

  /// Gets all component references that match specified locator.
  ///
  /// - [locator] 	the locator to find references by.
  /// Returns a list with matching component references or empty list if nothing was found.

  @override
  List<T> getOptional<T>(locator) {
    try {
      return find<T>(locator, false);
    } catch (ex) {
      return <T>[];
    }
  }

  /// Gets all component references that match specified locator.
  /// At least one component reference must be present.
  /// If it doesn't the method throws an error.
  ///
  /// - [locator] 	the locator to find references by.
  /// Returns a list with matching component references.
  ///
  /// Throws a [ReferenceException] when no references found.

  @override
  List<T> getRequired<T>(locator) {
    return find<T>(locator, true);
  }

  /// Gets all component references that match specified locator.
  ///
  /// - [locator] 	the locator to find a reference by.
  /// - [required] 	forces to raise an exception if no reference is found.
  /// Returns a list with matching component references.
  ///
  /// Throws a [ReferenceException] when required is set to true but no references found.

  @override
  List<T> find<T>(locator, bool required) {
    if (locator == null) throw Exception('Locator cannot be null');

    var components = <T>[];

    // Search all references
    for (var index = _references.length - 1; index >= 0; index--) {
      var reference = _references[index];
      if (reference.match(locator)) {
        var component = reference.getComponent() as T;
        if (component != null) components.add(component);
      }
    }

    if (components.isEmpty && required) {
      throw ReferenceException(null, locator);
    }

    return components;
  }

  /// Creates a new References from a list of key-value pairs called tuples.
  ///
  /// - [tuples]    a list of values where odd elements are locators and the following even elements are component references
  /// Returns         a newly created References.
  ///
  /// See [fromTuplesArray]

  static References fromTuples(List tuples) {
    return References(tuples);
  }
}
