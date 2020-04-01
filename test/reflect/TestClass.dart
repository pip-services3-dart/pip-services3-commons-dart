class TestClass {
  int _privateField = 123;
  String publicField = 'ABC';
  DateTime _publicProp = DateTime.now();

  TestClass([int arg1 = null]) {}

  int get _privateProp {
    return 543;
  }

  set _privateProp(int value) {}

  DateTime get publicProp {
    return this._publicProp;
  }

  set publicProp(DateTime value) {
    this._publicProp = value;
  }

  void _privateMethod() {}

  int publicMethod(int arg1, int arg2) {
    return arg1 + arg2;
  }
}
