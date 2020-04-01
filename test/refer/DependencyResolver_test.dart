import 'package:test/test.dart';

import '../../lib/src/refer/References.dart';
import '../../lib/src/refer/DependencyResolver.dart';
import '../../lib/src/refer/Descriptor.dart';
import '../../lib/src/config/ConfigParams.dart';

void main() {
  group('DependencyResolver', () {
    test('Resolve depedencies', () {
      var ref1 = {};
      var ref2 = {};
      var refs = References.fromTuples([
        'Reference1',
        ref1,
        Descriptor(
            'pip-services-commons', 'reference', 'object', 'ref2', '1.0'),
        ref2
      ]);

      var resolver = DependencyResolver.fromTuples([
        'ref1',
        'Reference1',
        'ref2',
        Descriptor('pip-services-commons', 'reference', '*', '*', '*')
      ]);
      resolver.setReferences(refs);

      expect(resolver.getOneRequired('ref1'), equals(ref1));
      expect(resolver.getOneRequired('ref2'), equals(ref2));
      expect(resolver.getOneOptional('ref3'), isNull);
    });

    test('Configure depedencies', () {
      var ref1 = {};
      var ref2 = {};
      var refs = References.fromTuples([
        'Reference1',
        ref1,
        Descriptor(
            'pip-services-commons', 'reference', 'object', 'ref2', '1.0'),
        ref2
      ]);

      var config = ConfigParams.fromTuples([
        'dependencies.ref1',
        'Reference1',
        'dependencies.ref2',
        'pip-services-commons:reference:*:*:*',
        'dependencies.ref3',
        null
      ]);

      var resolver = DependencyResolver(config);
      resolver.setReferences(refs);

      expect(resolver.getOneRequired('ref1'), equals(ref1));
      expect(resolver.getOneRequired('ref2'), equals(ref2));
      expect(resolver.getOneOptional('ref3'), isNull);
    });
  });
}
