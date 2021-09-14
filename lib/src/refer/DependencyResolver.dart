import '../convert/StringConverter.dart';
import '../config/ConfigParams.dart';
import '../config/IReconfigurable.dart';
import './IReferenceable.dart';
import './IReferences.dart';
import './ReferenceException.dart';
import './Descriptor.dart';

/// Helper class for resolving component dependencies.
///
/// The resolver is configured to resolve named dependencies by specific locator.
/// During deployment the dependency locator can be changed.
///
/// This mechanism can be used to clarify specific dependency among several alternatives.
/// Typically components are configured to retrieve the first dependency that matches
/// logical group, type and version. But if container contains more than one instance
/// and resolution has to be specific about those instances, they can be given a unique
/// name and dependency resolvers can be reconfigured to retrieve dependencies by their name.
///
/// ### Configuration parameters ###
///
/// dependencies:
/// - [dependency name 1]: Dependency 1 locator (descriptor)
/// - ...
/// - [dependency name N]: Dependency N locator (descriptor)
///
/// ### References ###
///
/// References must match configured dependencies.
///
/// ### Example ###
///
///     class MyComponent implements IConfigurable, IReferenceable {
///         DependencyResolver _dependencyResolver  = new DependencyResolver();
///         IMyPersistence _persistence ;
///         ...
///
///          MyComponent() {
///             _dependencyResolver.put('persistence', new Descriptor('mygroup', 'persistence', '*', '*', '1.0'));
///         }
///
///         configure(ConfigParams config ) {
///             _dependencyResolver.configure(config);
///         }
///
///         setReferences(IReferences references) {
///             _dependencyResolver.setReferences(references);
///             _persistence = _dependencyResolver.getOneRequired<IMyPersistence>('persistence');
///         }
///     }
///
///     // Create mycomponent and set specific dependency out of many
///     var component =  MyComponent();
///     component.configure(ConfigParams.fromTuples([
///         'dependencies.persistence', 'mygroup:persistence:*:persistence2:1.0'
///     // Override default persistence dependency
///     ]));
///     component.setReferences(References.fromTuples([
///          Descriptor('mygroup','persistence','*','persistence1','1.0'),  MyPersistence(),
///          Descriptor('mygroup','persistence','*','persistence2','1.0'),  MyPersistence()
///     // This dependency shall be set
///     ]));
///
/// See [IReferences]

class DependencyResolver implements IReferenceable, IReconfigurable {
  final _dependencies = <String, dynamic>{};
  IReferences? _references;

  /// Creates a new instance of the dependency resolver.
  ///
  /// - [config]		(optional) default configuration where key is dependency name and value is locator (descriptor)
  /// - [references]	(optional) default component references
  ///
  /// See [ConfigParams]
  /// See [configure]
  /// See [IReferences]
  /// See [setReferences]

  DependencyResolver([ConfigParams? config, IReferences? references]) {
    if (config != null) configure(config);
    if (references != null) setReferences(references);
  }

  /// Configures the component with specified parameters.
  ///
  /// - [config] 	configuration parameters to set.
  ///
  /// See [ConfigParams]

  @override
  void configure(ConfigParams config) {
    var dependencies = config.getSection('dependencies');
    var names = dependencies.getKeys();
    for (var index = 0; index < names.length; index++) {
      var name = names[index];
      var locator = dependencies.get(name);
      if (locator == null) continue;

      try {
        var descriptor = Descriptor.fromString(locator);
        if (descriptor != null) {
          _dependencies[name] = descriptor;
        } else {
          _dependencies[name] = locator;
        }
      } catch (ex) {
        _dependencies[name] = locator;
      }
    }
  }

  /// Sets the component references. References must match configured dependencies.
  ///
  /// - [references] 	references to set.

  @override
  void setReferences(IReferences references) {
    _references = references;
  }

  /// Adds a new dependency into this resolver.
  ///
  /// - [name] 		the dependency's name.
  /// - [locator] 	the locator to find the dependency by.

  void put(String name, locator) {
    _dependencies[name] = locator;
  }

  /// Gets a dependency locator by its name.
  ///
  /// - [name] 	the name of the dependency to locate.
  /// Returns the dependency locator or null if locator was not configured.

  dynamic locate(String? name) {
    if (name == null) throw Exception('Dependency name cannot be null');
    if (_references == null) throw Exception('References shall be set');

    return _dependencies[name];
  }

  /// Gets all optional dependencies by their name.
  ///
  /// - [name] 		the dependency name to locate.
  /// Returns a list with found dependencies or empty list of no dependencies was found.

  List<T> getOptional<T>(String name) {
    var locator = locate(name);
    return locator != null ? _references!.getOptional<T>(locator) : [];
  }

  /// Gets all required dependencies by their name.
  /// At least one dependency must be present.
  /// If no dependencies was found it throws a [ReferenceException]
  ///
  /// - [name] 		the dependency name to locate.
  /// Returns a list with found dependencies.
  ///
  /// Throws a [ReferenceException] if no dependencies were found.

  List<T> getRequired<T>(String name) {
    var locator = locate(name);
    if (locator == null) throw ReferenceException(null, name);

    return _references!.getRequired<T>(locator);
  }

  /// Gets one optional dependency by its name.
  ///
  /// - [name] 		the dependency name to locate.
  /// Returns a dependency reference or null of the dependency was not found

  T? getOneOptional<T>(String name) {
    var locator = locate(name);
    return locator != null ? _references!.getOneOptional<T>(locator) : null;
  }

  /// Gets one required dependency by its name.
  /// At least one dependency must present.
  /// If the dependency was found it throws a [ReferenceException]
  ///
  /// - [name] 		the dependency name to locate.
  /// Returns a dependency reference
  ///
  /// Throws a [ReferenceException] if dependency was not found.

  T getOneRequired<T>(String name) {
    var locator = locate(name);
    if (locator == null) throw ReferenceException(null, name);

    return _references!.getOneRequired<T>(locator);
  }

  /// Finds all matching dependencies by their name.
  ///
  /// - [name] 		the dependency name to locate.
  /// - [required] 	true to raise an exception when no dependencies are found.
  /// Returns a list of found dependencies
  ///
  /// Throws a [ReferenceException] of required is true and no dependencies found.

  List<T> find<T>(String name, bool required) {
    var locator = locate(name);
    if (locator == null) {
      if (required) throw ReferenceException(null, name);
      return [];
    }

    return _references!.find<T>(locator, required);
  }

  /// Creates a new DependencyResolver from a list of key-value pairs called tuples
  /// where key is dependency name and value the depedency locator (descriptor).
  ///
  /// - [tuples]    a list of values where odd elements are dependency name and the following even elements are dependency locator (descriptor)
  /// Returns         a newly created DependencyResolver.
  ///
  /// See [fromTuplesArray]

  static DependencyResolver fromTuples(List tuples) {
    var result = DependencyResolver();
    if (tuples.isEmpty) return result;

    for (var index = 0; index < tuples.length; index += 2) {
      if (index + 1 >= tuples.length) break;

      var name = StringConverter.toNullableString(tuples[index]);
      var locator = tuples[index + 1];

      if (name != null) result.put(name, locator);
    }

    return result;
  }
}
