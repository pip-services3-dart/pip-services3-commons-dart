import 'package:pip_services3_commons/src/reflect/TypeReflector.dart';
import 'package:test/test.dart';

void main() {
  group('TypeReflector', () {
    test('Get Type', () {
      var type =
          TypeReflector.getType('TestClass', './test/reflect/TestClass.dart');
      expect(type, isNotNull);
    });

    test('Create Instance', () {
      var value = TypeReflector.createInstance(
          'TestClass', './test/reflect/TestClass.dart', [123]);
      expect(value, isNotNull);
    });
  });
}
