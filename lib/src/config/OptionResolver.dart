import './ConfigParams.dart';

/// A helper class to parameters from 'options' configuration section.
///
/// ### Example ###
///
///     var config = ConfigParams.fromTuples([
///         ...
///         'options.param1', 'ABC',
///         'options.param2', 123
///     ]);
///
///     var options = OptionsResolver.resolve(config); // Result: param1=ABC;param2=123

class OptionResolver {
  /// Resolves an 'options' configuration section from component configuration parameters.
  ///
  /// - [config]            configuration parameters
  /// - [configAsDefault]   (optional) When set true the method returns the entire parameter set when 'options' section is not found. Default: false
  /// Returns                 configuration parameters from 'options' section

  static ConfigParams resolve(ConfigParams config,
      [bool configAsDefault = false]) {
    var options = config.getSection('options');

    if (options.isEmpty && configAsDefault) options = config;

    return options;
  }
}
