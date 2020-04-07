import 'dart:async';

import './IOpenable.dart';

/// Helper class that opens components.
///
/// [IOpenable]

class Opener {
  /// Checks if specified component is opened.
  ///
  /// To be checked components must implement [IOpenable] interface.
  /// If they don't the call to this method returns true.
  ///
  /// - [component] 	the component that is to be checked.
  /// Returns true if component is opened and false otherwise.
  ///
  /// See [IOpenable]

  static bool isOpenOne(component) {
    if (component is IOpenable) {
      return component.isOpen();
    } else {
      return true;
    }
  }

  /// Checks if all components are opened.
  ///
  /// To be checked components must implement [IOpenable] interface.
  /// If they don't the call to this method returns true.
  ///
  /// - [components] 	a list of components that are to be checked.
  /// Returns true if all components are opened and false if at least one component is closed.
  ///
  /// See [isOpenOne]
  /// See [IOpenable]

  static bool isOpen(List components) {
    if (components == null) return true;

    var result = true;
    for (var component in components) {
      result = result && Opener.isOpenOne(component);
    }

    return result;
  }

  /// Opens specific component.
  ///
  /// To be opened components must implement [IOpenable] interface.
  /// If they don't the call to this method has no effect.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// - [component] 		the component that is to be opened.
  /// Return          Future that returns error or null no errors occured.
  ///
  /// See [IOpenable]

  static Future openOne(String correlationId, component) async {
    if (component is IOpenable) await component.open(correlationId);
  }

  /// Opens multiple components.
  ///
  /// To be opened components must implement [IOpenable] interface.
  /// If they don't the call to this method has no effect.
  ///
  /// - [correlationId] 	(optional) transaction id to trace execution through call chain.
  /// - [components] 		the list of components that are to be closed.
  /// Return 			Future that returns error or null no errors occured.
  ///
  /// See [openOne]
  /// See [IOpenable]

  static Future open(String correlationId, List components) async {
    if (components == null) return true;

    for (var component in components) {
      if (component is IOpenable) await component.open(correlationId);
    }
  }
}
