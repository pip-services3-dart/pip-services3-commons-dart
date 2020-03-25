// /** @module data */
// /** @hidden */ 
// let _ = require('lodash');

// /**
//  * Helper class to extract and process search tags from objects.
//  * The search tags can be kept individually or embedded as hash tags inside text
//  * like "This text has #hash_tag that can be used for search."
//  */
// export class TagsProcessor {
//     private static NORMALIZE_REGEX = /(_|#)+/g;
//     private static COMPRESS_REGEX = /( |_|#)+/g;
//     private static SPLIT_REGEX = /(,|;)+/;
//     private static HASHTAG_REGEX = /#\w+/g;

//     /**
//      * Normalizes a tag by replacing special symbols like '_' and '#' with spaces.
//      * When tags are normalized then can be presented to user in similar shape and form.
//      *
//      * @param tag   the tag to normalize.
//      * @return      a normalized tag.
//      */
//     public static normalizeTag(tag: string): string {
//         return tag 
//             ? _.trim(tag.replace(this.NORMALIZE_REGEX, ' ')) 
//             : null;
//     }

//     /**
//      * Compress a tag by removing special symbols like spaces, '_' and '#'
//      * and converting the tag to lower case.
//      * When tags are compressed they can be matched in search queries.
//      *
//      * @param tag   the tag to compress.
//      * @return      a compressed tag.
//      */
//     public static compressTag(tag: string): string {
//         return tag
//             ? tag.replace(this.COMPRESS_REGEX, '').toLocaleLowerCase()
//             : null;
//     }

//     /**
//      * Compares two tags using their compressed form.
//      *
//      * @param tag1  the first tag.
//      * @param tag2  the second tag.
//      * @return      true if the tags are equal and false otherwise.
//      */
//     public static equalTags(tag1: string, tag2: string): boolean {
//         if (tag1 == null && tag2 == null)
//             return true;
//         if (tag1 == null || tag2 == null)
//             return false;
//         return TagsProcessor.compressTag(tag1) == TagsProcessor.compressTag(tag2);
//     }

//     /**
//      * Normalizes a list of tags.
//      *
//      * @param tags  the tags to normalize.
//      * @return      a list with normalized tags.
//      */
//     public static normalizeTags(tags: string[]): string[] {
//         return _.map(tags, (tag) => TagsProcessor.normalizeTag(tag));
//     }

//     /**
//      * Normalizes a comma-separated list of tags.
//      *
//      * @param tagList  a comma-separated list of tags to normalize.
//      * @return      a list with normalized tags.
//      */
//     public static normalizeTagList(tagList: string): string[] {
//         let tags = tagList.split(this.SPLIT_REGEX);
//         // Remove separators (JS only)
//         for (let index = 0; index < tags.length - 1; index++)
//            tags.splice(index + 1, 1);
//         return this.normalizeTags(tags);
//     }

//     /**
//      * Compresses a list of tags.
//      *
//      * @param tags  the tags to compress.
//      * @return      a list with normalized tags.
//      */
//     public static compressTags(tags: string[]): string[] {
//         return _.map(tags, (tag) => TagsProcessor.compressTag(tag));
//     }

//     /**
//      * Compresses a comma-separated list of tags.
//      *
//      * @param tagList  a comma-separated list of tags to compress.
//      * @return      a list with compressed tags.
//      */
//     public static compressTagList(tagList: string): string[] {
//         let tags = tagList.split(this.SPLIT_REGEX);
//         // Remove separators (JS only)
//         for (let index = 0; index < tags.length - 1; index++)
//            tags.splice(index + 1, 1);
//         return this.compressTags(tags);
//     }

//     /**
//      * Extracts hash tags from a text.
//      *
//      * @param text    a text that contains hash tags
//      * @return        a list with extracted and compressed tags.
//      */
//     public static extractHashTags(text: string): string[] {
//         let tags: string[];

//         if (text != '') {
//             let hashTags = text.match(TagsProcessor.HASHTAG_REGEX);
//             tags = TagsProcessor.compressTags(hashTags);
//         }

//         return _.uniq(tags);
//     }

//     private static extractString(field: any): string {
//         if (field == null) return '';
//         if (_.isString(field)) return field;
//         if (!_.isObject(field)) return '';
        
//         let result = '';
//         for (let prop in field) {
//             result += ' ' + TagsProcessor.extractString(field[prop]);
//         }
//         return result;
//     }

//     /**
//      * Extracts hash tags from selected fields in an object.
//      *
//      * @param obj           an object which contains hash tags.
//      * @param searchFields  a list of fields in the objects where to extract tags
//      * @return              a list of extracted and compressed tags.
//      */
//     public static extractHashTagsFromValue(obj: any, ...searchFields: string[]): string[] {
//         // Todo: Use recursive
//         let tags = TagsProcessor.compressTags(obj.tags);

//         _.each(searchFields, (field) => {
//             let text = TagsProcessor.extractString(obj[field]);

//             if (text != '') {
//                 let hashTags = text.match(TagsProcessor.HASHTAG_REGEX);
//                 tags = tags.concat(TagsProcessor.compressTags(hashTags));
//             }
//         });

//         return _.uniq(tags);
//     }
// }
