import 'package:test/test.dart';
import '../../lib/src/data/SortField.dart';
import '../../lib/src/data/SortParams.dart';

void main() {
  group('SortParams', () {
    test('Create and Push', () {
      var sort =  SortParams([ SortField('f1'),  SortField('f2')]);
      sort.add( SortField('f3', false));
      expect(3, sort.length);
    });
  });
}
