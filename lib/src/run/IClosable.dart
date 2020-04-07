import 'dart:async';

/// Interface for components that require explicit closure.
///
/// For components that require opening as well as closing
/// use [IOpenable] interface instead.
///
/// See [IOpenable]
/// See [Closer]
///
/// ### Example ###
///
///     class MyConnector implements ICloseable {
///         dynamic _client = null;
///
///         ... // The _client can be lazy created
///
///         Future close(String correlationId){
///             if (_client != null) {
///                 _client.close();
///                 _client = null;
///             }
///             return  Future.delayed( Duration());
///         }
///     }
///

abstract class IClosable {
  /// Closes component and frees used resources.
  ///
  /// - correlationId 	(optional) transaction id to trace execution through call chain.
  /// Return 			  Future that receives error or null no errors occured.

  Future close(String correlationId);
}
