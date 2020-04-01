import 'package:test/test.dart';

import '../../lib/src/refer/Descriptor.dart';

void main() {
  group('Descriptor', () {
    test('Match', () {
      var descriptor = new Descriptor(
          'pip-dummies', 'controller', 'default', 'default', '1.0');

      // Check match by individual fields
      expect(descriptor.match(new Descriptor(null, null, null, null, null)),
          isTrue);
      expect(
          descriptor.match(
              new Descriptor('pip-dummies', 'controller', null, null, null)),
          isTrue);
      expect(
          descriptor.match(new Descriptor(null, null, 'default', null, null)),
          isTrue);
      expect(descriptor.match(new Descriptor(null, null, null, null, '1.0')),
          isTrue);

      // Check match by individual '*' fields
      expect(
          descriptor.match(new Descriptor('pip-dummies', '*', '*', '*', '*')),
          isTrue);
      expect(descriptor.match(new Descriptor('*', 'controller', '*', '*', '*')),
          isTrue);
      expect(descriptor.match(new Descriptor('*', '*', 'default', '*', '*')),
          isTrue);
      expect(
          descriptor.match(new Descriptor('*', '*', '*', '*', '1.0')), isTrue);

      // Check match by all values
      expect(
          descriptor.match(new Descriptor(
              'pip-dummies', 'controller', 'default', 'default', null)),
          isTrue);
      expect(
          descriptor.match(
              new Descriptor(null, 'controller', 'default', 'default', '1.0')),
          isTrue);
      expect(
          descriptor.match(new Descriptor(
              'pip-dummies', 'controller', 'default', 'default', '1.0')),
          isTrue);

      // Check mismatch by individual fields
      expect(descriptor.match(new Descriptor(null, 'cache', null, null, null)),
          isFalse);
      expect(
          descriptor.match(
              new Descriptor('pip-commons', 'controller', null, null, null)),
          isFalse);
      expect(
          descriptor.match(new Descriptor(null, null, 'special', null, null)),
          isFalse);
      expect(descriptor.match(new Descriptor(null, null, null, null, '2.0')),
          isFalse);
    });

    test('To String', () {
      var descriptor1 = new Descriptor(
          'pip-dummies', 'controller', 'default', 'default', '1.0');
      expect(descriptor1.toString(),
          equals('pip-dummies:controller:default:default:1.0'));

      var descriptor2 = new Descriptor(null, 'controller', null, null, null);
      expect(descriptor2.toString(), '*:controller:*:*:*');
    });

    test('From String', () {
      var descriptor = Descriptor.fromString(null);
      expect(descriptor, isNull);

      descriptor =
          Descriptor.fromString('pip-dummies:controller:default:default:1.0');
      expect(
          descriptor.exactMatch(new Descriptor(
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
