import './Parameters.dart';

/**
/// Interface for components that require execution parameters.
/// 
/// See [IConfigurable]
 */
abstract class IParameterized {
  /**
	/// Sets execution parameters.
	/// 
	/// - [parameters] 	execution parameters.
	 */
  void setParameters(Parameters parameters);
}
