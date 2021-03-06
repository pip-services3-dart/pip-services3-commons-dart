import 'package:test/test.dart';

import '../../lib/src/reflect/TypeDescriptor.dart';

void main() {
  group('TypeDescriptor', () {
    test('From String', () {
      var descriptor = TypeDescriptor.fromString(null);
      expect(descriptor, isNull);

      descriptor = TypeDescriptor.fromString('xxx,yyy');
      expect(descriptor.getName(), equals('xxx'));
      expect(descriptor.getLibrary(), equals('yyy'));

      descriptor = TypeDescriptor.fromString('xxx');
      expect(descriptor.getName(), equals('xxx'));
      expect(descriptor.getLibrary(), isNull);

      try {
        descriptor = TypeDescriptor.fromString('xxx,yyy,zzz');
        fail('Wrong descriptor shall raise an exception');
      } catch (ex) {
        // Ok...
      }
    });
  });
}
