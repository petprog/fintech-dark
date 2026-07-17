import 'package:flutter/foundation.dart';

import 'log_tree.dart';

class ConsoleLogTree implements LogTree {
  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer();

    buffer.write('[${level.name.toUpperCase()}] ');

    buffer.write(message);

    if (error != null) {
      buffer.write('\nError: $error');
    }

    if (stackTrace != null) {
      buffer.write('\nStackTrace:\n$stackTrace');
    }

    debugPrint(buffer.toString());
  }
}
