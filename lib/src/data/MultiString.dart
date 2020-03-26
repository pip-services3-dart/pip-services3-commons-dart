import '../reflect/IValueWrapper.dart';
import '../convert/StringConverter.dart';

/*
 * An object that contains string translations for multiple languages.
 * Language keys use two-varter codes like: 'en', 'sp', 'de', 'ru', 'fr', 'pr'.
 * When translation for specified language does not exists it defaults to English ('en').
 * When English does not exists it falls back to the first defined language.
 * 
 * ### Example ###
 * 
 *     var values = MultiString.fromTuples(
 *         "en", "Hello World!",
 *         "ru", "Привет мир!"
 *     );
 *     
 *     var value1 = values.get('ru'); // Result: "Привет мир!"
 *     var value2 = values.get('pt'); // Result: "Hello World!"
 */
class MultiString implements IValueWrapper {
  var _values = new Map<String, String>();

  /*
     * Creates a new MultiString object and initializes it with values.
     * 
     * @param map    a map with language-text pairs.
     */
  MultiString([map = null]) {
    if (map != null) this.append(map);
  }

  innerValue() {
    return _values;
  }

  factory MultiString.fromJson(Map<String, dynamic> json) {
    return new MultiString(json);
  }

  Map<String, dynamic> toJson() {
    return this._values;
  }

  void fromJson(Map<String, dynamic> json) {
    this._values = null;
    append(json);
  }

  /*
     * Gets a string translation by specified language.
     * When language is not found it defaults to English ('en').
     * When English is not found it takes the first value.
     * 
     * @param language  a language two-symbol code.
     * @returns         a translation for the specified language or default translation.
     */
  String get(String language) {
    // Get specified language
    var value = this._values[language];

    // Default to english
    if (value == null) value = this._values['en'];

    // Default to the first property
    if (value == null) {
      for (var language in this._values.keys) {
        //if (this.hasOwnProperty(language))
        value = this._values[language];
        break;
      }
    }

    return value;
  }

  /* 
     * Gets all languages stored in this MultiString object,
     * 
     * @returns a list with language codes. 
     */
  List<String> getLanguages() {
    var languages = new List<String>();

    for (var key in this._values.keys) {
      languages.add(key);
    }

    return languages;
  }

  /*
     * Puts a new translation for the specified language.
     * 
     * @param language  a language two-symbol code.
     * @param value     a new translation for the specified language.
     */
  put(String language, value) {
    this._values[language] = StringConverter.toNullableString(value);
  }

  /*
     * Removes translation for the specified language.
     * 
     * @param language  a language two-symbol code.
     */
  void remove(String language) {
    this._values.remove(language);
  }

  /*
     * Appends a map with language-translation pairs.
     * 
     * @param map   the map with language-translation pairs.
     */
  void append(map) {
    if (map == null) return;

    if (map is IValueWrapper) map = map.innerValue();

    if (map is Map) {
      for (var key in map.keys) {
        var value = map[key];
        this._values[key] = StringConverter.toNullableString(value);
      }
    }
  }

  /*
     * Clears all translations from this MultiString object.
     */
  void clear() {
    this._values.clear();
  }

  /* 
     * Returns the number of translations stored in this MultiString object.
     *  
     * @returns the number of translations.
     */
  int length() {
    return this._values.length;
  }

  /*
     * Creates a new MultiString object from a value that contains language-translation pairs.
     * 
     * @param value     the value to initialize MultiString.
     * @returns         a MultiString object.
     * 
     * @see [[StringValueMap]]
     */
  static MultiString fromValue(dynamic value) {
    return new MultiString(value);
  }

  /*
     * Creates a new MultiString object from language-translation pairs (tuples).
     * 
     * @param tuples    an array that contains language-translation tuples.
     * @returns         a MultiString Object.
     * 
     * @see [[fromTuplesArray]]
     */
  static MultiString fromTuples(List<dynamic> tuples) {
    return MultiString.fromTuplesArray(tuples);
  }

  /*
     * Creates a new MultiString object from language-translation pairs (tuples) specified as array.
     * 
     * @param tuples    an array that contains language-translation tuples.
     * @returns         a MultiString Object.
     */
  static MultiString fromTuplesArray(List<dynamic> tuples) {
    var result = new MultiString();
    if (tuples == null || tuples.length == 0) return result;

    for (var index = 0; index < tuples.length; index += 2) {
      if (index + 1 >= tuples.length) break;

      var name = StringConverter.toString2(tuples[index]);
      var value = StringConverter.toNullableString(tuples[index + 1]);

      result._values[name] = value;
    }

    return result;
  }
}
