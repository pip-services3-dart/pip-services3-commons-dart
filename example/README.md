# Examples for Commons
It provides portable abstractions and patterns that can be used to implement non-trivial business logic in applications and services.

This framework's key difference is its portable implementation across a variety of different languages. 
It currently supports Java, .NET, Python, Node.js, Dart, and Golang. The code provides a reasonably thin abstraction layer over most fundamental functions and delivers symmetric implementation that can be quickly ported between different platforms.

The framework's functionality is decomposed into several packages:

- **Commands** - commanding and eventing patterns
* Example:

```dart

var command = Command('name', null, CommandExec());
var map = {};
map[8] = 'title 8';
map[11] = 'title 11';
var param = Parameters(map);
var result = await command.execute('a', param); // Result 123

```

- **Config** - configuration framework
* Example:

```dart
var config = ConfigParams.fromTuples([
       'Section1.Key1',
       'Value1',
       'Section1.Key2',
       'Value2',
       'Section1.Key3',
       'Value3'
     ]);

config.get('Section1.Key1'); // 'Value1'
config.get('Section1.Key2'); // 'Value2'
config.get('Section1.Key3'); // 'Value3'
config.get('Section1.Key4'); //  null
```

- **Convert** - soft value converters
* Example:

```dart
StringConverter.toNullableString(null);     // null);
StringConverter.toNullableString([1, 2, 3]);// '1,2,3';
StringConverter.toString2('xyz');           // 'xyz'
StringConverter.toString2(123);             // '123'
StringConverter.toString2(true);            // 'true'
```

- **Data** - data patterns
* Example:

```dart
var array = AnyValueArray();
array = AnyValueArray([1, 2, 3]);
array = AnyValueArray.fromString('Fatal,Error,Info,', ',');

```

- **Errors** - application errors
* Example:

```dart
ApplicationException _appEx;
Exception _ex;
var Category = 'category';
var CorrelationId = 'correlationId';
var Code = 'code';
var Message = 'message';
_ex = Exception('Cause exception');
_appEx = ApplicationException(Category, CorrelationId, Code, Message);
_appEx.withCause(_ex);
var newCorrelationId = 'newCorrelationId';
var appEx = _appEx.withCorrelationId(newCorrelationId);
```

- **Random** - random data generators
* Example:

```dart
var value = RandomInteger.nextInteger(5);
value = RandomInteger.nextInteger(2, 5);
//-------------------------------------------
var interval = RandomDuration.nextDuration(
          Duration(milliseconds: 10000), Duration(milliseconds: 15000));
//-------------------------------------------
var value = RandomBoolean.chance(5, 10);
//-------------------------------------------
var array = [1, 2];
var value = RandomArray.pick<int>(array);
```

- **Refer** - locator (IoC) pattern
* Example:

```dart
var descriptor =
          Descriptor('pip-dummies', 'controller', 'default', 'default', '1.0');
var res = descriptor.toString(); // pip-dummies:controller:default:default:1.0
//-----------------------------------------------------------------------------

var ref1 = {'test': 'val1'};
      var ref2 = {'temp': 'value'};
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

resolver.getOneRequired('ref1'); // ref1
resolver.getOneRequired('ref2'); // ref2
resolver.getOneOptional('ref3'); // null

```

- **Reflect** - reflection framework
* Example:

```dart
var obj = TestClass();
var value = ObjectReader.getProperty(obj, 'privateField'); // null

value = ObjectReader.getProperty(obj, 'publicField'); // 'ABC'
value = ObjectReader.getProperty(obj, 'PublicProp');  // not null
```

- **Run** - execution framework
* Example:

```dart
// FixedRateTimer
class TestTimer implements INotifiable {
  int counter = 0;
  void notify(String? correlationId, Parameters args) {
    counter++;
  }
}

var notifier = TestTimer();
var timer = FixedRateTimer(notifier, 100, 0);
timer.start();
//-------------------------------------------------
// Parameters
var result = Parameters.fromTuples(['value1', 123, 'value2', 234]);
var defaults = Parameters.fromTuples(['value2', 432, 'value3', 345]);
result = result.setDefaults(defaults, false);
result['value1'] // 123
result['value2'] // 234
result['value3'] // 345

```

- **Validate** - validation framework
* Example:

```dart
class TestObject {
  TestObject() {
    mapProperty['Key1'] = 111;
    mapProperty['Key2'] = 222;
  }

  int _privateField = 124;
  String _privateProperty = 'XYZ';

  int intField = 12345;
  String stringProperty = 'ABC';
  dynamic nullProperty;
  List<int> intArrayProperty = [1, 2, 3];
  List<String> stringListProperty = ['AAA', 'BBB'];
  Map<String, int> mapProperty = {};
  TestSubObject subObjectProperty = TestSubObject('1');
  List<TestSubObject> subArrayProperty = [
    TestSubObject('2'),
    TestSubObject('3')
  ];
}
//------------------------------------------
var schema = ObjectSchema()
          .withOptionalProperty('_privateField')
          .withOptionalProperty('_privateProperty')
          .withOptionalProperty('intField')
          .withOptionalProperty('stringProperty')
          .withOptionalProperty('nullProperty')
          .withOptionalProperty('intArrayProperty')
          .withOptionalProperty('stringListProperty')
          .withOptionalProperty('mapProperty')
          .withOptionalProperty('subObjectProperty')
          .withOptionalProperty('subArrayProperty');

var obj = TestObject();
var results = schema.validate(obj); // results.length is 0, all rules good

```

In the help for each class there is a general example of its use. Also one of the quality sources are the source code for the [**tests**](https://github.com/pip-services3-dart/pip-services3-commons-dart/tree/master/test).

