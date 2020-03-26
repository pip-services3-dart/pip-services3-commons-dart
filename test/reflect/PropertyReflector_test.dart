import 'package:test/test.dart';

import './TestClass.dart';
import '../../lib/src/reflect/PropertyReflector.dart';

void main() {
  group('PropertyReflector', () {

    // test('Get Property', () => {       
    //   let obj = new TestClass();

    //   let value = PropertyReflector.getProperty(obj, "privateField");
    //   //assert.isNull(value);
      
    //   value = PropertyReflector.getProperty(obj, "publicField");
    //   assert.equal("ABC", value);
      
    //   value = PropertyReflector.getProperty(obj, "PublicProp");
    //   assert.isNotNull(value);
    // });

    // test('Get Properties', () => {       
    //   let obj = new TestClass();        
    //   let names = PropertyReflector.getPropertyNames(obj);
    //   //assert.equal(2, names.length);
    //   assert.isTrue(names.indexOf("publicField") >= 0);
    //   assert.isTrue(names.indexOf("publicProp") >= 0);
      
    //   let map = PropertyReflector.getProperties(obj);
    //   assert.isObject(map);
    //       assert.equal("ABC", map["publicField"]);
    //   assert.isNotNull(map["publicProp"]);
    // });

  });
}