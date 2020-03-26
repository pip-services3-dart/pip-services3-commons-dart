/*
 * Helper class to extract and process search tags from objects.
 * The search tags can be kept individually or embedded as hash tags inside text
 * like "This text has #hash_tag that can be used for search."
 */
class TagsProcessor {
  static final _NORMALIZE_REGEX = r"(_|#)+"; //"/(_|#)+/g"
  static final _COMPRESS_REGEX = r"( |_|#)+"; //"/( |_|#)+/g"
  static final _SPLIT_REGEX = r"(,|;)+";

  ///(,|;)+/
  static final _HASHTAG_REGEX = r"#\w+";

  ///#\w+/g

  /*
     * Normalizes a tag by replacing special symbols like '_' and '#' with spaces.
     * When tags are normalized then can be presented to user in similar shape and form.
     *
     * @param tag   the tag to normalize.
     * @return      a normalized tag.
     */
  static String normalizeTag(String tag) {
    return tag != null
        ? tag.replaceAll(new RegExp(TagsProcessor._NORMALIZE_REGEX), ' ').trim()
        : null;
  }

  /*
     * Compress a tag by removing special symbols like spaces, '_' and '#'
     * and converting the tag to lower case.
     * When tags are compressed they can be matched in search queries.
     *
     * @param tag   the tag to compress.
     * @return      a compressed tag.
     */
  static String compressTag(String tag) {
    return tag != null
        ? tag
            .replaceAll(new RegExp(TagsProcessor._COMPRESS_REGEX), '')
            .toLowerCase()
        : null;
  }

  /*
     * Compares two tags using their compressed form.
     *
     * @param tag1  the first tag.
     * @param tag2  the second tag.
     * @return      true if the tags are equal and false otherwise.
     */
  static bool equalTags(String tag1, String tag2) {
    if (tag1 == null && tag2 == null) return true;
    if (tag1 == null || tag2 == null) return false;
    return TagsProcessor.compressTag(tag1) == TagsProcessor.compressTag(tag2);
  }

  /*
     * Normalizes a list of tags.
     *
     * @param tags  the tags to normalize.
     * @return      a list with normalized tags.
     */
  static List<String> normalizeTags(List<String> tags) {
    return tags.map((String tag) => TagsProcessor.normalizeTag(tag)).toList();
  }

  /*
     * Normalizes a comma-separated list of tags.
     *
     * @param tagList  a comma-separated list of tags to normalize.
     * @return      a list with normalized tags.
     */
  static List<String> normalizeTagList(String tagList) {
    var tags = tagList.split(new RegExp(TagsProcessor._SPLIT_REGEX));
    // Remove separators (JS only)
    // for (var index = 0; index < tags.length - 1; index++)
    //    tags.splice(index + 1, 1);
    return TagsProcessor.normalizeTags(tags);
  }

  /*
     * Compresses a list of tags.
     *
     * @param tags  the tags to compress.
     * @return      a list with normalized tags.
     */
  static List<String> compressTags(List<String> tags) {
    return tags.map((String tag) => TagsProcessor.compressTag(tag)).toList();
  }

  /*
     * Compresses a comma-separated list of tags.
     *
     * @param tagList  a comma-separated list of tags to compress.
     * @return      a list with compressed tags.
     */
  static List<String> compressTagList(String tagList) {
    var tags = tagList.split(new RegExp(TagsProcessor._SPLIT_REGEX));
    // // Remove separators (JS only)
    // for (let index = 0; index < tags.length - 1; index++)
    //    tags.splice(index + 1, 1);
    return TagsProcessor.compressTags(tags);
  }

  /*
     * Extracts hash tags from a text.
     *
     * @param text    a text that contains hash tags
     * @return        a list with extracted and compressed tags.
     */
  static List<String> extractHashTags(String text) {
    var tags = new List<String>();

    if (text != '') {
      //var hashTags = text.match(TagsProcessor.HASHTAG_REGEX);
      var regexp = new RegExp(TagsProcessor._HASHTAG_REGEX);
      var hashTags = regexp.allMatches(text);
      hashTags.forEach((RegExpMatch match) {
        tags.add(text.substring(match.start, match.end));
      });
      tags = TagsProcessor.compressTags(tags);
    }

    return tags.toSet().toList(); // uniq
  }

  static String _extractString(dynamic field) {
    if (field == null) return '';
    if (field is String) return field;
    if (!(field is Object)) return '';

    var result = '';
    var keys = Map.from(field);
    for (var prop in keys.keys) {
      result += ' ' + TagsProcessor._extractString(field[prop]);
    }
    return result;
  }

  /*
     * Extracts hash tags from selected fields in an object.
     *
     * @param obj           an object which contains hash tags.
     * @param searchFields  a list of fields in the objects where to extract tags
     * @return              a list of extracted and compressed tags.
     */
  static List<String> extractHashTagsFromValue(
      dynamic obj, List<String> searchFields) {
    //...searchFields: string[]
    // Todo: Use recursive
    var tags = TagsProcessor.compressTags(obj['tags']);

    searchFields.forEach((String field) {
      var text = TagsProcessor._extractString(obj[field]);

      if (text != '') {
        var regexp = new RegExp(TagsProcessor._HASHTAG_REGEX);
        var matches = regexp.allMatches(text);
        var hashTags = new List<String>();
        matches.forEach((RegExpMatch match) {
          hashTags.add(text.substring(match.start, match.end));
        });
        tags.addAll(TagsProcessor.compressTags(hashTags));
      }
    });

    return tags.toSet().toList();
  }
}
