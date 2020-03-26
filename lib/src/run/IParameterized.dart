/** @module run */
import './Parameters.dart';

/**
 * Interface for components that require execution parameters.
 * 
 * @see [[IConfigurable]]
 */
abstract class IParameterized {
  /**
	 * Sets execution parameters.
	 * 
	 * @param parameters 	execution parameters.
	 */
  void setParameters(Parameters parameters);
}
