import 'dart:async';

import '../../lib/src/run/IExecutable.dart';
import '../../lib/src/run/Parameters.dart';

class CommandExec implements IExecutable {
  Future<dynamic> execute(String correlationId, Parameters args) async {
    if (correlationId == 'wrongId') throw Exception('Test error');

    return await Future.value(123);
  }
}
