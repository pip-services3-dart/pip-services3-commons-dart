class TestSubObject {
  String _id;
  dynamic _nullProperty;

  TestSubObject(String id) {
    this.id = id;
  }

  String get id {
    return _id;
  }

  set id(String value) {
    _id = value;
  }

  double floatField = 432.1;

  dynamic get nullProperty {
    return _nullProperty;
  }

  set nullProperty(dynamic value) {
    _nullProperty = value;
  }
}
