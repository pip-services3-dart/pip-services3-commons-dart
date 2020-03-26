import 'dart:async';

import '../../lib/src/run/IExecutable.dart';
import '../../lib/src/run/Parameters.dart';

class CommandExec implements IExecutable {
  Future<dynamic> execute(String correlationId, Parameters args) async {
    if (correlationId == "wrongId") throw new Exception("Test error");

    return await new Future.value(123);
  }
}
