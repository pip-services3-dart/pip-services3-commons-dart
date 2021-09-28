import 'package:pip_services3_commons/src/data/data.dart';
import 'package:test/test.dart';

void main() {
  group('SortParams', () {
    test('Create and Push', () {
      var sort = SortParams([SortField('f1'), SortField('f2')]);
      sort.add(SortField('f3', false));
      expect(3, sort.length);
    });
  });
}
