// let assert = require('chai').assert;

// import { TagsProcessor } from '../../src/data/TagsProcessor';

// suite('TagsProcessor', ()=> {

//     test('Normalize Tags', () => {
//         let tag = TagsProcessor.normalizeTag("  A_b#c ");
//         assert.equal("A b c", tag);
    
//         let tags = TagsProcessor.normalizeTags(["  A_b#c ", "d__E f"]);
//         assert.lengthOf(tags, 2);
//         assert.equal("A b c", tags[0]);
//         assert.equal("d E f", tags[1]);
    
//         tags = TagsProcessor.normalizeTagList("  A_b#c ,d__E f;;");
//         assert.lengthOf(tags, 3);
//         assert.equal("A b c", tags[0]);
//         assert.equal("d E f", tags[1]);
//     });
    
//     test('Compress Tags', () => {
//         let tag = TagsProcessor.compressTag("  A_b#c ");
//         assert.equal("abc", tag);
    
//         let tags = TagsProcessor.compressTags(["  A_b#c ", "d__E f"]);
//         assert.lengthOf(tags, 2);
//         assert.equal("abc", tags[0]);
//         assert.equal("def", tags[1]);
    
//         tags = TagsProcessor.compressTagList("  A_b#c ,d__E f;;");
//         assert.lengthOf(tags, 3)
//         assert.equal("abc", tags[0]);
//         assert.equal("def", tags[1]);
//     });
    
//     test('Extract Hash Tags', () => {
//         let tags = TagsProcessor.extractHashTags("  #Tag_1  #TAG2#tag3 ");
//         assert.lengthOf(tags, 3);
//         assert.equal("tag1", tags[0]);
//         assert.equal("tag2", tags[1]);
//         assert.equal("tag3", tags[2]);
//     });

//     test('Extract Hash Tags', () => {
//         let tags = TagsProcessor.extractHashTagsFromValue(
//             {
//                 tags: ['Tag 1', 'tag_2', 'TAG3'],
//                 name: 'Text with tag1 #Tag1',
//                 description: 'Text with #tag_2,#tag3-#tag4 and #TAG__5'
//             },
//             'name', 'description'
//         );

//         assert.sameMembers(['tag1','tag2','tag3','tag4','tag5'], tags);
//     });

//     test('Extract Hash Tags from Object', () => {
//         let tags = TagsProcessor.extractHashTagsFromValue(
//             {
//                 tags: ['Tag 1', 'tag_2', 'TAG3'],
//                 name: {
//                     short: 'Just a name',
//                     full: 'Text with tag1 #Tag1'
//                 },
//                 description: {
//                     en: 'Text with #tag_2,#tag4 and #TAG__5',
//                     ru: 'Текст с #tag_2,#tag3 и #TAG__5'
//                 }
//             },
//             'name', 'description'
//         );

//         assert.sameMembers(['tag1','tag2','tag3','tag4','tag5'], tags);
//     });
    
// });