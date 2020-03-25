import 'package:test/test.dart';
import '../../lib/src/data/PagingParams.dart';

void main() {
  group('PagingParams', () {
    test('Create empty PagingParams (regular)', () {
      var paging = new PagingParams();
      expect(null, paging.skip);
      expect(null, paging.take);
      expect(false, paging.total);
    });

    test('Create empty PagingParams (gRPC)', () {
      var paging = new PagingParams(0, 0, false);
      expect(0, paging.skip);
      expect(null, paging.take);
      expect(false, paging.total);
    });

    test('Create PagingParams with set skip/take values', () {
      var paging = new PagingParams(25, 50, false);
      expect(25, paging.skip);
      expect(50, paging.take);
      expect(false, paging.total);
    });

    test('getSkip & getTake', () {
      var paging = new PagingParams(25, 50, false);
      expect(50, paging.getSkip(50));
      expect(25, paging.getSkip(10));
      expect(50, paging.getTake(100));
      expect(25, paging.getTake(25));

      paging = new PagingParams();
      expect(10, paging.getSkip(10));
      expect(10, paging.getTake(10));
    });
  });
}
