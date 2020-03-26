/** 
 * Types of validation results generated by validation schemas. 
 * 
 * @see [[ValidationResult]]
 */
enum ValidationResultType {
  /** General information (not an error). */
  Information,
  /** Warning about something suspecious. In strict mode is treated as error */
  Warning,
  /** Validation error. */
  Error
}
