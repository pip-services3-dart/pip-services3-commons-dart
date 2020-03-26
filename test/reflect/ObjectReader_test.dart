import 'package:test/test.dart';

import './TestClass.dart';
import '../../lib/src/reflect/ObjectReader.dart';

void main() {
  group('ObjectReader', () {

    // test('Get Object Property', () => {       
    //   let obj = new TestClass();

    //   let value = ObjectReader.getProperty(obj, "privateField");
    //   //assert.isNull(value);
      
    //   value = ObjectReader.getProperty(obj, "publicField");
    //   assert.equal("ABC", value);
      
    //   value = ObjectReader.getProperty(obj, "PublicProp");
    //   assert.isNotNull(value);
    // });

    // test('Get Map Property', () => {       
    //   let map = {
    //     "key1": 123,
    //     "key2": "ABC"
    //       };

    //   let value = ObjectReader.getProperty(map, "key3");
    //   assert.isNull(value);
      
    //   value = ObjectReader.getProperty(map, "Key1");
    //   assert.equal(123, value);
      
    //   value = ObjectReader.getProperty(map, "KEY2");
    //   assert.equal("ABC", value);
    // });

    // test('Get Array Property', () => {       
    //       let list: any[] = [ 123, "ABC" ];

    //   let value = ObjectReader.getProperty(list, "3");
    //   assert.isNull(value);
      
    //   value = ObjectReader.getProperty(list, "0");
    //   assert.equal(123, value);
      
    //   value = ObjectReader.getProperty(list, "1");
    //   assert.equal("ABC", value);
    // });

    // test('Get Object Properties', () => {       
    //   let obj = new TestClass();
    //   let names = ObjectReader.getPropertyNames(obj);
    //     //assert.equal(2, names.length);
    //   assert.isTrue(names.indexOf("publicField") >= 0);
    //   assert.isTrue(names.indexOf("publicProp") >= 0);
      
    //   let map = ObjectReader.getProperties(obj);
    //   //assert.equals(2, map.length);
    //       assert.equal("ABC", map["publicField"]);
    //   assert.isNotNull(map["publicProp"]);
    // });

    // test('Get Map Properties', () => {       
    //   let map = {
    //     "key1": 123,
    //     "key2": "ABC"
    //       };
    //   let names = ObjectReader.getPropertyNames(map);
    //   assert.equal(2, names.length);
    //   assert.isTrue(names.indexOf("key1") >= 0);
    //   assert.isTrue(names.indexOf("key2") >= 0);
      
    //   let values = ObjectReader.getProperties(map);
    //   //assert.equal(2, values.lemgth);
    //   assert.equal(123, values["key1"]);
    //       assert.equal("ABC", values["key2"]);
    // });

    // test('Get Map Properties', () => {       
    //       let list = [ 123, "ABC" ];
      
    //   let names = ObjectReader.getPropertyNames(list);
    //   assert.equal(2, names.length);
    //   assert.isTrue(names.indexOf("0") >= 0);
    //   assert.isTrue(names.indexOf("1") >= 0);
      
    //   let values = ObjectReader.getProperties(list);
    //   //assert.equal(2, values.lenth);
    //       assert.equal(123, values["0"]);
    //       assert.equal("ABC", values["1"]);
      
    //       let array: any[] = [ 123, "ABC" ];

    //   names = ObjectReader.getPropertyNames(array);
    //   assert.equal(2, names.length);
    //   assert.isTrue(names.indexOf("0") >= 0);
    //   assert.isTrue(names.indexOf("1") >= 0);
      
    //   values = ObjectReader.getProperties(array);
    //   //assert.equal(2, values.length);
    //       assert.equal(123, values["0"]);
    //       assert.equal("ABC", values["1"]);
    // });

  });
}