import '../errors/ConfigException.dart';

/// Descriptor that points to specific object type by it's name
/// and optional library (or module) where this type is defined.
///
/// This class has symmetric implementation across all languages supported
/// by Pip.Services toolkit and used to support dynamic data processing.

class TypeDescriptor {
  final String _name;
  final String? _library;

  /// Creates a new instance of the type descriptor and sets its values.
  ///
  /// - [name] 		a name of the object type.
  /// - [library] 	a library or module where this object type is implemented.

  TypeDescriptor(String name, String? library)
      : _name = name,
        _library = library;

  /// Get the name of the object type.
  ///
  /// Returns the name of the object type.

  String getName() {
    return _name;
  }

  /// Gets the name of the library or module where the object type is defined.
  ///
  /// Returns the name of the library or module.

  String? getLibrary() {
    return _library;
  }

  /// Compares this descriptor to a value.
  /// If the value is also a TypeDescriptor it compares their name and library fields.
  /// Otherwise this method returns false.
  ///
  /// - [value]		a value to compare.
  /// Returns true if value is identical TypeDescriptor and false otherwise.

  bool equals(value) {
    if (value is TypeDescriptor) {
      var otherType = value;
      if (getName() != otherType.getName()) return false;
      if (getLibrary() == null ||
          otherType.getLibrary() == null ||
          getLibrary() == otherType.getLibrary()) return true;
    }

    return false;
  }

  /// Gets a string representation of the object.
  /// The result has format name[,library]
  ///
  /// Returns a string representation of the object.
  ///
  /// See [fromString]

  @override
  String toString() {
    var builder = '' + _name;
    if (_library != null) builder += ',' + _library!;
    return builder.toString();
  }

  /// Parses a string to get descriptor fields and returns them as a Descriptor.
  /// The string must have format name[,library]
  ///
  /// - [value]     a string to parse.
  /// Returns         a newly created Descriptor.
  /// Throws a [ConfigException] if the descriptor string is of a wrong format.
  ///
  /// See [toString]

  static TypeDescriptor? fromString(String? value) {
    if (value == null || value.isEmpty) return null;
    var tokens = value.split(',');
    if (tokens.length == 1) {
      return TypeDescriptor(tokens[0].trim(), null);
    } else if (tokens.length == 2) {
      return TypeDescriptor(tokens[0].trim(), tokens[1].trim());
    } else {
      throw ConfigException(null, 'BAD_DESCRIPTOR',
              'Type descriptor ' + value + ' is in wrong format')
          .withDetails('descriptor', value);
    }
  }
}
