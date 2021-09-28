import 'package:pip_services3_commons/src/config/config.dart';
import 'package:test/test.dart';

void main() {
  group('NameResolver', () {
    test('Resolve Name', () {
      var config = ConfigParams.fromTuples(['id', 'ABC']);
      var name = NameResolver.resolve(config);
      expect(name, equals('ABC'));

      config = ConfigParams.fromTuples(['name', 'ABC']);
      name = NameResolver.resolve(config);
      expect(name, equals('ABC'));
    });

    test('Resolve Empty Name', () {
      var config = ConfigParams.fromTuples([]);
      var name = NameResolver.resolve(config);
      expect(name, isNull);
    });
  });
}
