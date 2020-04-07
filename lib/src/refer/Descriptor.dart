import '../errors/ConfigException.dart';

/// Locator type that most often used in PipServices toolkit.
/// It locates components using several fields:
/// - Group: a package or just named group of components like 'pip-services'
/// - Type: logical component type that defines it's contract like 'persistence'
/// - Kind: physical implementation type like 'mongodb'
/// - Name: unique component name like 'default'
/// - Version: version of the component contract like '1.0'
///
/// The locator matching can be done by all or only few selected fields.
/// The fields that shall be excluded from the matching must be set to <code>'*'</code> or <code>null</code>.
/// That approach allows to implement many interesting scenarios. For instance:
/// - Locate all loggers (match by type and version)
/// - Locate persistence components for a microservice (match by group and type)
/// - Locate specific component by its name (match by name)
///
/// ### Example ###
///
///     var locator1 =  Descriptor('mygroup', 'connector', 'aws', 'default', '1.0');
///     var locator2 = Descriptor.fromString('mygroup:connector:*:*:1.0');
///
///     locator1.match(locator2);		// Result: true
///     locator1.equal(locator2);		// Result: true
///     locator1.exactMatch(locator2);	// Result: false

class Descriptor {
  String _group;
  String _type;
  String _kind;
  String _name;
  String _version;

  /// Creates a new instance of the descriptor.
  ///
  /// - [group] 	a logical component group
  /// - [type] 		a logical component type or contract
  /// - [kind] 		a component implementation type
  /// - [name]		a unique component name
  /// - [version] 	a component implementation version

  Descriptor(
      String group, String type, String kind, String name, String version) {
    if ('*' == group) group = null;
    if ('*' == type) type = null;
    if ('*' == kind) kind = null;
    if ('*' == name) name = null;
    if ('*' == version) version = null;

    _group = group;
    _type = type;
    _kind = kind;
    _name = name;
    _version = version;
  }

  /// Gets the component's logical group.
  ///
  /// Returns the component's logical group

  String getGroup() {
    return _group;
  }

  /// Gets the component's logical type.
  ///
  /// Returns the component's logical type.

  String getType() {
    return _type;
  }

  /// Gets the component's implementation type.
  ///
  /// Returns the component's implementation type.

  String getKind() {
    return _kind;
  }

  /// Gets the unique component's name.
  ///
  /// Returns the unique component's name.

  String getName() {
    return _name;
  }

  /// Gets the component's implementation version.
  ///
  /// Returns the component's implementation version.

  String getVersion() {
    return _version;
  }

  bool _matchField(String field1, String field2) {
    return field1 == null || field2 == null || field1 == field2;
  }

  /// Partially matches this descriptor to another descriptor.
  /// Fields that contain '*' or null are excluded from the match.
  ///
  /// - [descriptor] 	the descriptor to match this one against.
  /// Returns true if descriptors match and false otherwise
  ///
  /// See [exactMatch]

  bool match(Descriptor descriptor) {
    return _matchField(_group, descriptor.getGroup()) &&
        _matchField(_type, descriptor.getType()) &&
        _matchField(_kind, descriptor.getKind()) &&
        _matchField(_name, descriptor.getName()) &&
        _matchField(_version, descriptor.getVersion());
  }

  bool _exactMatchField(String field1, String field2) {
    if (field1 == null && field2 == null) return true;
    if (field1 == null || field2 == null) return false;
    return field1 == field2;
  }

  /// Matches this descriptor to another descriptor by all fields.
  /// No exceptions are made.
  ///
  /// - [descriptor] 	the descriptor to match this one against.
  /// Returns true if descriptors match and false otherwise.
  ///
  /// See [match]

  bool exactMatch(Descriptor descriptor) {
    return _exactMatchField(_group, descriptor.getGroup()) &&
        _exactMatchField(_type, descriptor.getType()) &&
        _exactMatchField(_kind, descriptor.getKind()) &&
        _exactMatchField(_name, descriptor.getName()) &&
        _exactMatchField(_version, descriptor.getVersion());
  }

  /// Checks whether all descriptor fields are set.
  /// If descriptor has at least one '*' or null field it is considered 'incomplete',
  ///
  /// Returns true if all descriptor fields are defined and false otherwise.

  bool isComplete() {
    return _group != null &&
        _type != null &&
        _kind != null &&
        _name != null &&
        _version != null;
  }

  /// Compares this descriptor to a value.
  /// If value is a Descriptor it tries to match them,
  /// otherwise the method returns false.
  ///
  /// - [value] 	the value to match against this descriptor.
  /// Returns true if the value is matching descriptor and false otherwise.
  ///
  /// See [match]

  bool equals(value) {
    if (value is Descriptor) return match(value);
    return false;
  }

  @override
  bool operator ==(value) {
    return equals(value);
  }

  /// Gets a string representation of the object.
  /// The result is a colon-separated list of descriptor fields as
  /// 'mygroup:connector:aws:default:1.0'
  ///
  /// Returns a string representation of the object.

  @override
  String toString() {
    return (_group ?? '*') +
        ':' +
        (_type ?? '*') +
        ':' +
        (_kind ?? '*') +
        ':' +
        (_name ?? '*') +
        ':' +
        (_version ?? '*');
  }

  /// Parses colon-separated list of descriptor fields and returns them as a Descriptor.
  ///
  /// - [value]      colon-separated descriptor fields to initialize Descriptor.
  /// Returns         a newly created Descriptor.
  /// @throws a [ConfigException] if the descriptor string is of a wrong format.

  static Descriptor fromString(String value) {
    if (value == null || value.isEmpty) return null;

    var tokens = value.split(':');
    if (tokens.length != 5) {
      throw ConfigException(null, 'BAD_DESCRIPTOR',
              'Descriptor ' + value + ' is in wrong format')
          .withDetails('descriptor', value);
    }

    return Descriptor(tokens[0].trim(), tokens[1].trim(), tokens[2].trim(),
        tokens[3].trim(), tokens[4].trim());
  }
}
