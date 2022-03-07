import 'package:alpaka_clicker/initialize/initializer.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggerInitializer extends Initializer {
  @override
  Future<void> call() async {
    Logger.root.level = (kDebugMode) ? Level.ALL : Level.OFF;
  }
}
