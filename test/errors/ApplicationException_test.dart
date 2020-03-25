import "package:test/test.dart";

import "../../lib/src/errors/ApplicationException.dart";
//import "../../lib/src/data/StringValueMap.dart";

void main () {
  group('ApplicationException', () {
      ApplicationException _appEx;
      Exception _ex;

      var Category = "category";
      var CorrelationId = "correlationId";
      var Code = "code";
      var Message = "message";

      setUp(() {
          _ex = new Exception("Cause exception");

          _appEx = new ApplicationException(Category, CorrelationId, Code, Message);
      });

      test('With Cause', () {
          _appEx.withCause(_ex);

          expect(_appEx.cause, equals(_ex.toString()));
      });

      test('Check Parameters', () {
          expect(_appEx.category, equals(Category));
          expect(_appEx.correlation_id, equals(CorrelationId));
          expect(_appEx.code, equals(Code));
          expect(_appEx.message, equals(Message));
      });

      test('With Code', () {
          var newCode = "newCode";
          var appEx = _appEx.withCode(newCode);

          expect(appEx, equals(_appEx));
          expect(appEx.code, equals(newCode));
      });

      test('With CorrelationId', () {
          var newCorrelationId = "newCorrelationId";
          var appEx = _appEx.withCorrelationId(newCorrelationId);

          expect(appEx, equals(_appEx));
          expect(appEx.correlation_id, equals(newCorrelationId));
      });

      test('With Status', () {
          var newStatus = 777;
          var appEx = _appEx.withStatus(newStatus);

          expect(appEx, equals(_appEx));
          expect(appEx.status, equals(newStatus));
      });

      test('With Details', () {
          var key = "key";
          var obj = {};

          var appEx = _appEx.withDetails(key, obj);

          //var newObj = appEx.details.getAsObject(key);

          expect(appEx, equals(_appEx));
      });

      test('With Stack Trace', () {
          var newTrace = "newTrace";
          var appEx = _appEx.withStackTrace(newTrace);

          expect(appEx, equals(_appEx));
          expect(appEx.stack_trace, equals(newTrace));
      });

  });
}