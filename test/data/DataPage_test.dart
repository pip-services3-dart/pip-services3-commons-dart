import 'package:test/test.dart';
import '../../lib/src/data/DataPage.dart';

void main() {
  group('DataPage', () {
    test('JSON DataPage<Map<String,String>> convert', () {
      var data = <String, String>{};
      data['key1'] = 'value1';
      data['key2'] = 'value2';
      var page = DataPage<Map<String, String>>([data], 1);
      expect('value1', page.data[0]['key1']);
      expect('value2', page.data[0]['key2']);
      expect(1, page.total);

      var json = page.toJson();

      var page2 = DataPage.fromJson(json, (itemsJson) {
        return Map.from(itemsJson).cast<String, String>();
      });
      expect('value1', page2.data[0]['key1']);
      expect('value2', page2.data[0]['key2']);
      expect(1, page.total);
    });

    test('JSON DataPage<int> convert', () {
      var page = DataPage<int>([23, 564, 59], 3);
      expect(23, page.data[0]);
      expect(564, page.data[1]);
      expect(59, page.data[2]);
      expect(3, page.total);

      var json = page.toJson();

      var page2 = DataPage.fromJson(json, (itemsJson) {
        return itemsJson;
      });
      expect(23, page2.data[0]);
      expect(564, page2.data[1]);
      expect(59, page2.data[2]);
      expect(3, page2.total);
    });

    test('JSON DataPage<String> convert', () {
      var page = DataPage<String>(['23', '564', '59'], 3);
      expect('23', page.data[0]);
      expect('564', page.data[1]);
      expect('59', page.data[2]);
      expect(3, page.total);

      var json = page.toJson();

      var page2 = DataPage.fromJson(json, (itemsJson) {
        return itemsJson;
      });
      expect('23', page2.data[0]);
      expect('564', page2.data[1]);
      expect('59', page2.data[2]);
      expect(3, page2.total);
    });
  });
}
