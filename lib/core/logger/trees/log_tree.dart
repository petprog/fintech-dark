abstract interface class LogTree {
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  });
}

enum LogLevel { debug, info, warning, error }
