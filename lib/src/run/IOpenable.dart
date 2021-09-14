import 'dart:async';

import './IClosable.dart';

/// Interface for components that require explicit opening and closing.
///
/// For components that perform opening on demand consider using
/// [ICloseable] interface instead.
///
/// See [IOpenable]
/// See [Opener]
///
/// ### Example ###
///
///     class MyPersistence implements IOpenable {
///         dynamic _client;
///         ...
///         bool isOpen() {
///             return _client != null;
///         }
///
///         Future open(String correlationId) {
///             if (isOpen()) {
///                 return Future(Duration(), (){
///
///                  })
///             }
///             ...
///         }
///
///         Future close(String correlationId) async {
///             if (_client != null) {
///                 result = await _client.close();
///                 _client = null;
///                Future(Duration(), (){ return result})
///             }
///         }
///
///         ...
///     }

abstract class IOpenable implements IClosable {
  /// Checks if the component is opened.
  ///
  /// Returns true if the component has been opened and false otherwise.

  bool isOpen();

  /// Opens the component.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// Return 			    Future that receives error or null no errors occured.

  Future open(String? correlationId);
}
