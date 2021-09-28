import 'package:pip_services3_commons/src/data/data.dart';
import 'package:pip_services3_commons/src/errors/errors.dart';
import 'package:test/test.dart';

void main() {
  group('ApplicationExceptionFactory', () {
    ErrorDescription? _descr;

    var checkProperties = (ApplicationException ex) {
      expect(ex, isNotNull);

      expect(ex.cause, equals(_descr!.cause));
      expect(ex.stack_trace, equals(_descr!.stack_trace));
      //expect(ex.details, equals(_descr.details));
      expect(ex.category, equals(_descr!.category));
    };

    setUp(() {
      _descr = ErrorDescription();
      _descr!.correlation_id = 'correlationId';
      _descr!.code = 'code';
      _descr!.message = 'message';
      _descr!.status = 777;
      _descr!.cause = 'cause';
      _descr!.stack_trace = 'stackTrace';

      var map = StringValueMap();
      map.put('key', 'value');
      _descr!.details = map;
    });

    test('Create From Unknown', () {
      _descr!.category = ErrorCategory.Unknown;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<UnknownException>());
    });

    test('Create From Internal', () {
      _descr!.category = ErrorCategory.Internal;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<InternalException>());
    });

    test('Create From Misconfiguration', () {
      _descr!.category = ErrorCategory.Misconfiguration;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<ConfigException>());
    });

    test('Create From No Response', () {
      _descr!.category = ErrorCategory.NoResponse;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<ConnectionException>());
    });

    test('Create From Failed Invocation', () {
      _descr!.category = ErrorCategory.FailedInvocation;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<InvocationException>());
    });

    test('Create From No File Access', () {
      _descr!.category = ErrorCategory.FileError;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<FileException>());
    });

    test('Create From Bad Request', () {
      _descr!.category = ErrorCategory.BadRequest;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<BadRequestException>());
    });

    test('Create From From Unauthorized', () {
      _descr!.category = ErrorCategory.Unauthorized;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<UnauthorizedException>());
    });

    test('Create From Conflict', () {
      _descr!.category = ErrorCategory.Conflict;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<ConflictException>());
    });

    test('Create From Not Found', () {
      _descr!.category = ErrorCategory.NotFound;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<NotFoundException>());
    });

    test('Create From Unsupported', () {
      _descr!.category = ErrorCategory.Unsupported;

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<UnsupportedException>());
    });

    test('Create From Default', () {
      _descr!.category = 'any_other';

      var ex = ApplicationExceptionFactory.create(_descr!);

      checkProperties(ex);

      expect(ex, TypeMatcher<UnknownException>());
    });
  });
}
