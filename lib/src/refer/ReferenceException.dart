import '../errors/InternalException.dart';

/**
 * Error when required component dependency cannot be found.
 */
class ReferenceException extends InternalException {
  /**
	 * Creates an error instance and assigns its values.
	 * 
     * @param correlation_id    (optional) a unique transaction id to trace execution through call chain.
	 * @param locator 			the locator to find reference to dependent component.
	 */
  ReferenceException(String correlationId, locator)
      : super(correlationId, "REF_ERROR",
            "Failed to obtain reference to " + locator) {
    this.withDetails("locator", locator);
  }
}
