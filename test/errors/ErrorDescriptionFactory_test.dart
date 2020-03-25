import "package:test/test.dart";

import "../../lib/src/errors/ErrorCategory.dart";
import "../../lib/src/errors/ErrorDescriptionFactory.dart";
import "../../lib/src/errors/ApplicationException.dart";

void main() {
  group('ErrorDescriptionFactory', () {

      test('Create From ApplicationException', () {
          var key = "key";
          var details = "details";

          var ex = new ApplicationException("category", "correlationId", "code", "message");
          ex.status  = 777;
          ex.cause = "cause";
          ex.stack_trace = "stackTrace";
          ex.withDetails(key, details);

          var descr = ErrorDescriptionFactory.create(ex);

          expect(descr, isNotNull);
          expect(descr.category, equals(ex.category));
          expect(descr.correlation_id, equals(ex.correlation_id));
          expect(descr.code, equals(ex.code));
          expect(descr.message, equals(ex.message));
          expect(descr.status, equals(ex.status));
          expect(descr.cause, equals(ex.cause));
          expect(descr.stack_trace, equals(ex.stack_trace));
          expect(descr.details, equals(ex.details));
      });

      test('Create From Error', () {
          var ex = new Exception("message");

          var descr = ErrorDescriptionFactory.create(ex);

          expect(descr, isNotNull);
          expect(descr.category, equals(ErrorCategory.Unknown));
          expect(descr.code, equals("UNKNOWN"));
          expect(descr.message, equals(ex.toString()));
          expect(descr.status, equals(500));
          expect(descr.stack_trace, isNull);
      });

  });
}