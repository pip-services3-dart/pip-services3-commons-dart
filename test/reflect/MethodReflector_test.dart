import 'package:pip_services3_commons/src/reflect/MethodReflector.dart';
import 'package:test/test.dart';

import './TestClass.dart';

void main() {
  group('MethodReflector', () {
    test('Get Methods', () {
      var obj = TestClass();
      var methods = MethodReflector.getMethodNames(obj);
      expect(methods.length, equals(4));
    });

    test('Invoke Method', () {
      var obj = TestClass();
      var result = MethodReflector.invokeMethod(obj, 'PUBLICMETHOD', [1, 2]);
      expect(result, equals(3));
    });
  });
}
