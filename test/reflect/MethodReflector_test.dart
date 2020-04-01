import 'package:test/test.dart';

import './TestClass.dart';
import '../../lib/src/reflect/MethodReflector.dart';

void main() {
  group('MethodReflector', () {
    test('Get Methods', () {
      var obj = TestClass();
      var methods = MethodReflector.getMethodNames(obj);
      expect(methods.length, equals(4));
    });

    test('Invoke Method', () {
      var obj = TestClass();
      var result = MethodReflector.invokeMethod(obj, "PUBLICMETHOD", [1, 2]);
      expect(result, equals(3));
    });
  });
}
