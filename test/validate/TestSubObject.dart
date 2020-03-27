class TestSubObject {
  String _id;
  dynamic _nullProperty = null;

  TestSubObject(String id) {
    this.id = id;
  }

  String get id {
    return this._id;
  }

  set id(String value) {
    this._id = value;
  }

  double floatField = 432.1;

  dynamic get nullProperty {
    return this._nullProperty;
  }

  set nullProperty(dynamic value) {
    this._nullProperty = value;
  }
}
