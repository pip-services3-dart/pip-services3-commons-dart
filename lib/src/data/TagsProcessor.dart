/// Helper class to extract and process search tags from objects.
/// The search tags can be kept individually or embedded as hash tags inside text
/// like 'This text has #hash_tag that can be used for search.'

class TagsProcessor {
  static final _NORMALIZE_REGEX = r'(_|#)+';
  static final _COMPRESS_REGEX = r'( |_|#)+';
  static final _SPLIT_REGEX = r'(,|;)+';
  static final _HASHTAG_REGEX = r'#\w+';

  /// Normalizes a tag by replacing special symbols like '_' and '#' with spaces.
  /// When tags are normalized then can be presented to user in similar shape and form.

  /// - [tag]   the tag to normalize.
  /// Returns      a normalized tag.

  static String normalizeTag(String tag) {
    return tag != null
        ? tag.replaceAll(RegExp(_NORMALIZE_REGEX), ' ').trim()
        : null;
  }

  /// Compress a tag by removing special symbols like spaces, '_' and '#'
  /// and converting the tag to lower case.
  /// When tags are compressed they can be matched in search queries.

  /// - [tag]   the tag to compress.
  /// Returns      a compressed tag.

  static String compressTag(String tag) {
    return tag != null
        ? tag.replaceAll(RegExp(_COMPRESS_REGEX), '').toLowerCase()
        : null;
  }

  /// Compares two tags using their compressed form.

  /// - [tag1]  the first tag.
  /// - [tag2]  the second tag.
  /// Returns      true if the tags are equal and false otherwise.

  static bool equalTags(String tag1, String tag2) {
    if (tag1 == null && tag2 == null) return true;
    if (tag1 == null || tag2 == null) return false;
    return compressTag(tag1) == compressTag(tag2);
  }

  /// Normalizes a list of tags.

  /// - [tags]  the tags to normalize.
  /// Returns      a list with normalized tags.

  static List<String> normalizeTags(List<String> tags) {
    return tags.map((String tag) => normalizeTag(tag)).toList();
  }

  /// Normalizes a comma-separated list of tags.

  /// - tagList  a comma-separated list of tags to normalize.
  /// Returns      a list with normalized tags.

  static List<String> normalizeTagList(String tagList) {
    var tags = tagList.split(RegExp(_SPLIT_REGEX));
    return normalizeTags(tags);
  }

  /// Compresses a list of tags.

  /// - [tags]  the tags to compress.
  /// Returns      a list with normalized tags.

  static List<String> compressTags(List<String> tags) {
    return tags.map((String tag) => compressTag(tag)).toList();
  }

  /// Compresses a comma-separated list of tags.

  /// - [tagList]  a comma-separated list of tags to compress.
  /// Returns      a list with compressed tags.

  static List<String> compressTagList(String tagList) {
    var tags = tagList.split(RegExp(_SPLIT_REGEX));
    return compressTags(tags);
  }

  /// Extracts hash tags from a text.

  /// - [text]    a text that contains hash tags
  /// Returns        a list with extracted and compressed tags.

  static List<String> extractHashTags(String text) {
    var tags = <String>[];

    if (text != '') {
      //var hashTags = text.match(HASHTAG_REGEX);
      var regexp = RegExp(_HASHTAG_REGEX);
      var hashTags = regexp.allMatches(text);
      hashTags.forEach((RegExpMatch match) {
        tags.add(text.substring(match.start, match.end));
      });
      tags = compressTags(tags);
    }

    return tags.toSet().toList(); // uniq
  }

  static String _extractString(field) {
    if (field == null) return '';
    if (field is String) return field;

    var result = '';
    var keys = Map.from(field);
    for (var prop in keys.keys) {
      result += ' ' + _extractString(field[prop]);
    }
    return result;
  }

  /// Extracts hash tags from selected fields in an object.

  /// - [obj]           an object which contains hash tags.
  /// - [searchFields]  a list of fields in the objects where to extract tags
  /// Returns              a list of extracted and compressed tags.

  static List<String> extractHashTagsFromValue(
      dynamic obj, List<String> searchFields) {
    // Todo: Use recursive
    var tags = compressTags(obj['tags']);

    searchFields.forEach((String field) {
      var text = _extractString(obj[field]);

      if (text != '') {
        var regexp = RegExp(_HASHTAG_REGEX);
        var matches = regexp.allMatches(text);
        var hashTags = <String>[];
        matches.forEach((RegExpMatch match) {
          hashTags.add(text.substring(match.start, match.end));
        });
        tags.addAll(compressTags(hashTags));
      }
    });

    return tags.toSet().toList();
  }
}
