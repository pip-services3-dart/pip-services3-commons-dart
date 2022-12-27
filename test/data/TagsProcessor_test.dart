import 'package:pip_services3_commons/src/data/TagsProcessor.dart';
import 'package:test/test.dart';

void main() {
  group('TagsProcessor', () {
    test('Normalize Tags', () {
      var tag = TagsProcessor.normalizeTag('  A_b#c ');
      expect('A b c', tag);

      var tags = TagsProcessor.normalizeTags(['  A_b#c ', 'd__E f']);
      expect(tags.length, 2);
      expect('A b c', tags[0]);
      expect('d E f', tags[1]);

      tags = TagsProcessor.normalizeTagList('  A_b#c ,d__E f;;');
      expect(tags.length, 3);
      expect('A b c', tags[0]);
      expect('d E f', tags[1]);
    });

    test('Compress Tags', () {
      var tag = TagsProcessor.compressTag('  A_b#c ');
      expect('abc', tag);

      var tags = TagsProcessor.compressTags(['  A_b#c ', 'd__E f']);
      expect(tags.length, 2);
      expect('abc', tags[0]);
      expect('def', tags[1]);

      tags = TagsProcessor.compressTagList('  A_b#c ,d__E f;;');
      expect(tags.length, 3);
      expect('abc', tags[0]);
      expect('def', tags[1]);
    });

    test('Extract Hash Tags 1', () {
      var tags = TagsProcessor.extractHashTags('  #Tag_1  #TAG2#tag3 ');
      expect(tags.length, 3);
      expect('tag1', tags[0]);
      expect('tag2', tags[1]);
      expect('tag3', tags[2]);
    });

    test('Extract Hash Tags 2', () {
      var tags = TagsProcessor.extractHashTagsFromValue({
        'tags': ['Tag 1', 'tag_2', 'TAG3'],
        'name': 'Text with tag1 #Tag1',
        'description': 'Text with #tag_2,#tag3-#tag4 and #TAG__5'
      }, [
        'name',
        'description'
      ]);

      expect(['tag1', 'tag2', 'tag3', 'tag4', 'tag5'], unorderedEquals(tags));
    });

    test('Extract Hash Tags from Object', () {
      var tags = TagsProcessor.extractHashTagsFromValue({
        'tags': ['Tag 1', 'tag_2', 'TAG3'],
        'name': {'short': 'Just a name', 'full': 'Text with tag1 #Tag1'},
        'description': {
          'en': 'Text with #tag_2,#tag4 and #TAG__5',
          'ru': 'Текст с #tag_2,#tag3 и #TAG__5'
        }
      }, [
        'name',
        'description'
      ]);

      expect(['tag1', 'tag2', 'tag3', 'tag4', 'tag5'], unorderedEquals(tags));
    });
  });
}
