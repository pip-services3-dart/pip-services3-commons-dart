class TestClass {
  int _privateField = 123;
  String publicField = 'ABC';
  DateTime _publicProp = DateTime.now().toUtc();

  TestClass([int arg1]);

  int get _privateProp {
    return 543;
  }

  set _privateProp(int value) {}

  DateTime get publicProp {
    return _publicProp;
  }

  set publicProp(DateTime value) {
    _publicProp = value;
  }

  void _privateMethod() {}

  int publicMethod(int arg1, int arg2) {
    return arg1 + arg2;
  }
}
