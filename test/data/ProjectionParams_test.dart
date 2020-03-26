import 'package:test/test.dart';
import '../../lib/src/data/ProjectionParams.dart';

void main() {
  group('ProjectionParams', () {
    test('From Null', () {
      var parameters = new ProjectionParams(null);

      expect(parameters.length, 0);
    });

    test('From Value', () {
      var parameters =
          ProjectionParams.fromValue(["field1", "field2", "field3"]);

      expect(parameters.length, 3);
      expect("field1", parameters[0]);
      expect("field2", parameters[1]);
      expect("field3", parameters[2]);
    });

    test('Convert to string', () {
      var parameters =
          ProjectionParams.fromValue(["field1", "field2", "field3"]);

      //expect(typeof(parameters.toString()), "string");
      expect((parameters.toString() is String), isTrue);
      expect(parameters.toString(), "field1,field2,field3");
    });

    test('Parse', () {
      var parameters =
          ProjectionParams.fromString(["field1", "field2", "field3"]);

      expect(3, parameters.length);
      expect("field1", parameters[0]);
      expect("field2", parameters[1]);
      expect("field3", parameters[2]);

      parameters = ProjectionParams.fromString(["field1,field2, field3"]);

      expect(3, parameters.length);
      expect("field1", parameters[0]);
      expect("field2", parameters[1]);
      expect("field3", parameters[2]);

      parameters = ProjectionParams.fromString(
          ["object1(field1)", "object2(field1, field2)", "field3"]);

      expect(4, parameters.length);
      expect("object1.field1", parameters[0]);
      expect("object2.field1", parameters[1]);
      expect("object2.field2", parameters[2]);
      expect("field3", parameters[3]);

      parameters = ProjectionParams.fromString(
          ["object1(object2(field1,field2,object3(field1)))"]);

      expect(3, parameters.length);
      expect("object1.object2.field1", parameters[0]);
      expect("object1.object2.field2", parameters[1]);
      expect("object1.object2.object3.field1", parameters[2]);

      parameters = ProjectionParams.fromString([
        "object1(field1, object2(field1, field2, field3, field4), field3)",
        "field2"
      ]);

      expect(7, parameters.length);
      expect("object1.field1", parameters[0]);
      expect("object1.object2.field1", parameters[1]);
      expect("object1.object2.field2", parameters[2]);
      expect("object1.object2.field3", parameters[3]);
      expect("object1.object2.field4", parameters[4]);
      expect("object1.field3", parameters[5]);
      expect("field2", parameters[6]);

      parameters = ProjectionParams.fromString(
          ["object1(field1, object2(field1), field3)", "field2"]);

      expect(4, parameters.length);
      expect("object1.field1", parameters[0]);
      expect("object1.object2.field1", parameters[1]);
      expect("object1.field3", parameters[2]);
      expect("field2", parameters[3]);

      parameters = ProjectionParams.fromString([
        "object1(field1, object2(field1, field2, object3(field1), field4), field3)",
        "field2"
      ]);

      expect(7, parameters.length);
      expect("object1.field1", parameters[0]);
      expect("object1.object2.field1", parameters[1]);
      expect("object1.object2.field2", parameters[2]);
      expect("object1.object2.object3.field1", parameters[3]);
      expect("object1.object2.field4", parameters[4]);
      expect("object1.field3", parameters[5]);
      expect("field2", parameters[6]);

      parameters = ProjectionParams.fromString(
          ["object1(object2(object3(field1)), field2)", "field2"]);

      expect(3, parameters.length);
      expect("object1.object2.object3.field1", parameters[0]);
      expect("object1.field2", parameters[1]);
      expect("field2", parameters[2]);

      parameters = ProjectionParams.fromString([
        "field1,object1(field1),object2(field1,field2),object3(field1),field2,field3"
      ]);

      expect(7, parameters.length);
      expect("field1", parameters[0]);
      expect("object1.field1", parameters[1]);
      expect("object2.field1", parameters[2]);
      expect("object2.field2", parameters[3]);
      expect("object3.field1", parameters[4]);
      expect("field2", parameters[5]);
      expect("field3", parameters[6]);
    });
  });
}
