import './TestSubObject.dart';

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
