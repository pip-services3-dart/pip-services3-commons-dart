import 'package:test/test.dart';

import './TestClass.dart';
import '../../lib/src/reflect/RecursiveObjectReader.dart';

void main() {
  group('RecursiveObjectReader', () {

    // test('Has Property', () => {       
    //       let obj = { 
    //           "value1": 123, 
    //           "value2": { 
    //               "value21": 111, 
    //               "value22": 222 
    //           }, 
    //           "value3": [ 444, { "value311": 555 } ] 
    //       };

    //       let has = RecursiveObjectReader.hasProperty(obj, "");
    //       assert.isFalse(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value1");
    //       assert.isTrue(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value2");
    //       assert.isTrue(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value2.value21");
    //       assert.isTrue(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value2.value31");
    //       assert.isFalse(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value2.value21.value211");
    //       assert.isFalse(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "valueA.valueB.valueC");
    //       assert.isFalse(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value3");
    //       assert.isTrue(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value3.0");
    //       assert.isTrue(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value3.0.value311");
    //       assert.isFalse(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value3.1");
    //       assert.isTrue(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value3.1.value311");
    //       assert.isTrue(has);

    //       has = RecursiveObjectReader.hasProperty(obj, "value3.2");
    //       assert.isFalse(has);
    // });

    // test('Get Property', () => {       
    //       let obj = { 
    //           "value1": 123, 
    //           "value2": { 
    //               "value21": 111, 
    //               "value22": 222 
    //           }, 
    //           "value3": [ 444, { "value311": 555 } ] 
    //       };

    //       let value = RecursiveObjectReader.getProperty(obj, "");
    //       assert.isNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "value1");
    //       assert.equal(123, value);

    //       value = RecursiveObjectReader.getProperty(obj, "value2");
    //       assert.isNotNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "value2.value21");
    //       assert.equal(111, value);

    //       value = RecursiveObjectReader.getProperty(obj, "value2.value31");
    //       assert.isNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "value2.value21.value211");
    //       assert.isNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "valueA.valueB.valueC");
    //       assert.isNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "value3");
    //       assert.isNotNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "value3.0");
    //       assert.equal(444, value);

    //       value = RecursiveObjectReader.getProperty(obj, "value3.0.value311");
    //       assert.isNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "value3.1");
    //       assert.isNotNull(value);

    //       value = RecursiveObjectReader.getProperty(obj, "value3.1.value311");
    //       assert.equal(555, value);

    //       value = RecursiveObjectReader.getProperty(obj, "value3.2");
    //       assert.isNull(value);
    // });

    // test('Get Property Names', () => {       
    //       let obj = { 
    //           "value1": 123, 
    //           "value2": { 
    //               "value21": 111, 
    //               "value22": 222 
    //           }, 
    //           "value3": [ 444, { "value311": 555 } ] 
    //       };

    //       let names = RecursiveObjectReader.getPropertyNames(obj);
    //       assert.equal(5, names.length);
    //       assert.isTrue(names.indexOf("value1") >= 0);
    //       assert.isTrue(names.indexOf("value2.value21") >= 0);
    //       assert.isTrue(names.indexOf("value2.value22") >= 0);
    //       assert.isTrue(names.indexOf("value3.0") >= 0);
    //       assert.isTrue(names.indexOf("value3.1.value311") >= 0);
    // });

    // test('Get Properties', () => {       
    //       let obj = { 
    //           "value1": 123, 
    //           "value2": { 
    //               "value21": 111, 
    //               "value22": 222 
    //           }, 
    //           "value3": [ 444, { "value311": 555 } ] 
    //       };

    //       let values = RecursiveObjectReader.getProperties(obj);
    //       //assert.equal(5, values.length);
    //       assert.equal(123, values["value1"]);
    //       assert.equal(111, values["value2.value21"]);
    //       assert.equal(222, values["value2.value22"]);
    //       assert.equal(444, values["value3.0"]);
    //       assert.equal(555, values["value3.1.value311"]);
    // });

  });
}