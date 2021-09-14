import 'package:test/test.dart';

import '../../lib/src/refer/Descriptor.dart';

void main() {
  group('Descriptor', () {
    test('Match', () {
      var descriptor =
          Descriptor('pip-dummies', 'controller', 'default', 'default', '1.0');

      // Check match by individual fields
      expect(
          descriptor.match(Descriptor(null, null, null, null, null)), isTrue);
      expect(
          descriptor
              .match(Descriptor('pip-dummies', 'controller', null, null, null)),
          isTrue);
      expect(descriptor.match(Descriptor(null, null, 'default', null, null)),
          isTrue);
      expect(
          descriptor.match(Descriptor(null, null, null, null, '1.0')), isTrue);

      // Check match by individual '*' fields
      expect(descriptor.match(Descriptor('pip-dummies', '*', '*', '*', '*')),
          isTrue);
      expect(descriptor.match(Descriptor('*', 'controller', '*', '*', '*')),
          isTrue);
      expect(
          descriptor.match(Descriptor('*', '*', 'default', '*', '*')), isTrue);
      expect(descriptor.match(Descriptor('*', '*', '*', '*', '1.0')), isTrue);

      // Check match by all values
      expect(
          descriptor.match(Descriptor(
              'pip-dummies', 'controller', 'default', 'default', null)),
          isTrue);
      expect(
          descriptor.match(
              Descriptor(null, 'controller', 'default', 'default', '1.0')),
          isTrue);
      expect(
          descriptor.match(Descriptor(
              'pip-dummies', 'controller', 'default', 'default', '1.0')),
          isTrue);

      // Check mismatch by individual fields
      expect(descriptor.match(Descriptor(null, 'cache', null, null, null)),
          isFalse);
      expect(
          descriptor
              .match(Descriptor('pip-commons', 'controller', null, null, null)),
          isFalse);
      expect(descriptor.match(Descriptor(null, null, 'special', null, null)),
          isFalse);
      expect(
          descriptor.match(Descriptor(null, null, null, null, '2.0')), isFalse);
    });

    test('To String', () {
      var descriptor1 =
          Descriptor('pip-dummies', 'controller', 'default', 'default', '1.0');
      expect(descriptor1.toString(),
          equals('pip-dummies:controller:default:default:1.0'));

      var descriptor2 = Descriptor(null, 'controller', null, null, null);
      expect(descriptor2.toString(), '*:controller:*:*:*');
    });

    test('From String', () {
      var descriptor = Descriptor.fromString(null);
      expect(descriptor, isNull);

      descriptor =
          Descriptor.fromString('pip-dummies:controller:default:default:1.0');
      expect(
          descriptor!.exactMatch(Descriptor(
              'pip-dummies', 'controller', 'default', 'default', '1.0')),
          isTrue);

      try {
        Descriptor.fromString('xxx');
        fail('Descriptor.fromString shall throw an exception');
      } catch (ex) {
        // Ok...
      }
    });
  });
}
