import 'dart:convert';
import 'package:test/test.dart';

import '../../lib/src/errors/ApplicationException.dart';
//import '../../lib/src/data/StringValueMap.dart';

void main() {
  group('ApplicationException', () {
    ApplicationException? _appEx;
    Exception? _ex;

    var Category = 'category';
    var CorrelationId = 'correlationId';
    var Code = 'code';
    var Message = 'message';

    setUp(() {
      _ex = Exception('Cause exception');

      _appEx = ApplicationException(Category, CorrelationId, Code, Message);
    });

    test('With Cause', () {
      _appEx!.withCause(_ex);

      expect(_appEx!.cause, equals(_ex.toString()));
    });

    test('Check Parameters', () {
      expect(_appEx, isNotNull);
      expect(_appEx!.category, equals(Category));
      expect(_appEx!.correlation_id, equals(CorrelationId));
      expect(_appEx!.code, equals(Code));
      expect(_appEx!.message, equals(Message));
    });

    test('With Code', () {
      var newCode = 'newCode';
      var appEx = _appEx!.withCode(newCode);

      expect(appEx, equals(_appEx));
      expect(appEx.code, equals(newCode));
    });

    test('With CorrelationId', () {
      var newCorrelationId = 'newCorrelationId';
      var appEx = _appEx!.withCorrelationId(newCorrelationId);

      expect(appEx, equals(_appEx));
      expect(appEx.correlation_id, equals(newCorrelationId));
    });

    test('With Status', () {
      var newStatus = 777;
      var appEx = _appEx!.withStatus(newStatus);

      expect(appEx, equals(_appEx));
      expect(appEx.status, equals(newStatus));
    });

    test('With Details', () {
      var key = 'key';
      var obj = {};

      var appEx = _appEx!.withDetails(key, obj);

      //var newObj = appEx.details.getAsObject(key);

      expect(appEx, equals(_appEx));
    });

    test('With Stack Trace', () {
      var newTrace = 'newTrace';
      var appEx = _appEx!.withStackTrace(newTrace);

      expect(appEx, equals(_appEx));
      expect(appEx.stack_trace, equals(newTrace));
    });

    test('JSON serialization', () {
      var key = 'key';
      var details = 'details';

      expect(_appEx, isNotNull);

      _appEx!.category = 'category';
      _appEx!.correlation_id = 'correlationId';
      _appEx!.code = 'code';
      _appEx!.message = 'message';
      _appEx!.status = 777;
      _appEx!.cause = 'cause';
      _appEx!.stack_trace = 'stackTrace';
      _appEx!.withDetails(key, details);

      var json = jsonEncode(_appEx);
      var appEx2 = ApplicationException.fromJson(jsonDecode(json));

      expect(appEx2, isNotNull);
      expect(appEx2.category, equals(_appEx!.category));
      expect(appEx2.correlation_id, equals(_appEx!.correlation_id));
      expect(appEx2.code, equals(_appEx!.code));
      expect(appEx2.message, equals(_appEx!.message));
      expect(appEx2.status, equals(_appEx!.status));
      expect(appEx2.cause, equals(_appEx!.cause));
      expect(appEx2.stack_trace, equals(_appEx!.stack_trace));
      expect(appEx2.details, equals(_appEx!.details!.getValue()));
    });
  });
}
