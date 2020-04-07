import 'dart:async';

import './ICleanable.dart';

/// Helper class that cleans stored object state.
///
/// See [ICleanable]

class Cleaner {
  /// Clears state of specific component.
  ///
  /// To be cleaned state components must implement [ICleanable] interface.
  /// If they don't the call to this method has no effect.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// - [component] 		the component that is to be cleaned.
  /// Return  			    Future that returns error or null no errors occured.
  ///
  /// See [ICleanable]

  static Future clearOne(String correlationId, component) async {
    if (component is ICleanable) await component.clear(correlationId);
  }

  /// Clears state of multiple components.
  ///
  /// To be cleaned state components must implement [ICleanable] interface.
  /// If they don't the call to this method has no effect.
  ///
  /// - correlationId 	(optional) transaction id to trace execution through call chain.
  /// - components 		the list of components that are to be cleaned.
  /// Retrun 			  Future that returns error or null no errors occured.
  ///
  /// See [clearOne]
  /// See [ICleanable]

  static Future clear(String correlationId, List components) async {
    if (components == null) return;

    for (var component in components) {
      await Cleaner.clearOne(correlationId, component);
    }
  }
}
