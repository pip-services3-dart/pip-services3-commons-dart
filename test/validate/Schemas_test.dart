import 'package:test/test.dart';
import './TestObject.dart';
import './TestSubObject.dart';

import '../../lib/src/validate/Schema.dart';
import '../../lib/src/validate/ObjectSchema.dart';
import '../../lib/src/validate/ArraySchema.dart';
import '../../lib/src/validate/MapSchema.dart';
import '../../lib/src/convert/TypeCode.dart';

void main() {
  group('SchemasTest', () {
    test('Test empty schema', () {
      var schema = new ObjectSchema();
      var results = schema.validate(null);
      expect(results.length, 0);
    });

    test('Test required', () {
      var schema = new Schema().makeRequired();
      var results = schema.validate(null);
      expect(results.length, 1);
    });

    test('Test unexpected', () {
      var schema = new ObjectSchema();
      var obj = new TestObject();
      var results = schema.validate(obj);
      expect(results.length, 8); //10  (2 private fields are not access)
    });

    test('Test optional properties', () {
      var schema = new ObjectSchema()
          .withOptionalProperty("intField")
          .withOptionalProperty("stringProperty")
          .withOptionalProperty("nullProperty")
          .withOptionalProperty("intArrayProperty")
          .withOptionalProperty("stringListProperty")
          .withOptionalProperty("mapProperty")
          .withOptionalProperty("subObjectProperty")
          .withOptionalProperty("subArrayProperty");

      var obj = new TestObject();
      var results = schema.validate(obj);
      expect(results.length, 0); // 2
    });

    test('Test required properties', () {
      var schema = new ObjectSchema()
          // .withRequiredProperty("privateField")
          // .withRequiredProperty("privateProperty")
          .withRequiredProperty("intField")
          .withRequiredProperty("stringProperty")
          .withRequiredProperty("nullProperty")
          .withRequiredProperty("intArrayProperty")
          .withRequiredProperty("stringListProperty")
          .withRequiredProperty("mapProperty")
          .withRequiredProperty("subObjectProperty")
          .withRequiredProperty("subArrayProperty");

      var obj = new TestObject();
      obj.subArrayProperty = null;

      var results = schema.validate(obj);
      expect(results.length, 2);
    });

    test('Test types', () {
      var schema = new ObjectSchema()
          // .withRequiredProperty("privateField")
          // .withRequiredProperty("privateProperty")
          .withRequiredProperty("intField", TypeCode.Long)
          .withRequiredProperty("stringProperty", TypeCode.String)
          .withOptionalProperty("nullProperty", TypeCode.Object)
          .withRequiredProperty("intArrayProperty", TypeCode.Array)
          .withRequiredProperty("stringListProperty", TypeCode.Array)
          .withRequiredProperty("mapProperty", TypeCode.Map)
          .withRequiredProperty("subObjectProperty", TypeCode.Object) // Map
          .withRequiredProperty("subArrayProperty", TypeCode.Array);

      var obj = new TestObject();
      var results = schema.validate(obj);
      expect(results.length, 0);
    });

    test('Test sub schema', () {
      var sunSchema = new ObjectSchema()
          .withRequiredProperty("id", TypeCode.String)
          .withRequiredProperty("floatField", TypeCode.Double)
          .withOptionalProperty("nullProperty", TypeCode.Map);

      var schema = new ObjectSchema()
          // .withRequiredProperty("privateField")
          // .withRequiredProperty("privateProperty")
          .withRequiredProperty("intField", TypeCode.Long)
          .withRequiredProperty("stringProperty", TypeCode.String)
          .withOptionalProperty("nullProperty", TypeCode.Object)
          .withRequiredProperty("intArrayProperty", TypeCode.Array)
          .withRequiredProperty("stringListProperty", TypeCode.Array)
          .withRequiredProperty("mapProperty", TypeCode.Map)
          .withRequiredProperty("subObjectProperty", sunSchema)
          .withRequiredProperty("subArrayProperty", TypeCode.Array);

      var obj = new TestObject();
      var results = schema.validate(obj);
      expect(results.length, 0);
    });

    test('Test array and map schemas', () {
      var sunSchema = new ObjectSchema()
          .withRequiredProperty("id", TypeCode.String)
          .withRequiredProperty("floatField", TypeCode.Double)
          .withOptionalProperty("nullProperty", TypeCode.Map);

      var schema = new ObjectSchema()
          // .withRequiredProperty("privateField")
          // .withRequiredProperty("privateProperty")
          .withRequiredProperty("intField", TypeCode.Long)
          .withRequiredProperty("stringProperty", TypeCode.String)
          .withOptionalProperty("nullProperty", TypeCode.Object)
          .withRequiredProperty(
              "intArrayProperty", new ArraySchema(TypeCode.Long))
          .withRequiredProperty(
              "stringListProperty", new ArraySchema(TypeCode.String))
          .withRequiredProperty(
              "mapProperty", new MapSchema(TypeCode.String, TypeCode.Long))
          .withRequiredProperty("subObjectProperty", sunSchema)
          .withRequiredProperty("subArrayProperty", TypeCode.Array);

      var obj = new TestObject();
      var results = schema.validate(obj);
      expect(results.length, 0);
    });
  });
}
