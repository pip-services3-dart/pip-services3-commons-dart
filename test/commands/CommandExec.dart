import 'dart:async';

import 'package:pip_services3_commons/src/run/run.dart';

class CommandExec implements IExecutable {
  @override
  Future<dynamic> execute(String? correlationId, Parameters args) async {
    if (correlationId == 'wrongId') throw Exception('Test error');

    return await Future.value(123);
  }
}
